#!/bin/bash
echo updating package list...
pacman -Qe > ~/dotfiles/info/pacman.txt
yay -Qe > ~/dotfiles/info/yay.txt

echo stowing dotfiles...
stow */
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
