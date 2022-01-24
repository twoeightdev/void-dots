## Overview

* Void linux dotfiles for [dwm](http://suckless.org/)
* EFISTUB Void Linux Installation [Guide](https://github.com/hoaxdream/void-dots/blob/main/.config/dev/notes/VOID.md)

## Dwm
![Rice screen preview0001](https://i.imgur.com/O9IjRg3.png)
![Rice screen preview0002](https://i.imgur.com/JPoX6H9.png)

## Dotfiles installation
*Dwm is the default wm, just change xinitrc if you want to use bspwm or xmonad.*
*Read the commented lines in [bootstrap](https://github.com/hoaxdream/void-bootstrap) scripts and change accordingly for your system*
```sh
- $ xbps-install -Syu git
- $ git clone https://github.com/hoaxdream/void-bootstrap.git
- $ cd void-bootstrap
- $ ./1_pkginstall          # edit according to packages you want to install.
- $ ./2_dotsetup            # clone my dotfiles, including suckless builds and install them.
- $ sudo ./3_postinstall    # set UUID of my spare drive to fstab, edit accordingly.
- $ sudo ./4_finalize       # set dbus, also delete and make directory.
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
