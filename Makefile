.PHONY: help setup restore backup update clean

# Default target
help:
	@echo "Dotfiles Management Commands:"
	@echo "  make setup    - Set up dotfiles on current machine"
	@echo "  make restore  - Restore dotfiles from repository"
	@echo "  make backup   - Create backup of current dotfiles"
	@echo "  make update   - Update dotfiles from home directory"
	@echo "  make clean    - Remove backup files"

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