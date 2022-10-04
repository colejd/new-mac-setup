This repo contains a shell script and resources to set up a new computer the way I like it.

I built this for personal use, and am releasing this publicly to help out anyone else who might want to draw inspiration - **I assume no liability for any damage these scripts may cause to your machine!**

## Usage

- Install an Xcode version at https://developer.apple.com/download/applications/
- Launch Xcode once and follow instructions until you get to the "Welcome to Xcode" landing screen, then close Xcode.
- Install the command line tools by running `xcode-select --install` in the terminal
- Accept the command line tools EULA by running `sudo xcodebuild -license` in the terminal
- Clone this repo.

There are a few scripts in here to run:
- `setup-macos.zsh`: Run this first. Modifies MacOS preferences and sets up folder structure.
- `setup-terminal.zsh`: Sets up the terminal just the way I like it, along with some good utility scripts for iOS development.
    * This one involves a bunch of network requests, so be careful that they're all still correct when you run this.

## Also Included
### Hammerspoon
I include a Hammerspoon init that contains utilities I use. Among them is system-wide push to talk, with an overlay that appears when the microphone is off.

### Whitefox Layout
If you have a Vanilla Whitefox keyboard and you're using my Hammerspoon scripts, this is for you. [whitefox-vanilla-macos.json](/files/optional/whitefox-vanilla-macos.json) is a Kiibohd layout file that makes the keyboard just the way I like it on MacOS, with some modification for quick-toggling the mute scripts introduced in my Hammerspoon scripts. This layout is based on https://github.com/boyvanamstel/Whitefox-keyboard-macOS-configuration.

![alt text][whitefox-preview]

### New File Here
A small utility you can keep in the toolbar of your Finder windows. Creates a new file in the topmost Finder window with a blank name.

## Links
* https://github.com/mathiasbynens/dotfiles/blob/master/.macos
* https://pawelgrzybek.com/change-macos-user-preferences-via-command-line/


<!-- References for links -->
[whitefox-preview]: /misc/whitefox-layout-preview.png "Whitefox Layout Preview"
