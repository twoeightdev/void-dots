#### Void Installation UEFI EFISTUB Guide
---
#### Login as root then change shell and font
```
  - $ username: root
  - $ password: voidlinux
  - $ bash
  - $ ls /usr/share/kbd/consolefonts  # list of fonts available
  - $ setfont LatGrkCyr-12x22         # set font
```
#### Prepare disk
**Mount point** | **Partition** | **Partition type** | **Suggested size**
| :---: | :---: | :---: | :---: |
/mnt/boot | /dev/nvme0n1p1 | EFI system partition | 512 MiB
/mnt | /dev/nvme0n1p2 | Linux Filesystem | Remainder of the device
- **Partition drive**
```
  - $ lsblk -f                # check which drive you want to use
  - $ fdisk /dev/nvme0n1
  - Create GPT disklabel
  - Use the chart above
```
- **Format drive**
```
  - $ mkfs.fat -F 32 /dev/nvme0n1p1
  - $ mkfs.ext4 /dev/nvme0n1p2
```
- **Mount disk**
```
  - $ mount /dev/nvme0n1p2 /mnt
  - $ mkdir /mnt/boot
  - $ mount /dev/nvme0n1p1 /mnt/boot
```
---
#### Base Installation
```
  - $ REPO=https://alpha.de.repo.voidlinux.org/current
  - $ ARCH=x86_64
  - $ XBPS_ARCH=$ARCH xbps-install -S -r /mnt -R "$REPO" base-system
```

#### Configuration
- **Enter Chroot**
```
  - $ mount --rbind /sys /mnt/sys && mount --make-rslave /mnt/sys
  - $ mount --rbind /dev /mnt/dev && mount --make-rslave /mnt/dev
  - $ mount --rbind /proc /mnt/proc && mount --make-rslave /mnt/proc
  - $ for dir in dev proc sys run; do mount --rbind /$dir /mnt/$dir; mount --make-rslave /mnt/$dir; done  # alternative
  - $ cp /etc/resolv.conf /mnt/etc/
  - $ PS1='(chroot) # ' chroot /mnt/ /bin/bash
```
- **Installation Configuration** if installing a glibc distribution, edit /etc/default/libc-locales, uncommenting desired locales.
```
  - $ echo "LANG=en_PH.UTF-8" > /etc/locale.conf
  - $ echo "LC_COLLATE=C" >> /etc/locale.conf
  - $ echo "en_PH.UTF-8 UTF-8" >> /etc/default/libc-locales
  - $ xbps-reconfigure -f glibc-locales
  - $ ln -sf /usr/share/zoneinfo/Asia/Manila /etc/localtime   # set timezone
  - $ echo art > /etc/hostname                                # set hostname
  - $ nvim /etc/rc.conf                                       # uncomment FONT to change console font
  - FONT=LatGrkCyr-12x22
  - $ passwd                                                  # Set password
```
- **Fstab**
```
  - $ cp /proc/mounts /etc/fstab                              # Generate fstab
  - Delete everything except / and /boot then add tmpfs:
  - line to 2. These values configure the behaviour of fsck.
  - Example below
  /dev/nvme0n1p1   /boot       vfat    rw,relatime,[...]       0 0
  /dev/nvme0n1p2   /           ext4    rw,relatime             0 0

  - Change /boot to 0 2; / to 0 1, then change to UUID;
  - to get the UUID inside neovim type :r !blkid /dev/nvme0n1xx
  UUID=6914[...]   /boot       vfat    rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro  0 2
  UUID=dc1b[...]   /           ext4    rw,relatime             0 1
  - Add an entry to mount /tmp in RAM:
  tmpfs           /tmp        tmpfs   defaults,nosuid,nodev   0 0
```
-- **Dracut**
```
  - $ nvim /etc/dracut.conf.d/boot.conf
  hostonly=yes
  hostonly_cmdline=no
  use_fstab=yes
  compress="cat"
  omit_dracutmodules+=" dash i18n rpmversion btrfs lvm qemu multipatch qemu-net lunmask fstab-sys biosdevname dmraid dmsquash-live mdraid nbd nfs "
```
-- **Finishing install**
```
  - $ xbps-install -Su void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree
  - $ xbps-install -Su
  - $ xbps-install -Su intel-ucode nvidia
```
- **EFIBSTUB**
```
  - $ ROOT_UUID=$(blkid -s UUID -o value /dev/nvme0n1p2)
  - $ efibootmgr -d /dev/nvme0n1 -p Y -c -L "Void" -l /vmlinuz-5.11.12_1 -u 'root=UUID=$ROOT_UUID rw quiet loglevel=3 console=tty2 nvidia-drm.modeset=1 nowatchdog ipv6.disable udev.log_level=3 initrd=\initramfs-5.11.12_1.img' --verbose
```
- **GRUB**
```
  - $ xbps-install grub-x86_64-efi
  - $ grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id="Void"
```
- **Finalization**
```
  - $ xbps-query -l | grep linux                # check major and minor; linux5.15
  - $ xbps-reconfigure -f linux<major>.<minor>
  - $ exit
  - $ umount -R /mnt
  - $ reboot
```
- **Post Install**
```
  - $ xbps-install -S zsh
  - $ useradd -m -G users,wheel,input,video,audio,storage,disk -s /bin/zsh hoaxdream
  - $ passwd hoaxdream
  - $ EDITOR=nvim visudo
```

