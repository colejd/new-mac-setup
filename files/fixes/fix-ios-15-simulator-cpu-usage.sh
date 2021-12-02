#!/usr/bin/env bash

# This script disables Spotlight on iOS Simulators, which will
# use 100% CPU due to an iOS 15-adjacent bug.
# https://developer.apple.com/forums/thread/683277

cd ~/Library/Developer/Xcode/UserData/Previews/Simulator\ Devices/
find . -name com.apple.suggestions.plist -exec plutil -replace SuggestionsAppLibraryEnabled -bool NO {} ";"
cd -
echo "Done!"