#
# ~/.bash_profile
#
#startx on login
#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] || return
#echo
#read -p "start Xorg[Y/y]? " -n 1 -r
#echo
#if [[ $REPLY =~ ^[Yy]$ ]]
#then
#	startx
#fi
startx
brightnessctl set 7%
amixer set Master 100%
[[ -f ~/.bashrc ]] && . ~/.bashrc
#. "$HOME/.cargo/env"
