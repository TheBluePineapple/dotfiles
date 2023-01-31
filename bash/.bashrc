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

##-----------------------------------------------------
## synth-shell-prompt.sh
if [ -f /home/blue/.config/synth-shell/synth-shell-prompt.sh ] && [ -n "$( echo $- | grep i )" ]; then
	source /home/blue/.config/synth-shell/synth-shell-prompt.sh
fi

##-----------------------------------------------------
## alias
if [ -f /home/blue/.config/synth-shell/alias.sh ] && [ -n "$( echo $- | grep i )" ]; then
	source /home/blue/.config/synth-shell/alias.sh
fi

##-----------------------------------------------------
## better-history
if [ -f /home/blue/.config/synth-shell/better-history.sh ] && [ -n "$( echo $- | grep i )" ]; then
	source /home/blue/.config/synth-shell/better-history.sh
fi

pfetch
