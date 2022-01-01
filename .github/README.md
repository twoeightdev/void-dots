## Overview

* Arch linux dotfiles for [bspwm](https://github.com/baskerville/bspwm) [dwm](http://suckless.org/) & [xmonad](https://github.com/xmonad/xmonad)
* EFISTUB Arch Linux Installation [Guide](https://github.com/hoaxdream/dots/blob/main/.github/INSTALL.md)
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
- $ git clone --bare https://github.com/hoaxdream/dots.git $HOME/.config/dots
- $ git --git-dir=$HOME/.config/dots/ --work-tree=$HOME checkout
- $ git --git-dir=$HOME/.config/dots/ --work-tree=$HOME config --local status.showUntrackedFiles no
```
 ---
## Dependencies
```
  - xorg-server xorg-xwininfo xorg-xprop xorg-xdpyinfo
  - xorg-xset xorg-xsetroot xorg-xinit xterm
  - nvidia nvidia-utils lib32-nvidia-utils nvidia-settings
  - vulkan-icd-loader lib32-vulkan-icd-loader
  - xcape mlocate man-db wget zip unzip unrar dosfstools ntfs-3g
  - xdg-user-dirs xclip xdo xdotool mediainfo transmission-cli bc tree
  - pulseaudio-alsa pulsemixer pamixer
  - ttf-joypixels ttf-dejavu ttf-nerd-fonts-symbols ttf-roboto-mono
  - noto-fonts noto-fonts-emoji ttf-liberation ttf-ibm-plex
  - youtube-dl ffmpeg maim sxiv xwallpaper imagemagick
  - newsboat picom mpd mpc mpv ncmpcpp
  - zathura zathura-pdf-mupdf poppler python-adblock cronie
  - dunst libnotify gucharmap htop discord
  - qutebrowser steam signal-desktop transmission-cli
  - wine-staging lib32-giflib lib32-libpng lib32-gnutls lib32-mpg123
  - lib32-openal lib32-v4l-utils lib32-libpulse lib32-libjpeg-turbo
  - lib32-libxcomposite lib32-libgcrypt lib32-libxinerama ocl-icd lib32-ocl-icd
  - lib32-libxslt lib32-libva lib32-gtk3 lib32-gst-plugins-base-libs lutris
  - tremc(aur) libxft-bgra-git(aur)
```
