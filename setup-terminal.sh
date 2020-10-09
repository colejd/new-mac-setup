#!/usr/bin/env bash

mkdir temp

# Install Oh My ZSH (https://github.com/robbyrussell/oh-my-zsh)
echo "Installing Oh My ZSH..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install Fira Code font (https://github.com/tonsky/FiraCode)
echo "Installing Fira Code font..."
curl "https://github.com/tonsky/FiraCode/releases/download/1.207/FiraCode_1.207.zip" -o ./temp/fira.zip -J -L
unzip ./temp/fira.zip ./temp/fira
cp ./temp/fira/ttf/FiraCode-Retina.ttf ~/Library/Fonts/FiraCode-Retina.ttf

# Install spaceship prompt (https://github.com/denysdovhan/spaceship-prompt)
echo "Installing Spaceship prompt..."
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install zsh-autosuggestions (https://github.com/zsh-users/zsh-autosuggestions)
echo "Installing zsh-autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install zsh-syntax-highlighting (https://github.com/zsh-users/zsh-syntax-highlighting)
echo "Installing zsh-syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

###############################################################################
# Git init                                                                    #
###############################################################################

git config --global user.name "Jonathan Cole"
git config --global user.email ""
# Set up global gitignore
cp ./files/gitignore_global ~/.gitignore_global
git config --global core.excludesfile "~/.gitignore_global"
# Use SSH by default when authenticating in git
git config --global --add url."git@github.com".insteadOf "https://github.com/"

###############################################################################
# Terminal                                                                    #
###############################################################################

# Use a custom theme by default in Terminal.app
osascript <<EOD
tell application "Terminal"
	local allOpenedWindows
	local initialOpenedWindows
	local windowID
	set themeName to "Spaceship"
	(* Store the IDs of all the open terminal windows. *)
	set initialOpenedWindows to id of every window
	(* Open the custom theme so that it gets added to the list
	   of available terminal themes (note: this will open two
	   additional terminal windows). *)
	do shell script "open '$HOME/setup/files/" & themeName & ".terminal'"
	(* Wait a little bit to ensure that the custom theme is added. *)
	delay 1
	(* Set the custom theme as the default terminal theme. *)
	set default settings to settings set themeName
end tell
EOD

###############################################################################
# Install helper scripts                                                      #
###############################################################################

mkdir -p ~/Dev/Resources/Tools/Scripts
cp -R ./files/scripts ~/Dev/Resources/Tools/Scripts

###############################################################################
# Clean up                                                                    #
###############################################################################
rm -rf ./temp

echo "Done!"
