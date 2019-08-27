#!/usr/bin/env bash

# Install Oh My ZSH (https://github.com/robbyrussell/oh-my-zsh)
echo "Installing Oh My ZSH..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install spaceship prompt (https://github.com/denysdovhan/spaceship-prompt)
echo "Installing Spaceship prompt..."
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# Install Fira Code font (https://github.com/tonsky/FiraCode)
echo "Installing Fira Code font..."
wget "https://github.com/tonsky/FiraCode/releases/download/1.207/FiraCode_1.207.zip"

# Install zsh-autosuggestions (https://github.com/zsh-users/zsh-autosuggestions)
echo "Installing zsh-autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install zsh-syntax-highlighting (https://github.com/zsh-users/zsh-syntax-highlighting)
echo "Installing zsh-syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install Homebrew
echo "Installing Homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install QuicklookStephen
echo "Installing QuicklookStephen..."
brew cask install qlstephen

###############################################################################
# Git init                                                                    #
###############################################################################

git config --global user.name "Jonathan Cole"
git config --global user.email ""

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
	(* Get the IDs of all the currently opened terminal windows. *)
	set allOpenedWindows to id of every window
	repeat with windowID in allOpenedWindows
		(* Close the additional windows that were opened in order
		   to add the custom theme to the list of terminal themes. *)
		if initialOpenedWindows does not contain windowID then
			close (every window whose id is windowID)
		(* Change the theme for the initial opened terminal windows
		   to remove the need to close them in order for the custom
		   theme to be applied. *)
		else
			set current settings of tabs of (every window whose id is windowID) to settings set themeName
		end if
	end repeat
end tell
EOD

for app in "Terminal"; do
	killall "${app}" &> /dev/null
done

# Prompt for manual setup steps
echo " 
Done.

Manual steps to complete:
* Set the terminal font to Fira Code Retina 14pt.
* Copy the included zshrc file to ~/.zshrc. Make sure to set line 5 to your actual user folder name.
"