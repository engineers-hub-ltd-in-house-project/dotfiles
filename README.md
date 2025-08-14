# Dotfiles

This repository contains my personal configuration files (dotfiles) for various
tools and applications.

## Structure

```bash
dotfiles/
├── README.md           # This file
├── Makefile           # Automation commands for setup and maintenance
├── lefthook.yml       # Git hooks configuration for automated formatting
├── .markdownlint.json # Markdown linter configuration
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

### Quick Setup with Makefile

This repository includes automated setup commands via Makefile:

```bash
# Clone and navigate to the repository
git clone https://github.com/engineers-hub-ltd-in-house-project/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install required formatting tools
make install-tools

# Set up git hooks for automatic formatting
make setup-hooks

# Set up dotfiles management
make setup
```

### Available Make Commands

- `make help` - Show all available commands
- `make setup` - Set up dotfiles on current machine
- `make restore` - Restore dotfiles from repository
- `make backup` - Create backup of current dotfiles
- `make update` - Update dotfiles from home directory
- `make clean` - Remove backup files
- `make install-tools` - Install required formatting tools (lefthook, shellcheck, etc.)
- `make setup-hooks` - Install lefthook git hooks

### Manual Setup

#### Initial Setup (on current machine)

To set up dotfiles management manually:

```bash
cd ~/dotfiles
./setup-dotfiles.sh
```

This will:

1. Move specified dotfiles from your home directory to this repository
2. Create symbolic links from your home directory to the files in this repository
3. Initialize git repository if not already initialized

#### Restore on New Machine

To restore your dotfiles on a new machine manually:

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

## Automated Code Formatting

This repository uses **lefthook** to automatically format and lint code on commit:

### Supported File Types

- **Shell Scripts** (`.sh`):
  - `shellcheck` - Static analysis and linting
  - `shfmt` - Consistent formatting (2-space indentation)

- **Markdown** (`.md`):
  - `markdownlint` - Style and formatting validation

- **YAML** (`.yml`, `.yaml`):
  - `yamllint` - YAML syntax validation
  - `prettier` - Consistent formatting

### Automatic Actions

On every commit, lefthook automatically:

1. **Removes trailing whitespace** from all text files
2. **Ensures files end with newlines**
3. **Formats code** according to established standards
4. **Validates syntax** and catches common errors
5. **Stages fixed files** automatically

### Installation

The formatting tools are automatically installed and configured when you run:

```bash
make install-tools
make setup-hooks
```

### Manual Commands

You can also run formatting manually:

```bash
# Install all required tools
make install-tools

# Set up git hooks
make setup-hooks

# Check current lefthook status
lefthook version
```

## Notes

- The scripts automatically handle creating necessary directory structures
- Existing files are backed up with a `.backup` extension when restoring
- Symbolic links are used to maintain the connection between your home
  directory and the dotfiles repository
- All commits are automatically formatted and validated before being accepted
- Pre-push hooks validate all files to ensure repository quality
