#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

#alias ls='ls --color=auto'
set -o vi
#alias la='ls -lah'
alias ls='lsd'
alias lsa='lsd -a'
alias la='lsd -la'
alias resa="echo 'awesome.restart()' | awesome-client"
alias feh='feh -.Z'
alias dots='cd ~/dotfiles'
alias amixer='amixer -c 0'
alias alsamixer='alsamixer -c 0'
#alias clear='tput -x clear'
bind -x '"\C-l": clear; pfetch; ls'

#export PATH="/usr/bin/librewolf:$HOME/.local/bin/lvim:$HOME/.local/bin/lvide:$PATH"
export PATH="$HOME/.local/bin:$PATH"
PS1='[\u@\h \W]\$ '
PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"
