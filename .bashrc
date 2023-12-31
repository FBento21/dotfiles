#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ls='eza -alhF --color=auto --group-directories-first'
alias grep='grep --color=auto'
PS1='\[\e[95m\][\[\e[91m\]\w\[\e[95m\]]\[\e[38;5;208m\]$(git branch 2>/dev/null | grep '"'"'*'"'"' | colrm 1 2) \[\e[0m\]'

export EDITOR="nvim"
export VISUAL="nvim"

# Add to Path
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Application compatibility
export _JAVA_AWT_WM_NONREPARENTING=1

# SSH Agent Socket
export SSH_AUTH_SOCK=/run/user/1000/keyring/ssh

# Aliases
alias imv="swayhide imv"
alias zathura="swayhide zathura"
alias dirac="source ~/Projetos/Dirac-Paper/Code/Dirac/bin/activate"

# Startup command
pfetch


