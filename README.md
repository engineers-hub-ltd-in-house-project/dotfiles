# Dotfiles

This repository contains my personal configuration files (dotfiles) for various tools and applications.

## Structure

```
dotfiles/
├── README.md           # This file
├── setup-dotfiles.sh   # Script to set up dotfiles on a new machine
├── restore-dotfiles.sh # Script to restore dotfiles from this repository
├── bashrc             # Bash configuration
├── gitconfig          # Git configuration
├── vimrc              # Vim configuration (if exists)
├── claude/            # Claude AI configuration
│   └── CLAUDE.md      # Personal coding standards for Claude Code
└── config/            # Additional configuration files
```

## Setup

### Initial Setup (on current machine)

To set up dotfiles management on your current machine:

```bash
cd ~/dotfiles
./setup-dotfiles.sh
```

This will:
1. Move specified dotfiles from your home directory to this repository
2. Create symbolic links from your home directory to the files in this repository
3. Initialize git repository if not already initialized

### Restore on New Machine

To restore your dotfiles on a new machine:

```bash
git clone https://github.com/engineers-hub-ltd-in-house-project/dotfiles.git ~/dotfiles
cd ~/dotfiles
./restore-dotfiles.sh
```

## Managed Files

The following configuration files are managed by this repository:
- `.bashrc` - Bash shell configuration
- `.gitconfig` - Git global configuration
- `.claude/CLAUDE.md` - Personal coding standards for Claude Code
- `.vimrc` - Vim editor configuration (if exists)
- `.profile` - Shell profile configuration

## Adding New Files

To add new configuration files to be managed:

1. Edit `setup-dotfiles.sh` and add the file to the `FILES` array
2. Run `./setup-dotfiles.sh` to move the file and create symlink
3. Commit and push the changes

## Notes

- The scripts automatically handle creating necessary directory structures
- Existing files are backed up with a `.backup` extension when restoring
- Symbolic links are used to maintain the connection between your home directory and the dotfiles repository