#### Packages

- xorg-server
- xwininfo
- xprop
- xdpyinfo
- xset
- xsetroot
- xinit
- xterm
- xcape
- xclip
- xdo
- xdotool
- nvidia
- nvidia-libs
- nvidia-libs-32bit
- vulkan-loader
- vulkan-loader-32bit
- mlocate
- man-db
- git
- wget
- python3-adblock
- zip
- unzip
- unrar
- dosfstools
- ntfs-3g
- xdg-user-dirs
- mediainfo
- bc
- tree
- alsa-plugins-pulseaudio
- pulsemixer
- pamixer
- noto-fonts-emoji
- noto-fonts-ttf
- dejavu-fonts-ttf
- liberation-fonts-ttf
- fonts-roboto-ttf
- font-ibm-plex-ttf
- youtube-dl
- ffmpeg
- maim
- sxiv
- xwallpaper
- ImageMagick
- newsboat
- picom
- mpd
- mpc
- mpv
- ncmpcpp
- zathura
- zathura-pdf-mupdf
- poppler
- dunst
- libnotify
- gucharmap
- qutebrowser
- steam
- Signal-Desktop
- tremc

#### dwm
- base-devel libX11-devel libXft-devel libXinerama-devel

#### New packages
xorg-server
xwininfo
xprop
xdpyinfo
xset
xsetroot
xinit
xterm
nvidia
nvidia-libs
nvidia-libs-32bit
vulkan-loader
vulkan-loader-32bit
xcape
mlocate
man-db
wget
zip
unzip
unrar
dosfstools
ntfs-3g
xdg-user-dirs
xclip
xdo
xdotool
mediainfo
bc
tree
pulseaudio
alsa-plugins-pulseaudio
pulsemixer
pamixer
nerd-fonts
dejavu-fonts-ttf
fonts-roboto-ttf
noto-fonts-ttf
noto-fonts-emoji
liberation-fonts-ttf
yt-dlp
ffmpeg
maim
sxiv
xwallpaper
ImageMagick
newsboat
picom
mpd
mpc
mpv
ncmpcpp
zathura
zathura-pdf-mupdf
poppler
python3-adblock
cronie
dunst
libnotify
gucharmap
htop
qutebrowser
qrencode
steam
neomutt
notmuch
isync
msmtp
readline-devel
lm_sensors

# Wine
wine
giflib-32bit
libpng-32bit
gnutils-32bit
libmpg123-32bit
libopenal-32bit
v4l-utils-32bit
libpulseaudio-32bit
libjpeg-turbo-32bit
libXcomposite-32bit
libgcrypt-32bit
libXinerama-32bit
ocl-icd
ocl-icd-32bit
libxslt-32bit
libva-32bit
gst-plugins-base1-32bit
lutris

# Missing
signal-cli
siggo
libxft-bgra-git
discord
lib32-gtk3

# Missing and to be replace
transmission-cli - rtorrent
tremc - rtorrent
