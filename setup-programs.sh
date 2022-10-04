#!/bin/zsh

# Check if Xcode is installed before continuing.
if xcode-select --install 2>&1 | grep installed; then
    echo "Xcode and command line tools are installed, proceeding..."
else
    echo "Install Xcode command line tools first! You should have just gotten a prompt to install them. Finish that process and then re-run this script."
    exit
fi

# Install Homebrew
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

read -p "Follow the Homebrew instructions above in another terminal window, then press any key to continue..."

# Reloads current terminal window with Homebrew changes (I think?)
source ~/.zshrc
source ~/.zprofile

# Do brew cask installs here

# Install QuicklookStephen (https://github.com/whomwah/qlstephen)
echo "Installing QuicklookStephen..."
brew install --cask qlstephen
xattr -cr ~/Library/QuickLook/QLStephen.qlgenerator
qlmanage -r
qlmanage -r cache

echo "Go download OpenInTerminal-Lite!"
echo "https://github.com/Ji4n1ng/OpenInTerminal"

brew install blackhole-2ch
echo "BlackHole is now installed. Point iOS Simulator's audio output to BlackHole to fix crackling audio on Macbook Speakers while the simulator is open."