## Overview

* Void linux dotfiles for [dwm](http://suckless.org/)
* EFISTUB Void Linux Installation [Guide](https://github.com/hoaxdream/void-dots/blob/main/.github/VOID.md)

## Dwm
![Rice screen preview0001](https://i.imgur.com/O9IjRg3.png)

## Dotfiles installation
*Dwm is the default wm, just change xinitrc if you want to use bspwm or xmonad.*
*Read the commented lines in bootstrap scripts and change accordingly for your system*
```javascript
- Remove stock configuration in $HOME, else error will occur.
- $ echo "dots" >> .gitignore
- $ git clone --bare https://github.com/hoaxdream/void-dots.git $HOME/.config/dots
- $ git --git-dir=$HOME/.config/dots/ --work-tree=$HOME checkout
- $ git --git-dir=$HOME/.config/dots/ --work-tree=$HOME config --local status.showUntrackedFiles no
```
