# Dotfiles

This repository contains my personal configuration files (dotfiles) for various
tools and applications.

## Structure

```bash
dotfiles/
├── README.md           # This file
├── setup-dotfiles.sh   # Script to set up dotfiles on a new machine
├── restore-dotfiles.sh # Script to restore dotfiles from this repository
├── bashrc             # Bash configuration
├── bash_credentials   # Sensitive credentials (not in version control)
├── gitconfig          # Git configuration
├── vimrc              # Vim configuration (if exists)
├── claude/            # Claude AI configuration
│   ├── CLAUDE.md      # Active Claude configuration
│   ├── CLAUDE_global.md      # Global pattern (general purpose)
│   ├── CLAUDE_production.md  # Production system control
│   ├── CLAUDE_team.md        # Team collaboration
│   ├── CLAUDE_research.md    # R&D projects
│   ├── CLAUDE_devops.md      # Automation & DevOps
│   ├── switch_claude_pattern.sh # Pattern switching script
│   └── backups/       # Backup directory for CLAUDE.md files
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
- `.bash_credentials` - Sensitive environment variables (symlinked, not in git)
- `.gitconfig` - Git global configuration
- `.claude/CLAUDE.md` - Personal coding standards for Claude Code
- `.vimrc` - Vim editor configuration (if exists)
- `.profile` - Shell profile configuration

## Adding New Files
To add new configuration files to be managed:

1. Edit `setup-dotfiles.sh` and add the file to the `FILES` array
2. Run `./setup-dotfiles.sh` to move the file and create symlink
3. Commit and push the changes

## Claude Pattern Management

The `claude/` directory contains multiple CLAUDE.md patterns for different use cases:

### Available Patterns

- **CLAUDE_global.md** - General purpose configuration for everyday use
- **CLAUDE_production.md** - Strict controls for production environments
- **CLAUDE_team.md** - Team collaboration with git workflow rules
- **CLAUDE_research.md** - R&D projects with experiment protocols
- **CLAUDE_devops.md** - Automation and DevOps constraints

### Switching Patterns

Use the interactive pattern switcher:

```bash
cd ~/dotfiles/claude
./switch_claude_pattern.sh
```

Features:
- Interactive menu for pattern selection
- Automatic backup before switching
- Restore from previous backups
- Current pattern identification

## Security

### Sensitive Credentials
Sensitive information is separated from version control:

- `bash_credentials` contains private tokens and API keys
- This file is excluded from git via `.gitignore`
- `.bashrc` sources `~/.bash_credentials` if it exists
- The file is symlinked during setup but never committed

### Ignored Files

The following files are explicitly ignored:
- `claude.json` - Claude configuration with potentially sensitive data
- `bash_credentials` - Environment variables with tokens/keys
- `*.backup` - Backup files created during restore

## Notes
- The scripts automatically handle creating necessary directory structures
- Existing files are backed up with a `.backup` extension when restoring
- Symbolic links are used to maintain the connection between your home
  directory and the dotfiles repository
