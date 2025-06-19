#!/bin/bash

# dotfilesディレクトリのパス
DOTFILES_DIR="$HOME/dotfiles"

# 管理したいファイルのリスト
FILES=(
    ".bashrc"
    ".claude/CLAUDE.md"
    ".gitconfig"
    ".profile"
    ".bash_logout"
    ".yarnrc"
    ".claude.json"
    # 他に管理したいファイルを追加
)

# dotfilesディレクトリが存在しない場合は作成
if [ ! -d "$DOTFILES_DIR" ]; then
    mkdir -p "$DOTFILES_DIR"
    git init "$DOTFILES_DIR"
fi

# 各ファイルをdotfilesに移動してシンボリックリンクを作成
for file in "${FILES[@]}"; do
    # ファイルのフルパス
    source="$HOME/$file"
    # dotfiles内での名前（ドットを除去）
    dest_name="${file#.}"
    dest="$DOTFILES_DIR/$dest_name"
    
    # ファイルが存在する場合
    if [ -e "$source" ] && [ ! -L "$source" ]; then
        echo "Processing: $file"
        
        # ディレクトリ構造を保持
        dest_dir=$(dirname "$dest")
        mkdir -p "$dest_dir"
        
        # ファイルを移動
        mv "$source" "$dest"
        
        # シンボリックリンクを作成
        ln -s "$dest" "$source"
        
        echo "  Moved to: $dest"
        echo "  Created symlink: $source -> $dest"
    fi
done

echo ""
echo "Setup complete! Next steps:"
echo "1. cd $DOTFILES_DIR"
echo "2. git add ."
echo "3. git commit -m 'Initial dotfiles commit'"
echo "4. git remote add origin https://github.com/engineers-hub-ltd-in-house-project/dotfiles.git"
echo "5. git push -u origin main"