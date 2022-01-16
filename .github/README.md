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

## Personal Suckless build

### [dwm](https://github.com/hoaxdream/void-dwm)
- Patches:
    - vainitygaps
    - cfacts
    - colorfultag
    - pertag
    - scratchpads
    - statusallmons
    - statuscmd
    - steamfix
    - tagmonfixfs
    - togglefullscreen
    - underlinetags
    - alwayscenter
    - status2d
    - titlecolor
    - enabled color emoji

### [st](https://github.com/hoaxdream/void-st)
- Patches:
    - disable bold italics
    - font2
    - scrollback

### [slock](https://github.com/hoaxdream/void-slock)
- Patches:
    - blurred
    - Xft font

### [dwmblocks](https://github.com/hoaxdream/void-dwmblocks)
- [dwmblocks-async](https://github.com/UtkarshVerma/dwmblocks-async) by UtkarshVerma

### [dmenu](https://github.com/hoaxdream/void-dmenu)
- enabled color emoji

Link on how to patch [libxft-bgra](https://github.com/hoaxdream/void-dots/blob/main/.github/VOID.md) for void linux.
