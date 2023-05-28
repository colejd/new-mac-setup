#!/bin/zsh

# Check if Xcode is installed before continuing.
if command -v xcode-select >/dev/null 2>&1 && xcode-select --install 2>&1 | grep installed; then
    echo "Xcode and command line tools are installed, proceeding..."
else
    echo "Install Xcode command line tools first! You should have just gotten a prompt to install them. Finish that process and then re-run this script."
    exit
fi

WORKING_DIRECTORY=$PWD

mkdir temp

# Define color variables
CYBERPUNK_BLUE='\033[38;5;39m'
SYNTHWAVE_PINK='\033[38;5;198m'
RETROWAVE_PURPLE='\033[38;5;129m'
GLOWING_GREEN='\033[38;5;118m'
BRIGHT_MAGENTA='\033[95m'
FALLBACK_MAGENTA='\033[38;5;165m'

# Install Oh My Zsh (https://github.com/ohmyzsh/ohmyzsh)
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended

# Install Fira Code font (https://github.com/tonsky/FiraCode)
echo "Installing Fira Code font..."
mkdir -p ~/Library/Fonts
curl -L "https://github.com/tonsky/FiraCode/releases/download/1.207/FiraCode_1.207.zip" -o ./temp/fira.zip
unzip -qo ./temp/fira.zip -d ./temp/fira
cp ./temp/fira/ttf/FiraCode-Retina.ttf ~/Library/Fonts/FiraCode-Retina.ttf
echo "Visit here to set up VS Code for the right font: https://github.com/tonsky/FiraCode/wiki/VS-Code-Instructions"

# Install spaceship prompt (https://github.com/denysdovhan/spaceship-prompt)
echo "Installing Spaceship prompt..."
git clone --depth=1 https://github.com/spaceship-prompt/spaceship-prompt.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt
ln -s ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt/spaceship.zsh-theme ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship.zsh-theme

# Install zsh-autosuggestions (https://github.com/zsh-users/zsh-autosuggestions)
echo "Installing zsh-autosuggestions..."
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

###############################################################################
# Git init                                                                    #
###############################################################################

if prompt "Do you want to initialize Git settings?"; then
    git config --global user.name "Jonathan Cole"
    git config --global user.email ""
    # Set up global gitignore
    cp ./files/gitignore_global ~/.gitignore_global
    git config --global core.excludesfile "~/.gitignore_global"
    # Use SSH by default when authenticating in git
    # git config --global --add url."git@github.com".insteadOf "https://github.com/"
else
    echo "Skipping Git initialization."
fi

###############################################################################
# Terminal                                                                    #
###############################################################################

if prompt "Do you want to customize Terminal settings?"; then
    # Choose color based on terminal capability
    if [ "$TERM" = "xterm-256color" ]; then
        MAGENTA=$FALLBACK_MAGENTA
    else
        MAGENTA=$BRIGHT_MAGENTA
    fi

    # Set the color scheme for different terminal outputs
    LS_COLORS="di=${CYBERPUNK_BLUE}:ln=${SYNTHWAVE_PINK}:so=${RETROWAVE_PURPLE}:pi=${GLOWING_GREEN}:ex=${CYBERPUNK_BLUE}:*.$"

    # Set the prompt dynamically based on the shell
    if [ -n "$BASH_VERSION" ]; then
        PS1='\[\033[1;37m\][\[\033[1;32m\]\u@\h\[\033[1;37m\]:\[\033[0;34m\]\w\[\033[1;37m\]]\[\033[0m\]\\$ '
    elif [ -n "$ZSH_VERSION" ]; then
        PS1='%F{white}[%F{green}%n@%m%f:%F{blue}%~%f]%F{white}%#%f '
    fi

    # Add color settings for .OLD and .PACNEW files
    if [ "$TERM" = "xterm-256color" ]; then
        LS_COLORS="${LS_COLORS}:*.OLD=${MAGENTA}:*.PACNEW=${MAGENTA}"
    fi

    # Export the LS_COLORS variable
    export LS_COLORS

    # Customize Terminal settings here
    osascript <<EOD
    tell application "Terminal"
        (* Store the IDs of all the open terminal windows. *)
        set initialOpenedWindows to id of every window
        (* Open the custom theme so that it gets added to the list
           of available terminal themes (note: this will open two
           additional terminal windows). *)
        do shell script "open '$WORKING_DIRECTORY/files/themeName.terminal'"
        (* Wait a little bit to ensure that the custom theme is added. *)
        delay 1
        (* Set the custom theme as the default terminal theme. *)
        set default settings to settings set themeName
    end tell
EOD
else
    echo "Skipping Terminal customization."
fi

###############################################################################
# Install helper scripts                                                      #
###############################################################################

if prompt "Do you want to install helper scripts?"; then
    mkdir -p ~/Dev/Resources/Tools/scripts
    cp -R ./files/scripts ~/Dev/Resources/Tools/
else
    echo "Skipping installation of helper scripts."
fi

###############################################################################
# Clean up                                                                    #
###############################################################################

rm -rf ./temp

echo "Done!"

# Prompt the user with a Yes/No question and return true for "Yes" and false for "No"
function prompt {
    local response
    read -q "response?$1 [Y/n] "
    echo
    [[ $response =~ ^(y|Y|)$ ]]
}
