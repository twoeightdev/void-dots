## Overview

* Void linux dotfiles for [dwm](http://suckless.org/)
* EFISTUB Void Linux Installation [Guide](https://github.com/hoaxdream/void-dots/blob/main/.config/dev/notes/VOID.md)

## Dwm

<img src="https://github.com/hoaxdream/void-dots/blob/main/.config/dev/screenshot/img_preview01.png">
<img src="https://github.com/hoaxdream/void-dots/blob/main/.config/dev/screenshot/img_preview02.png">


## Dotfiles installation

*Install my dotfiles first with ./setup.sh dot, then type ./setup.sh to pick whatever you want to install.*

```sh
- $ xbps-install -Syu git
- $ git clone https://github.com/hoaxdream/void-bootstrap.git
- $ cd void-bootstrap
- $ ./setup.sh
- $ sudo reboot
- $ dot up                  # this command do --assumed-unchanged and delete LICENSE, README.md in $HOME
- $ dot res                 # this command do --no-assumed-unchanged and restore LICENSE, README.md in $HOME
- $ dot status
- $ dot add
- $ dot commit
- $ dot push
```

## Personal suckless build

- [dwm](https://github.com/hoaxdream/void-dwm)

- [st](https://github.com/hoaxdream/void-st)

- [slock](https://github.com/hoaxdream/void-slock)

- [dwmblocks](https://github.com/hoaxdream/void)

- [dmenu](https://github.com/hoaxdream/void-dmenu)

## Credits
- Thanks to [UtkarshVerma](https://github.com/UtkarshVerma) for [dwmblocks-async](https://github.com/UtkarshVerma/dwmblocks-async)
- Many thanks to [eProTaLT83](https://www.reddit.com/user/eProTaLT83) as he made the patch for [statuspadding](https://dwm.suckless.org/patches/statuspadding/) compatible with [status2d](https://dwm.suckless.org/patches/status2d/).😊

Check the [Guide](https://github.com/hoaxdream/void-dots/blob/main/.config/dev/notes/VOID.md) on how to patch [libxft-bgra](https://github.com/hoaxdream/void-dots/blob/main/.config/dev/patches/libXft-bgra/change.patch) for void linux.
