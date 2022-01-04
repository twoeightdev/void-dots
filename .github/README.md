## Overview

* Void linux dotfiles for [bspwm](https://github.com/baskerville/bspwm) [dwm](http://suckless.org/) & [xmonad](https://github.com/xmonad/xmonad)
* EFISTUB Void Linux Installation [Guide](https://github.com/hoaxdream/void-dots/blob/main/.github/VOID.md)
* [Dependencies](https://github.com/hoaxdream/dots#dependencies)

## Xmonad
![Rice screen preview0000](https://i.imgur.com/hxUN5V0.png)
![Rice screen preview0001](https://i.imgur.com/exIs3Ot.png)
![Rice screen preview0002](https://i.imgur.com/O8RrjFG.png)

## Dwm
![Rice screen preview0003](https://i.imgur.com/caDawRq.png)
![Rice screen preview0004](https://i.imgur.com/5dFAWk4.png)
![Rice screen preview0005](https://i.imgur.com/IMOhpPN.png)

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
