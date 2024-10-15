# 🏠 Dotfiles

Welcome to my personal dotfiles repository! 🎉

This special repository is automatically recognized by GitHub Codespaces and used to manage my development environment across all my Codespaces. It's like carrying my home setup wherever I code! 🧳💻

## 📂 Contents

- `install.sh`: 🚀 Installation script that sets up the environment
- `config.fish`: 🐟 Fish shell configuration
- `.gitignore_global`: 🙈 Global Git ignore rules
- `.gitconfig`: 🔧 Git configuration file
- `.pylintrc`: 🐍 Global Pylint configuration
- `.env`: 📦 Enviroment variables
- `copy-file-to-branches.sh`: 📄 A script to copy files to multiple Git branches

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
6. 📄 Installs `copy-file-to-branches.sh` to `~/.local/bin` and makes it executable

## 🚀 Usage

GitHub Codespaces automatically detects and uses this repository when creating new Codespaces for me. No manual intervention required! 

### Using the `copy-file-to-branches.sh` script

Once the Codespace is created, the `copy-file-to-branches.sh` script will be installed in the `~/.local/bin` directory. 
You can use this script from anywhere in any project to copy an specified file to multiple branches.

Example command:
```bash
copy-file-to-branches.sh <file>
```
For instance, to copy `README.md` from the active brach to the other branches, add, commit and push the file, run:
```bash
copy-file-to-branches.sh README.md
```
The script will switch between the specified branches, copy the file, and commit and push the changes if necessary.

## 🛠 Customization

Feel free to fork this repository and modify it to suit your needs. Make it your home away from home! 🏡

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

Happy coding! 💻✨
