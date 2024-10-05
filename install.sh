#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status.
set -x  # Print commands and their arguments as they are executed.

# Fish is pre-installed in Codespaces, so we don't need to install it
# Instead, let's just make sure it's up to date
apt-get update
apt-get upgrade -y fish

# Create Fish config directory if it doesn't exist
mkdir -p ~/.config/fish

# Symlink Fish config file
ln -sf ~/dotfiles/config.fish ~/.config/fish/config.fish

# Set Fish as default shell
# chsh -s $(which fish)

# Set VS Code display language to English
mkdir -p ~/.vscode-remote/data/Machine
echo '{"locale":"en"}' > ~/.vscode-remote/data/Machine/locale.json

# Copy .gitignore_global locally
cp ~/dotfiles/.gitignore_global ~/.gitignore_global

# Command to update the Git configuration:
git config --global core.excludesfile ~/.gitignore_global

# Copy .pylintrc to home directory
cp ~/dotfiles/.pylintrc ~/.pylintrc

echo "Dotfiles installation completed successfully!"
