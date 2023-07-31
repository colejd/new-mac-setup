function show_desktop {
	defaults write com.apple.finder CreateDesktop -bool true && killall Finder
}
_show_desktop() { # Autocomplete function definition
    _arguments  # No arguments
}
compdef _show_desktop show_desktop

function hide_desktop {
	defaults write com.apple.finder CreateDesktop -bool false && killall Finder
}
_hide_desktop() { # Autocomplete function definition
    _arguments  # No arguments
}
compdef _hide_desktop hide_desktop

function show_hidden {
	defaults write com.apple.Finder AppleShowAllFiles YES && killall Finder
}
_show_hidden() { # Autocomplete function definition
    _arguments  # No arguments
}
compdef _show_hidden show_hidden

function hide_hidden {
	defaults write com.apple.Finder AppleShowAllFiles NO && killall Finder
}
_hide_hidden() { # Autocomplete function definition
    _arguments  # No arguments
}
compdef _hide_hidden hide_hidden
