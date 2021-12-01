#!/usr/bin/env bash


# Install Homebrew
echo "Installing Homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Do brew cask installs here

# Install QuicklookStephen
echo "Installing QuicklookStephen..."
brew cask install qlstephen

echo "Go download TermHere!"
echo "https://github.com/hbang/TermHere"

brew install blackhole-2ch
echo "BlackHole is now installed. Point iOS Simulator's audio output to BlackHole to fix crackling audio on Macbook Speakers while the simulator is open."