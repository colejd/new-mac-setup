#!/bin/zsh

###############################################################################
# Prompt Function                                                              #
###############################################################################

# Function to prompt the user for a yes/no decision
function prompt {
    while true; do
        read -p "$1 (y/n): " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer 'y' or 'n'.";;
        esac
    done
}

###############################################################################
# Make folder structure                                                       #
###############################################################################

if prompt "Do you want to create the folder structure?"; then
    echo "Creating folder structure..."
    
    mkdir ~/Dev
    mkdir ~/Dev/Projects
    mkdir ~/Dev/Resources
    mkdir ~/Pictures/Screenshots
    
    echo "Folder structure created."
else
    echo "Skipping folder structure creation."
fi

###############################################################################
# General UI/UX                                                               #
###############################################################################

if prompt "Do you want to configure general UI/UX settings?"; then
    echo "Configuring general UI/UX settings..."
    
    echo "Disabling sound effects on boot"
    sudo nvram SystemAudioVolume=" "

    # Enable dark mode
    defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

    # Expand save panel by default
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

    # Expand print panel by default
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

    # Save to disk (not to iCloud) by default
    defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

    # Reveal IP address, hostname, OS version, etc. when clicking the clock
    # in the login window
    sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

    # Disable auto-correct
    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

    # Disable automatic rearranging of Spaces based on most recent use
    defaults write com.apple.dock mru-spaces -bool false

    # Use scroll gesture with the Ctrl (^) modifier key to zoom
    defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
    defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
    # Follow the keyboard focus while zoomed in
    defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

    # Save screenshots to a given directory
    defaults write com.apple.screencapture location -string "${HOME}/Pictures/Screenshots"

    # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
    defaults write com.apple.screencapture type -string "png"

    # Disable shadow in screenshots
    defaults write com.apple.screencapture disable-shadow -bool true

    # Avoid creating .DS_Store files on network or USB volumes
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

    # Show the ~/Library folder
    chflags nohidden ~/Library && xattr -d com.apple.FinderInfo  ~/Library

    # Set finder search to search current directory by default
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

    # Set folders to open in new windows instead of new tabs
    defaults write com.apple.finder FinderSpawnTab -bool false

    echo "General UI/UX settings configured."
else
    echo "Skipping general UI/UX configuration."
fi

###############################################################################
# Trackpad                                                                    #
###############################################################################

if prompt "Do you want to configure trackpad settings?"; then
    echo "Configuring trackpad settings..."
    
    # Turn off natural scrolling
    defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

    # Turn off "force click to lookup"
    defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool false

    # Set trackpad cursor speed to my preferences
    # defaults write NSGlobalDomain com.apple.trackpad.scaling -float 1

    defaults write com.apple.AppleMultitouchTrackpad Clicking -bool false
    defaults write com.apple.AppleMultitouchTrackpad TrackpadRotate -bool false
    defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerDoubleTapGesture -bool false

    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool false
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRotate -bool false
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerDoubleTapGesture -bool false

    echo "Trackpad settings configured."
else
    echo "Skipping trackpad configuration."
fi

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

if prompt "Do you want to configure Dock, Dashboard, and hot corners?"; then
    echo "Configuring Dock, Dashboard, and hot corners..."
    
    # Automatically hide and show the Dock
    defaults write com.apple.dock autohide -bool true

    # Don’t show recent applications in Dock
    defaults write com.apple.dock show-recents -bool false

    echo "Dock, Dashboard, and hot corners configured."
else
    echo "Skipping Dock, Dashboard, and hot corners configuration."
fi

###############################################################################
# Spotlight                                                                   #
###############################################################################

if prompt "Do you want to configure Spotlight settings?"; then
    echo "Configuring Spotlight settings..."
    
    # Hide Spotlight tray-icon (and subsequent helper)
    # sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
    # Disable Spotlight indexing for any volume that gets mounted and has not yet
    # been indexed before.
    # Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
    # sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
    # Change indexing order and disable some search results
    defaults write com.apple.spotlight orderedItems -array \
        '{"enabled" = 1;"name" = "APPLICATIONS";}' \
        '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
        '{"enabled" = 1;"name" = "DIRECTORIES";}' \
        '{"enabled" = 1;"name" = "PDF";}' \
        '{"enabled" = 1;"name" = "FONTS";}' \
        '{"enabled" = 1;"name" = "DOCUMENTS";}' \
        '{"enabled" = 0;"name" = "MESSAGES";}' \
        '{"enabled" = 0;"name" = "CONTACT";}' \
        '{"enabled" = 0;"name" = "EVENT_TODO";}' \
        '{"enabled" = 0;"name" = "IMAGES";}' \
        '{"enabled" = 0;"name" = "BOOKMARKS";}' \
        '{"enabled" = 0;"name" = "MUSIC";}' \
        '{"enabled" = 0;"name" = "MOVIES";}' \
        '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
        '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
        '{"enabled" = 0;"name" = "SOURCE";}' \
        '{"enabled" = 1;"name" = "MENU_DEFINITION";}' \
        '{"enabled" = 0;"name" = "MENU_OTHER";}' \
        '{"enabled" = 1;"name" = "MENU_CONVERSION";}' \
        '{"enabled" = 1;"name" = "MENU_EXPRESSION";}' \
        '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
        '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
    
    # Load new settings before rebuilding the index
    killall mds > /dev/null 2>&1

    # Make sure indexing is enabled for the main volume
    sudo mdutil -i on / > /dev/null

    # Rebuild the index from scratch
    sudo mdutil -E / > /dev/null

    echo "Spotlight settings configured."
else
    echo "Skipping Spotlight configuration."
fi

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

if prompt "Do you want to configure Safari and WebKit settings?"; then
    echo "Configuring Safari and WebKit settings..."
    
    # Press Tab to highlight each item on a web page
    defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

    echo "Safari and WebKit settings configured."
else
    echo "Skipping Safari and WebKit configuration."
fi

###############################################################################
# Kill affected applications                                                  #
###############################################################################

if prompt "Do you want to restart affected applications?"; then
    echo "Restarting affected applications..."
    
    for app in "Activity Monitor" \
        "Address Book" \
        "Calendar" \
        "cfprefsd" \
        "Contacts" \
        "Dock" \
        "Finder" \
        "Messages" \
        "Photos" \
        "Safari" \
        "SystemUIServer"; do
        killall "${app}" &> /dev/null
    done

    echo "Affected applications restarted."
else
    echo "Skipping application restart."
fi

echo "Done. Note that some of these changes require a logout/restart to take effect."
