## Overview

* Void linux dotfiles for [dwm](http://suckless.org/)
* EFISTUB Void Linux Installation [Guide](https://github.com/hoaxdream/void-dots/blob/main/.config/dev/notes/VOID.md)

## Dwm
![Rice screen preview01](https://i.imgur.com/CgCDqQq.png)

![Rice screen preview02](https://i.imgur.com/JPoX6H9.png)

## Dotfiles installation
*Dwm is the default wm, just change xinitrc if you want to use bspwm or xmonad.*
*Read the commented lines in [bootstrap](https://github.com/hoaxdream/void-bootstrap) scripts and change accordingly for your system*
```sh
- $ xbps-install -Syu git
- $ git clone https://github.com/hoaxdream/void-bootstrap.git
- $ cd void-bootstrap
- $ ./setup.sh              # do ./setup.sh dot first before everything else.
- $ sudo reboot
- $ dot up                  # this command do --assumed-unchanged and delete LICENSE, README.md in $HOME
- $ dot res                 # this command do --no-assumed-unchanged and restore LICENSE, README.md in $HOME
- $ dot status
- $ dot add
- $ dot commit
- $ dot push
```

## Personal suckless build

- [Dwm](https://github.com/hoaxdream/void-dwm)

- [St](https://github.com/hoaxdream/void-st)

- [Slock](https://github.com/hoaxdream/void-slock)

- [Dwmblocks](https://github.com/hoaxdream/void-dwmblocks) - [dwmblocks-async](https://github.com/UtkarshVerma/dwmblocks-async) by UtkarshVerma

- [Dmenu](https://github.com/hoaxdream/void-dmenu)

Check the [Guide](https://github.com/hoaxdream/void-dots/blob/main/.config/dev/notes/VOID.md) on how to patch [libxft-bgra](https://github.com/hoaxdream/void-dots/blob/main/.config/dev/patches/libXft-bgra/change.patch) for void linux.
