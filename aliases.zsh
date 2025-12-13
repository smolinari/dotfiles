# Aliases

# Docker
# alias docker='nerdctl'

# Kubernetes
alias k='kubectl'

# LS aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alert alias
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Yarn/NX
alias 'ynx'='nocorrect yarn nx'

# User configuration
alias ssh='nocorrect ssh'
alias coder='nocorrect coder'

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
