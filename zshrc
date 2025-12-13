# Main ZSH Configuration

# Source exports first (Path, ZSH var, etc)
source $HOME/dotfiles/exports.zsh

# ZSH Theme
# Disabled because we are using Starship
ZSH_THEME=""

# Plugins
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git kubectl)

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# User configuration
source $HOME/dotfiles/aliases.zsh

# History setup (from original .zshrc)
setopt SHARE_HISTORY
HISTFILE=$HOME/.zsh_history
SAVEHIST=1000
HISTSIZE=999
setopt HIST_EXPIRE_DUPS_FIRST

# Autocompletion using arrow keys
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

# Initialize autocompletion
autoload -U compinit && compinit

# NVM Loading
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Initialize Starship
eval "$(starship init zsh)"
