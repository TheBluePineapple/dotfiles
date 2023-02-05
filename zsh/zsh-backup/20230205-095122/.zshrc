# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/blue/.config/zsh/.zshrc'
autoload -Uz compinit
compinit
_comp_options+=(globdots)
# End of lines added by compinstall
