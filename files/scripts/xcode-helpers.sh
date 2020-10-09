# xcode-helpers.sh
# 
# Installation:
# Add this line to your .zshrc, .bashrc or .bash-profile:
#
# source /path/to/xcode-helpers.sh

# used by ox function
function fuzzify
{
    string=$1
    fuzzyString=""
    separator=$2
    if [[ -z $2 ]]; then
        separator=".*"
    fi
    while test -n "$string"; do
        c=${string:0:1}
        fuzzyString="$fuzzyString$c$separator"
        string=${string:1}
    done
    echo $fuzzyString
}

# Opens the Xcode project or workspace in the current folder.
# If you pass a fuzzy path, it will open that instead.
# Example: ox apl/util/myap will open Application/Utility/MyApp.xcodeproj (if it exists). Useful for multi-project repos.
function ox
{
    xcodePath=`xcode-select -print-path`/../..
    if [[ ! -e $xcodePath ]]; then
        echo "Whoa there pardner, you need to install Xcode first."
        return
    fi
    if [[ -z $1 ]]; then
        open -a $xcodePath . 2>&1 > /dev/null
    else
        if [[ -e $1 ]]; then
            open -a $xcodePath $1 2>&1 > /dev/null
        else
            fuzzyTerm=`fuzzify $1 '*'`
            searchPattern1="*$fuzzyTerm.*xcodeproj"
            searchPattern2="*$fuzzyTerm.*xcworkspace"
            fileName=`find . -iname "$searchPattern1" -o -iname "$searchPattern2"`
            fileName=$(echo $fileName | head -n 1)
            open -a $xcodePath $fileName 2>&1 > /dev/null
        fi
    fi
}

function _switchXcode
{
    sudo xcode-select -s "$1" && echo "Switched to `xcode-select -p`."
    ln -sf "$1" /Applications/Xcode.app
}

function xc
{
    _switchXcode /Applications/Xcode.app
}

function xcbeta
{
    _switchXcode /Applications/Xcode-beta.app
}

function xcodebrokeagain
{
    echo "Deleting derived data..."
    rm -rf ~/Library/Developer/Xcode/DerivedData
    echo "Derived data has been deleted."
}
