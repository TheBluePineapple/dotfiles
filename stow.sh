#!/bin/bash
echo stowing dotfiles...
stow */
git add .
git commit -m "$1"
git push -u origin
