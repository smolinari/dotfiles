# Exports

# Locale
export LC_ALL="en_US.UTF-8"
export LANG=en_US.UTF-8

# GPG
export GPG_TTY=$(tty)

# Path Configuration
# Note: $PATH is often built up; ensuring duplication doesn't happen usually handled by zsh, 
# but we append here as per original config.
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/go/bin
PATH="$PATH:/usr/local/bin:$HOME/.local/bin:$HOME/.rd/bin:$HOME/.nats"

# Kubeconfig
export KUBECONFIG=~/.kube/config

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Editor
export EDITOR=nano

# Krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"

# PNPM
export PNPM_HOME="/home/scott/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
