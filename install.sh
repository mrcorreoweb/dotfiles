#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status.
set -x  # Print commands and their arguments as they are executed.

# Set the correct path for the dotfiles
DOTFILES_PATH="/workspaces/.codespaces/.persistedshare/dotfiles"

# Create ~/bin directory if it doesn't exist
mkdir -p ~/bin

# Copy the copy-file-to-branches.sh script to ~/bin
if [ -f "$DOTFILES_PATH/copy-file-to-branches.sh" ]; then
    cp "$DOTFILES_PATH/copy-file-to-branches.sh" ~/bin/
    chmod +x ~/bin/copy-file-to-branches.sh
else
    echo "copy-file-to-branches.sh not found in dotfiles"
fi

# Add ~/bin to PATH if it's not already in the PATH
if ! echo "$PATH" | grep -q "$HOME/bin"; then
    echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
    # For fish shell users, also add it to the Fish config
    echo 'set -x PATH $HOME/bin $PATH' >> ~/.config/fish/config.fish
fi

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

echo "Dotfiles installation completed successfully!"
