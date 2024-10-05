#!/bin/bash

# Ensure Fish is installed
sudo apt-get update
sudo apt-get install -y fish

# Create Fish config directory if it doesn't exist
mkdir -p ~/.config/fish

# Symlink Fish config file
ln -sf ~/dotfiles/config.fish ~/.config/fish/config.fish

# Set Fish as default shell
chsh -s $(which fish)

# Set VS Code display language to English
mkdir -p ~/.vscode-remote/data/Machine
echo '{"locale":"en"}' > ~/.vscode-remote/data/Machine/locale.json

# Copy .gitignore_global locally
cp ~/dotfiles/.gitignore_global ~/.gitignore_global

# Command to update the Git configuration:
git config --global core.excludesfile ~/.gitignore_global

# Copy .pylintrc to home directory
cp ~/dotfiles/.pylintrc ~/.pylintrc
