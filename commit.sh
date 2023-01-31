#!/bin/bash
echo stowing dotfiles...
stow */
git add .
if [ -z "$1" ]
  then
    echo "no commit message supplied"
    git commit -m $(( ( RANDOM % 10000000000000 ) + 1 ))
  else
    git commit -m "$1"
fi
git push -u origin
