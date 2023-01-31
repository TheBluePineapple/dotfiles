#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
set -o vi
alias la='ls -lah'

#export PATH="/usr/bin/librewolf:$HOME/.local/bin/lvim:$HOME/.local/bin/lvide:$PATH"
export PATH="$HOME/.local/bin:$PATH"
PS1='[\u@\h \W]\$ '
PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"
