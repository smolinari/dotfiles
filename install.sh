#!/bin/bash
set -e

# Dotfiles Installation Script for Coder

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BRANCH="main" # or master, depending on repo default

echo "Starting dotfiles installation..."

# Check for ZSH
if ! command -v zsh >/dev/null 2>&1; then
    echo "ZSH is not installed. Installing..."
    sudo apt-get update && sudo apt-get install -y zsh
else
    echo "ZSH is already installed."
fi

# Install Oh My Zsh (Non-interactive)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
else
    echo "Oh My Zsh is already installed."
fi

# Install Starship (Non-interactive)
if ! command -v starship >/dev/null 2>&1; then
    echo "Installing Starship..."
    sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y
else
    echo "Starship is already installed."
fi

# Backup existing .zshrc if it exists and isn't a symlink
if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
    echo "Backing up existing .zshrc..."
    mv "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%s)"
fi

# Symlink .zshrc
if [ -L "$HOME/.zshrc" ]; then
    echo "Removing existing .zshrc symlink..."
    rm "$HOME/.zshrc"
fi

echo "Symlinking .zshrc..."
ln -s "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"

echo "Dotfiles installation complete!"
echo "Please restart your shell or run 'zsh' to see changes."
