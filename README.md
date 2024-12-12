# 🏠 Dotfiles

Welcome to my personal dotfiles repository! 🎉

This special repository is automatically recognized by GitHub Codespaces and used to manage my development environment across all my Codespaces. It's like carrying my home setup wherever I code! 🧳💻

## 📂 Files

- `install.sh`: 🚀 Installation script that sets up the environment
- `config.fish`: 🐟 Fish shell configuration
- `.gitignore_global`: 🙈 Global Git ignore rules
- `.gitconfig`: 🔧 Git configuration file
- `.pylintrc`: 🐍 Global Pylint configuration
- `.env`: 📦 Enviroment variables
- `copy-file-to-branches.sh`: 📄 A script to copy files to multiple Git branches
- `reset_django.sh`: 📄 A script to reset the Django database and migrations.

## 🛠 What it does

This repository automates the setup of my preferred development environment:

- 🐟 Configures Fish shell
- 🔧 Configures global Git ignore rules and Git settings
- 🐍 Sets up global Pylint configuration
- 📦 Prepare the enviroment variables file for update
- 📄 Installs into `~/.local/bin` and make executable:
  -  `copy-file-to-branches.sh`
  -  `reset_django.sh`

## 🚀 Usage

GitHub Codespaces automatically detects and uses this repository when creating new Codespaces for me. No manual intervention required!

### Using the `copy-file-to-branches.sh` script
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

### Using the `reset_django.sh` script
You can use this script from anywhere in any project to reset the Django database and migrations.

Example command:

```bash
reset_django.sh app1 [app2 ...]
```

For instance, for a database fresh start with the apps `games` and `users` , run:

```bash
reset_django.sh games users
```
The script will remove migrations, db.sqlite3 and create and apply new migratons with empty tables.



## 🛠 Customization

Feel free to fork this repository and modify it to suit your needs. Make it your home away from home! 🏡

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

Happy coding! 💻✨
