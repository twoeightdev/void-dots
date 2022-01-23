## Overview

* Void linux dotfiles for [dwm](http://suckless.org/)
* EFISTUB Void Linux Installation [Guide](https://github.com/hoaxdream/void-dots/blob/main/.config/dev/notes/VOID.md)

## Dwm
![Rice screen preview0001](https://i.imgur.com/O9IjRg3.png)

## Dotfiles installation
*Dwm is the default wm, just change xinitrc if you want to use bspwm or xmonad.*
*Read the commented lines in bootstrap scripts and change accordingly for your system*
```sh
- Remove stock configuration in $HOME, else error will occur.
- $ echo "dots" >> .gitignore
- $ git clone --bare https://github.com/hoaxdream/void-dots.git $HOME/.config/dots
- $ git --git-dir=$HOME/.config/dots/ --work-tree=$HOME checkout
- $ git --git-dir=$HOME/.config/dots/ --work-tree=$HOME config --local status.showUntrackedFiles no
- $ dot up  # this command do --assumed-unchanged and delete LICENSE, README.md in $HOME
- $ dot res # this command do --no-assumed-unchanged and restore LICENSE, README.md in $HOME
- $ dot status  # check git status
- $ dot add     # add file
- $ dot commit  # to commit
- $ dot push    # to push
```

## Personal suckless build

- [Dwm](https://github.com/hoaxdream/void-dwm)

- [St](https://github.com/hoaxdream/void-st)

- [Slock](https://github.com/hoaxdream/void-slock)

- [Dwmblocks](https://github.com/hoaxdream/void-dwmblocks) - [dwmblocks-async](https://github.com/UtkarshVerma/dwmblocks-async) by UtkarshVerma

- [Dmenu](https://github.com/hoaxdream/void-dmenu)

Link [libxft-bgra](https://github.com/hoaxdream/void-dots/blob/main/.config/dev/patches/libXft-bgra/change.patch) patch for void linux.
