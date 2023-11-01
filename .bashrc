#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ls='ls -alhF --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias vim='vim --servername vim'
PS1='\[\e[95m\][\[\e[91m\]\w\[\e[95m\]]\[\e[38;5;208m\]$(git branch 2>/dev/null | grep '"'"'*'"'"' | colrm 1 2) \[\e[0m\]'

# Add .local/bin to the Path
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/bin/site_perl:$PATH"
export PATH="/usr/bin/vendor_perl:$PATH"
export PATH="/usr/bin/core_perl:$PATH"

alias imv="swayhide imv"

# Startup command
pfetch
