#!/bin/zsh

# Prompt function to ask for user input
function prompt() {
    read -p "$1 [y/N]: " response
    if [[ $response =~ ^[Yy]$ ]]; then
        return 0
    else
        return 1
    fi
}

# Check if Xcode is installed before continuing.
if xcode-select --install 2>&1 | grep installed; then
    echo "Xcode and command line tools are installed, proceeding..."
else
    echo "Install Xcode command line tools first! You should have just gotten a prompt to install them. Finish that process and then re-run this script."
    exit
fi

# Install Homebrew
if prompt "Do you want to install Homebrew?"; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    read -p "Follow the Homebrew instructions above in another terminal window, then press any key to continue..."
    
    # Reloads current terminal window with Homebrew changes
    source ~/.zshrc
    source ~/.zprofile
    
    echo "Homebrew installed."
else
    echo "Skipping Homebrew installation."
fi

# Do brew cask installs here
if prompt "Do you want to install QuicklookStephen?"; then
    echo "Installing QuicklookStephen..."
    brew install --cask qlstephen
    xattr -cr ~/Library/QuickLook/QLStephen.qlgenerator
    qlmanage -r
    qlmanage -r cache
    
    echo "QuicklookStephen installed."
else
    echo "Skipping QuicklookStephen installation."
fi

echo "Go download OpenInTerminal-Lite!"
echo "https://github.com/Ji4n1ng/OpenInTerminal"

if prompt "Do you want to install BlackHole?"; then
    echo "Installing BlackHole..."
    brew install blackhole-2ch
    echo "BlackHole is now installed. Point iOS Simulator's audio output to BlackHole to fix crackling audio on Macbook Speakers while the simulator is open."
else
    echo "Skipping BlackHole installation."
fi

echo "Script execution completed."
