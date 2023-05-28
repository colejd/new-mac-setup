#!/bin/zsh

# Prompt function to ask for user input
function prompt() {
    read -p "$1 [y/N]: " response
    if [[ $response =~ ^[Yy]$ ]]; then
        return 0
    else
        return 1
    fi
}

# Check if Xcode is installed before continuing.
if xcode-select --install 2>&1 | grep installed; then
    echo "Xcode and command line tools are installed, proceeding..."
else
    echo "Install Xcode command line tools first! You should have just gotten a prompt to install them. Finish that process and then re-run this script."
    exit
fi

# Add iOS Simulator to Launchpad
if prompt "Do you want to add iOS Simulator to Launchpad?"; then
    sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app" "/Applications/Simulator.app"
    echo "iOS Simulator added to Launchpad."
else
    echo "Skipping iOS Simulator addition to Launchpad."
fi

# Add Watch Simulator to Launchpad
if prompt "Do you want to add Watch Simulator to Launchpad?"; then
    sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/Simulator (Watch).app" "/Applications/Simulator (Watch).app"
    echo "Watch Simulator added to Launchpad."
else
    echo "Skipping Watch Simulator addition to Launchpad."
fi

echo "Script execution completed."
