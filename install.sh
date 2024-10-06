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


# Set VS Code display language to English 
mkdir -p ~/.vscode-remote/data/Machine
echo '{"locale":"en"}' > ~/.vscode-remote/data/Machine/locale.json
echo '{"editor.displayLanguage": "en"}' >> ~/.vscode-remote/data/Machine/settings.json
echo 'export LANG=en_US.UTF-8' >> ~/.bashrc
echo 'export LANG=en_US.UTF-8' >> ~/.profile

echo "Dotfiles installation completed successfully!"
