#!/bin/bash
echo updating package list...
pacman -Qem > ~/dotfiles/info/info/aur-v.txt
pacman -Qeqm > ~/dotfiles/info/info/aur.txt
pacman -Qen > ~/dotfiles/info/info/pacman-v.txt
pacman -Qeqn > ~/dotfiles/info/info/pacman.txt
#yay -Qe > ~/dotfiles/info/info/yay-v.txt
#yay -Qeq > ~/dotfiles/info/info/yay.txt

echo stowing dotfiles...
stow */ # --ignore info
echo updating git repository...
git add .
if [ -z "$1" ]
  then
    echo "no commit message supplied"
    git commit -m $(( ( RANDOM % 10000000000000 ) + 1 ))
  else
    git commit -m "$1"
fi
git push -u origin
