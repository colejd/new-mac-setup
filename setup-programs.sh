#!/usr/bin/env bash


# Install Homebrew
echo "Installing Homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

read -p "Follow the Homebrew instructions above in another terminal window, then press any key to continue..."

# Reloads current terminal window with Homebrew changes (I think?)
source ~/.zshrc
source ~/.zprofile

# Do brew cask installs here

# Install QuicklookStephen
echo "Installing QuicklookStephen..."
brew install --cask qlstephen

echo "Go download TermHere!"
echo "https://github.com/hbang/TermHere"

brew install blackhole-2ch
echo "BlackHole is now installed. Point iOS Simulator's audio output to BlackHole to fix crackling audio on Macbook Speakers while the simulator is open."