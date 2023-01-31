#!/bin/bash
echo stowing dotfiles...
stow */
git add .
if [ -z "$1" ]
  then
    echo "no commit message supplied"
    git commit
  else
    git commit -m "$1"
fi
git push -u origin
