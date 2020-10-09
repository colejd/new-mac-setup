function show_desktop {
	defaults write com.apple.finder CreateDesktop -bool true && killall Finder
}

function hide_desktop {
	defaults write com.apple.finder CreateDesktop -bool false && killall Finder
}

function show_hidden {
	defaults write com.apple.Finder AppleShowAllFiles YES && killall Finder
}

function hide_hidden {
	defaults write com.apple.Finder AppleShowAllFiles NO && killall Finder
}