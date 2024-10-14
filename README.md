# 🏠 Dotfiles

Welcome to my personal dotfiles repository! 🎉

This special repository is automatically recognized by GitHub Codespaces and used to manage my development environment across all my Codespaces. It's like carrying my home setup wherever I code! 🧳💻

## 📂 Contents

- `install.sh`: 🚀 Installation script that sets up the environment
- `copy-file-to-branches.sh`: 📄 A script to copy files to multiple Git branches
- `config.fish`: 🐟 Fish shell configuration
- `.gitignore_global`: 🙈 Global Git ignore rules
- `.gitconfig`: 🔧 Git configuration file
- `.pylintrc`: 🐍 Global Pylint configuration
- `.env`: 📦 Enviroment variables

## 🛠 What it does

This repository automates the setup of my preferred development environment:

- 🐟 Configures Fish shell 
- 🔧 Configures global Git ignore rules and settings
- 🐍 Sets up global Pylint configuration
- 📦 Prepare the enviroment variables file for update
- 📄 Installs `copy-file-to-branches.sh` into `~/bin` for easy access across projects

## 🔄 Installation

The `install.sh` script performs the following actions:

1. 🔗 Symlinks Fish configuration
2. 📄 Sets up global Git ignore
3. 🔧 Configures Git to use the global ignore file
4. 🐍 Sets up global Pylint configuration
5. 📦 Deploy the enviroment variables file
6. 📄 Installs `copy-file-to-branches.sh` to `~/bin` and makes it executable
7. 🛠 Ensures `~/bin` is added to the `PATH` if it's not already included

## 🚀 Usage

GitHub Codespaces automatically detects and uses this repository when creating new Codespaces for me. No manual intervention required! 

### Using the `copy-file-to-branches.sh` script

Once the Codespace is created, the `copy-file-to-branches.sh` script will be installed in the `~/bin` directory. You can use this script from any project to copy a file to multiple branches.

Example command:

copy-file-to-branches.sh <file> <branch1> <branch2> ...

For instance, to copy `README.md` to branches `main` and `develop`, run:

copy-file-to-branches.sh README.md main develop

The script will switch between the specified branches, copy the file, and commit the changes if necessary.

Make sure that `~/bin` is included in your `PATH`, so you can run the script from any directory:

echo $PATH

If `~/bin` is not in your `PATH`, you can add it by updating your shell configuration:

echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc  # For bash users

or 

echo 'export PATH="$HOME/bin:$PATH"' >> ~/.config/fish/config.fish  # For fish users

After updating, either restart your terminal or run:

source ~/.bashrc  # For bash

or

source ~/.config/fish/config.fish  # For fish

Once done, the `copy-file-to-branches.sh` script will be available for use globally in the Codespace.

## 🛠 Customization

Feel free to fork this repository and modify it to suit your needs. Make it your home away from home! 🏡

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

Happy coding! 💻✨
