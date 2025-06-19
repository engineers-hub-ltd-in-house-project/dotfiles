#!/bin/bash

# GitHubからdotfilesをクローン
GITHUB_ORG="engineers-hub-ltd-in-house-project"
DOTFILES_DIR="$HOME/dotfiles"

# dotfilesをクローン
if [ ! -d "$DOTFILES_DIR" ]; then
    git clone "https://github.com/$GITHUB_ORG/dotfiles.git" "$DOTFILES_DIR"
fi

# シンボリックリンクを作成する関数
create_symlink() {
    local src="$1"
    local dest="$2"
    
    # 既存のファイルがある場合はバックアップ
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        echo "Backing up existing file: $dest -> $dest.backup"
        mv "$dest" "$dest.backup"
    fi
    
    # シンボリックリンクを作成
    ln -sfn "$src" "$dest"
    echo "Created symlink: $dest -> $src"
}

# dotfiles内のファイルをスキャンしてシンボリックリンクを作成
cd "$DOTFILES_DIR"
find . -type f ! -path "./.git/*" ! -name "README.md" ! -name "*.sh" | while read -r file; do
    # ./を除去
    file="${file#./}"
    
    # デスティネーションパス（ドットを追加）
    if [[ "$file" == *"/"* ]]; then
        # ディレクトリ構造がある場合
        dest="$HOME/.$file"
    else
        # ルートレベルのファイル
        dest="$HOME/.$file"
    fi
    
    # ディレクトリを作成
    mkdir -p "$(dirname "$dest")"
    
    # シンボリックリンクを作成
    create_symlink "$DOTFILES_DIR/$file" "$dest"
done

echo ""
echo "Dotfiles restored successfully!"