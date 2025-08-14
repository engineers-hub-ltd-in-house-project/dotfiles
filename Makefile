.PHONY: help setup restore backup update clean install-tools setup-hooks

# Default target
help:
	@echo "Dotfiles Management Commands:"
	@echo "  make setup         - Set up dotfiles on current machine"
	@echo "  make restore       - Restore dotfiles from repository"
	@echo "  make backup        - Create backup of current dotfiles"
	@echo "  make update        - Update dotfiles from home directory"
	@echo "  make clean         - Remove backup files"
	@echo "  make install-tools - Install required formatting tools"
	@echo "  make setup-hooks   - Install lefthook git hooks"

# Set up dotfiles on current machine
setup:
	@echo "Setting up dotfiles..."
	@./setup-dotfiles.sh

# Restore dotfiles from repository
restore:
	@echo "Restoring dotfiles..."
	@./restore-dotfiles.sh

# Create backup of current dotfiles
backup:
	@echo "Creating backup of dotfiles..."
	@mkdir -p backups/$$(date +%Y%m%d_%H%M%S)
	@cp -r * backups/$$(date +%Y%m%d_%H%M%S)/ 2>/dev/null || true
	@echo "Backup created in backups/$$(date +%Y%m%d_%H%M%S)"

# Update dotfiles from home directory
update:
	@echo "Updating dotfiles from home directory..."
	@./setup-dotfiles.sh
	@git add -A
	@git status

# Clean backup files
clean:
	@echo "Cleaning backup files..."
	@find . -name "*.backup" -type f -delete
	@echo "Backup files cleaned."

# Install required formatting tools
install-tools:
	@echo "Installing required formatting tools..."
	@echo "Installing lefthook..."
	@which lefthook >/dev/null 2>&1 || { \
		echo "Installing lefthook via package manager..."; \
		if command -v brew >/dev/null 2>&1; then \
			brew install lefthook; \
		elif command -v npm >/dev/null 2>&1; then \
			npm install -g @arkweid/lefthook; \
		elif command -v go >/dev/null 2>&1; then \
			go install github.com/evilmartians/lefthook@latest; \
		else \
			echo "Please install lefthook manually: https://github.com/evilmartians/lefthook"; \
			exit 1; \
		fi; \
	}
	@echo "Installing shellcheck..."
	@which shellcheck >/dev/null 2>&1 || { \
		if command -v brew >/dev/null 2>&1; then \
			brew install shellcheck; \
		elif command -v apt >/dev/null 2>&1; then \
			sudo apt install shellcheck; \
		else \
			echo "Please install shellcheck manually"; \
		fi; \
	}
	@echo "Installing shfmt..."
	@which shfmt >/dev/null 2>&1 || { \
		if command -v brew >/dev/null 2>&1; then \
			brew install shfmt; \
		elif command -v go >/dev/null 2>&1; then \
			go install mvdan.cc/sh/v3/cmd/shfmt@latest; \
		else \
			echo "Please install shfmt manually"; \
		fi; \
	}
	@echo "Installing markdownlint-cli..."
	@which markdownlint >/dev/null 2>&1 || { \
		if command -v npm >/dev/null 2>&1; then \
			npm install -g markdownlint-cli; \
		else \
			echo "Please install markdownlint-cli manually"; \
		fi; \
	}
	@echo "Installing yamllint..."
	@which yamllint >/dev/null 2>&1 || { \
		if command -v pip3 >/dev/null 2>&1; then \
			pip3 install yamllint; \
		elif command -v brew >/dev/null 2>&1; then \
			brew install yamllint; \
		else \
			echo "Please install yamllint manually"; \
		fi; \
	}
	@echo "Installing prettier..."
	@which prettier >/dev/null 2>&1 || { \
		if command -v npm >/dev/null 2>&1; then \
			npm install -g prettier; \
		else \
			echo "Please install prettier manually"; \
		fi; \
	}
	@echo "All tools installed successfully!"

# Install lefthook git hooks
setup-hooks:
	@echo "Setting up lefthook git hooks..."
	@lefthook install
	@echo "Git hooks installed successfully!"