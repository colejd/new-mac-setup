This repo contains a shell script and resources to set up a new computer the way I like it.

## Usage
Pull this repo into your home directory and name the directory "setup", then run setup.sh.
```
cd ~
git clone https://github.com/colejd/new-mac-setup.git setup
cd setup
sh ./setup.sh
```

You can also run `setup-terminal.sh` to auto-install dependencies that I use for the terminal. This one involves a bunch of network requests, so be careful that they're all still correct when you run this. You may not want to do this. **I assume no liability for any damage these scripts may cause to your machine!**

## Also Included
### Hammerspoon
I include a Hammerspoon init that contains utilities I use. Among them is system-wide push to talk, with an overlay that appears when the microphone is off.

### Whitefox Layout
If you have a Vanilla Whitefox keyboard and you're using my Hammerspoon scripts, this is for you. [whitefox-vanilla-macos.json](/files/whitefox-vanilla-macos.json) is a Kiibohd layout file that makes the keyboard just the way I like it on MacOS, with some modification for quick-toggling the mute scripts introduced in my Hammerspoon scripts. This layout is based on https://github.com/boyvanamstel/Whitefox-keyboard-macOS-configuration.

![alt text][whitefox-preview]

### New File Here
A small utility you can keep in the toolbar of your Finder windows. Creates a new file in the topmost Finder window with a blank name.

## Links
* https://github.com/mathiasbynens/dotfiles/blob/master/.macos
* https://pawelgrzybek.com/change-macos-user-preferences-via-command-line/


<!-- References for links -->
[whitefox-preview]: /misc/whitefox-layout-preview.png "Whitefox Layout Preview"
