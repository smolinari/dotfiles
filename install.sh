#!/bin/sh
# m8a Default Dotfiles Installer

set -e

echo ">> Starting m8a default dotfiles setup..."

# Ensure ~/.config exists
mkdir -p "$HOME/.config"

# --- 1. Dependencies ---

# Check for apt-get (Debian/Ubuntu)
if [ -x "$(command -v apt-get)" ]; then
    PACKAGES=""
    if ! [ -x "$(command -v zsh)" ]; then
        PACKAGES="$PACKAGES zsh"
    fi
    if ! [ -x "$(command -v curl)" ]; then
        PACKAGES="$PACKAGES curl"
    fi
    if ! [ -x "$(command -v git)" ]; then
        PACKAGES="$PACKAGES git"
    fi

    if [ -n "$PACKAGES" ]; then
         echo ">> Installing missing packages: $PACKAGES"
         sudo apt-get update && sudo apt-get install -y $PACKAGES
    fi
else
    echo ">> Warning: apt-get not found. Assuming dependencies (zsh, curl, git) are available."
fi

# --- 2. Oh My Zsh ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo ">> Installing Oh My Zsh..."
    # Unattended install
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo ">> Oh My Zsh is already installed."
fi

# --- 3. Starship ---
if ! command -v starship > /dev/null; then
    echo ">> Installing Starship Prompt..."
    mkdir -p "$HOME/.local/bin"
    sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y -b "$HOME/.local/bin"
else
    echo ">> Starship is already installed."
fi

# --- 4. Configuration Linking ---
echo ">> Linking configurations..."

# Get the directory where this script is located
REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"

# Backup existing config if it's a file and not a symlink to our target
backup_if_exists() {
    target=$1
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo ">> Backing up existing $target to $target.bak"
        mv "$target" "$target.bak"
    fi
}

backup_if_exists "$HOME/.zshrc"
ln -sf "$REPO_ROOT/.zshrc" "$HOME/.zshrc"

backup_if_exists "$HOME/.config/starship.toml"
ln -sf "$REPO_ROOT/starship.toml" "$HOME/.config/starship.toml"

# --- 5. Set Default Shell ---
CURRENT_SHELL=$(basename "$SHELL")
if [ "$CURRENT_SHELL" != "zsh" ]; then
    echo ">> Changing default shell to zsh..."
    # Attempt chsh if we have sudo or passwordless capability, might fail in some containers without sudo
    if [ -x "$(command -v sudo)" ]; then
        sudo chsh -s "$(which zsh)" "$USER" || echo ">> Warning: Failed to change shell. You may need to run 'chsh -s $(which zsh)' manually."
    else
        chsh -s "$(which zsh)" || echo ">> Warning: Failed to change shell. You may need to run 'chsh -s $(which zsh)' manually."
    fi
fi

echo ">> m8a dotfiles setup complete! Restart your terminal or run 'zsh' to see changes."
