#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status.
set -x  # Print commands and their arguments as they are executed.

# Set the correct path for the dotfiles
DOTFILES_PATH="/workspaces/.codespaces/.persistedshare/dotfiles"

# Fish is pre-installed in Codespaces, so we don't need to install it
# Create Fish config directory if it doesn't exist
mkdir -p ~/.config/fish

# Symlink Fish config file
ln -sf "$DOTFILES_PATH/config.fish" ~/.config/fish/config.fish
# or copy the Fish config file
# cp "$DOTFILES_PATH/config.fish" ~/.config/fish/config.fish

# Set Fish as default shell
# chsh -s $(which fish)

# Copy .gitignore_global locally (if it exists)
if [ -f "$DOTFILES_PATH/.gitignore_global" ]; then
    cp "$DOTFILES_PATH/.gitignore_global" ~/.gitignore_global
    # Update the Git configuration
    git config --global core.excludesfile ~/.gitignore_global
else
    echo ".gitignore_global not found in dotfiles"
fi

# Copy .gitconfig to home directory (if it exists)
if [ -f "$DOTFILES_PATH/.gitconfig" ]; then
    cp "$DOTFILES_PATH/.gitconfig" ~/.gitconfig
else
    echo ".gitconfig not found in dotfiles"
fi

# Copy .pylintrc to home directory (if it exists)
if [ -f "$DOTFILES_PATH/.pylintrc" ]; then
    cp "$DOTFILES_PATH/.pylintrc" ~/.pylintrc
else
    echo ".pylintrc not found in dotfiles"
fi

# Copy .env file to home directory
if [ -f "$DOTFILES_PATH/.env" ]; then
    cp $DOTFILES_PATH/.env ~/.env
else
    echo ".env not found in dotfiles"
fi

# ~/.local/bin is already in PATH for GitHub Codespaces
# so copying files there make them accesible from everywhere!

# Copy the copy-file-to-branches.sh script to ~/.local/bin
if [ -f "$DOTFILES_PATH/copy-file-to-branches.sh" ]; then
    cp "$DOTFILES_PATH/copy-file-to-branches.sh" ~/.local/bin/
    chmod +x ~/.local/bin/copy-file-to-branches.sh
else
    echo "copy-file-to-branches.sh not found in dotfiles"
fi
# Copy the reset_django.sh script to ~/.local/bin
if [ -f "$DOTFILES_PATH/reset_django.sh" ]; then
    cp "$DOTFILES_PATH/reset_django.sh" ~/.local/bin/
    chmod +x ~/.local/bin/reset_django.sh
else
    echo "reset_django.sh not found in dotfiles"
fi


echo "Dotfiles installation completed successfully!"
