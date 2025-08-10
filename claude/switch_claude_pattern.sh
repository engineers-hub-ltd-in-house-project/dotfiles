#!/bin/bash

# Claude Pattern Switcher
# Switch between different CLAUDE.md configurations

set -e

CLAUDE_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_FILE="$CLAUDE_DIR/CLAUDE.md"
BACKUP_DIR="$CLAUDE_DIR/backups"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Function to display menu
show_menu() {
    echo -e "${BLUE}═══════════════════════════════════════════${NC}"
    echo -e "${BLUE}      Claude Pattern Switcher              ${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════${NC}"
    echo ""
    echo "Available patterns:"
    echo "  1) Global       - General purpose (Pattern 1)"
    echo "  2) Production   - Production system control (Pattern 2)"
    echo "  3) Team         - Team collaboration (Pattern 3)"
    echo "  4) Research     - R&D projects (Pattern 4)"
    echo "  5) DevOps       - Automation & DevOps (Pattern 5)"
    echo "  6) Japanese     - Original Japanese version"
    echo ""
    echo "  b) Backup current CLAUDE.md"
    echo "  r) Restore from backup"
    echo "  s) Show current pattern"
    echo "  q) Quit"
    echo ""
}

# Function to backup current CLAUDE.md
backup_current() {
    if [ -f "$CLAUDE_FILE" ]; then
        TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
        BACKUP_FILE="$BACKUP_DIR/CLAUDE_backup_$TIMESTAMP.md"
        cp "$CLAUDE_FILE" "$BACKUP_FILE"
        echo -e "${GREEN}✓ Backed up to: $BACKUP_FILE${NC}"
    else
        echo -e "${YELLOW}No CLAUDE.md file to backup${NC}"
    fi
}

# Function to switch pattern
switch_pattern() {
    local pattern_file="$1"
    local pattern_name="$2"
    
    if [ ! -f "$pattern_file" ]; then
        echo -e "${RED}✗ Pattern file not found: $pattern_file${NC}"
        return 1
    fi
    
    # Backup current file if it exists
    if [ -f "$CLAUDE_FILE" ]; then
        backup_current
    fi
    
    # Copy new pattern
    cp "$pattern_file" "$CLAUDE_FILE"
    echo -e "${GREEN}✓ Switched to: $pattern_name${NC}"
    echo -e "${GREEN}  Active file: $CLAUDE_FILE${NC}"
}

# Function to show current pattern
show_current() {
    if [ ! -f "$CLAUDE_FILE" ]; then
        echo -e "${YELLOW}No CLAUDE.md file currently active${NC}"
        return
    fi
    
    # Try to identify pattern by checking first principle
    if grep -q "AI OPERATION PRINCIPLES" "$CLAUDE_FILE" 2>/dev/null; then
        echo -e "${BLUE}Current pattern appears to be English version${NC}"
        
        # Check for specific patterns
        if grep -q "PRODUCTION SYSTEM CONSTRAINTS" "$CLAUDE_FILE" 2>/dev/null; then
            echo -e "${GREEN}Pattern: Production${NC}"
        elif grep -q "TEAM COLLABORATION RULES" "$CLAUDE_FILE" 2>/dev/null; then
            echo -e "${GREEN}Pattern: Team${NC}"
        elif grep -q "R&D PROJECT CONSTRAINTS" "$CLAUDE_FILE" 2>/dev/null; then
            echo -e "${GREEN}Pattern: Research${NC}"
        elif grep -q "AUTOMATION & DEVOPS CONSTRAINTS" "$CLAUDE_FILE" 2>/dev/null; then
            echo -e "${GREEN}Pattern: DevOps${NC}"
        elif grep -q "GLOBAL ENFORCEMENT RULES" "$CLAUDE_FILE" 2>/dev/null; then
            echo -e "${GREEN}Pattern: Global${NC}"
        fi
    elif grep -q "AI運用の原則" "$CLAUDE_FILE" 2>/dev/null; then
        echo -e "${GREEN}Pattern: Japanese Original${NC}"
    else
        echo -e "${YELLOW}Pattern: Unknown/Custom${NC}"
    fi
    
    echo ""
    echo "First 20 lines of current CLAUDE.md:"
    echo "────────────────────────────────────"
    head -20 "$CLAUDE_FILE"
}

# Function to restore from backup
restore_backup() {
    if [ ! -d "$BACKUP_DIR" ] || [ -z "$(ls -A "$BACKUP_DIR" 2>/dev/null)" ]; then
        echo -e "${YELLOW}No backups available${NC}"
        return
    fi
    
    echo "Available backups:"
    echo ""
    
    # List backups with numbers
    local i=1
    local backup_files=()
    for backup in "$BACKUP_DIR"/*.md; do
        if [ -f "$backup" ]; then
            backup_files+=("$backup")
            echo "  $i) $(basename "$backup")"
            ((i++))
        fi
    done
    
    echo ""
    read -p "Select backup number (or 'c' to cancel): " choice
    
    if [[ "$choice" == "c" ]]; then
        return
    fi
    
    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#backup_files[@]}" ]; then
        local selected_backup="${backup_files[$((choice-1))]}"
        
        # Backup current before restoring
        if [ -f "$CLAUDE_FILE" ]; then
            backup_current
        fi
        
        cp "$selected_backup" "$CLAUDE_FILE"
        echo -e "${GREEN}✓ Restored from: $(basename "$selected_backup")${NC}"
    else
        echo -e "${RED}Invalid selection${NC}"
    fi
}

# Main loop
while true; do
    show_menu
    read -p "Select option: " choice
    echo ""
    
    case $choice in
        1)
            switch_pattern "$CLAUDE_DIR/CLAUDE_global.md" "Global Pattern"
            ;;
        2)
            switch_pattern "$CLAUDE_DIR/CLAUDE_production.md" "Production Pattern"
            ;;
        3)
            switch_pattern "$CLAUDE_DIR/CLAUDE_team.md" "Team Pattern"
            ;;
        4)
            switch_pattern "$CLAUDE_DIR/CLAUDE_research.md" "Research Pattern"
            ;;
        5)
            switch_pattern "$CLAUDE_DIR/CLAUDE_devops.md" "DevOps Pattern"
            ;;
        6)
            switch_pattern "$CLAUDE_DIR/CLAUDE_japanese_original.md" "Japanese Original"
            ;;
        b|B)
            backup_current
            ;;
        r|R)
            restore_backup
            ;;
        s|S)
            show_current
            ;;
        q|Q)
            echo -e "${BLUE}Goodbye!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option${NC}"
            ;;
    esac
    
    echo ""
    read -p "Press Enter to continue..."
    clear
done