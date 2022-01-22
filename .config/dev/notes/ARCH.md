# Arch UEFI EFISTUB Install
**DISCLAIMER**
---
_I am not responsible for any damages, loss of data, system corruption, or any mishap you may somehow cause by following this guide._
_Use at your own risk or use [Arch Wiki](https://wiki.archlinux.org/index.php/installation_guide) as your guide._

#### Before booting from usb stick check your hardware settings
- Disable Secure Boot
- Disable Launch CSM or Legacy Support
- Set Boot Mode to UEFI

#### Burn ISO with CLI using dd
```
  - $ dd bs=4M if=path/to/archlinux.iso of=/dev/sdx conv=fsync oflag=direct status=progress
```

#### Change font
```
  - $ setfont ter-132b
```

#### Verify the boot mode
  - If the command shows the directory without error, then the system is **UEFI**
```
  - $ efivar -l
```

#### Test internet connection
```
- $ ping -c 3 archlinux.org
```

#### Update system clock
```
  - $ timedatectl set-ntp true
  - $ timedatectl status
```
---
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
  - $ mkfs.fat -n BOOT -F 32 /dev/nvme0n1p1
  - $ mkfs.ext4 -L SYSTEM /dev/nvme0n1p2
```
- **Mount disk**
```
  - $ mount /dev/nvme0n1p2 /mnt
  - $ mkdir /mnt/boot
  - $ mount /dev/nvme0n1p1 /mnt/boot
```
---
#### Pacstrap
- **Change dns** if mirrors failed for some reason in _/etc/resolv.conf_
```
  - $ vim /etc/resolv.conf             # if mirrors failed for some reason
  - nameserver 1.1.1.1
  - $ vim /etc/pacman.d/mirrorlist     # edit mirrors
```
- **Pacstrap packages**
```
  - $ pacstrap /mnt base base-devel linux linux-firmware nvidia nvidia-utils nvidia-settings git neovim efibootmgr intel-ucode
```
---
#### System Configuration
- **Fstab**
```
  - $ genfstab -U /mnt >> /mnt/etc/fstab
```
- **Chroot** into the new system
```
  - $ arch-chroot /mnt
```
- **Set timezone**
```
  - $ ln -sf /usr/share/zoneinfo/Asia/Manila /etc/localtime
  - $ hwclock --systohc --utc
```
- **Localization**
```
  - $ nvim /etc/locale.gen      # uncomment prefer language
  - $ locale-gen
  - $ echo LANG=en_PH.UTF-8 > /etc/locale.conf
```
- **Network configuration**
```
  - $ echo art > /etc/hostname
  - $ nvim /etc/hosts     # add matching entries to host, with the configuration below
```
```javascript
127.0.0.1    localhost
::1          localhost
127.0.1.1    art.localdomain art
```
- **Install your preferred network management software**
  - **Systemd-networkd**
```
    - $ ip addr                                         # find the name of your network adapter
    - $ systemctl enable systemd-networkd.service
    - $ nvim /etc/systemd/network/20-wired.network      # configure adapter, with the configuration below
```
  - **Networkmanager**
```
    - $ pacman -S networkmanager
    - $ systemctl enable NetworkManager
```
```javascript
[Match]
Name=enp0s31f6

[Network]
DHCP=yes
DNS=1.1.1.1
```
- **Root password**
```
  - $ passwd
```
- **Efistub Boot loader**
```
  - $ lsblk -f                          # Get root UUID
  - $ efibootmgr -b <bootnum> -B        # Delete old boot entry
```
  - create boot entry: Where _/dev/nvme0nX_ and _Y_ are the drive and partition number where the ESP is located.
  ```javascript
  - $ ROOT_UUID=$(blkid -s UUID -o value /dev/nvme0n1p2)
  - $ efibootmgr -d /dev/nvme0n1 -p Y -c -L "Arch" -l /vmlinuz-linux -u 'root=UUID=$ROOT_UUID rw quiet loglevel=3 vga=current nvidia-drm.modeset=1 kernel.nmi_watchdog=0 random.trust_cpu=1 ipv6.disable=1 rd.systemd.show_status=false rd.udev.log_level=3 initrd=\intel-ucode.img initrd=\initramfs-linux.img' --verbose
  ```
- **Grub Boot loader**
```
  - $ pacman -S grub efibootmgr intel-ucode
  - $ grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
  - $ grub-mkconfig -o /boot/grub/grub.cfg
```
- **Exit the chroot environment**
```
  - exit
  - umount -R /mnt
  - reboot
```
  - login as root
```
  - $ pacman -Syu
```
- **Enable multilib**
  - uncomment in _/etc/pacman.conf_
```javascript
[multilib]
include = /etc/pacman.d/mirrorlist
```
  - **Update repository**
```
  - $ pacman -Syu
```
- **Add user**
```
  - $ pacman -S zsh
  - $ useradd -m -G users,wheel,video,audio,storage,disk -s /bin/zsh hoaxdream
  - $ passwd hoaxdream
```
- **Add sudoers**
```
  - $ EDITOR=nvim visudo
```
  - uncomment wheel group
```javascript
%wheel ALL=(ALL) ALL
```
  - logout root
  - login with created username and password
```
  - $ sudo pacman -Syu
```
---
#### Install automatically with script
- **Bootstrap script**
```
  - $ sudo pacman -S git
  - $ git clone https://github.com/hoaxdream/bootstrap
  - $ cd bootstrap
  - $ ./pkgsinstall
  - $ reboot
  - $ ./dotsetup
  - $ sudo ./postinstall
  - $ reboot
  - $ startx
  - $ sudo -E systemctl edit --full systemd-fsck-root.service
  - $ sudo -E systemctl edit --full systemd-fsck@.service
  - $ reboot
```
#### Installation of packages manually
- **Arch AUR helper**
```
  - $ curl -LO https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz
  - $ tar xvzf yay.tar.gz
  - $ cd yay
  - $ makepkg -sci
```
- **Packages**
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
---
### Window manager
- **Dwm**
```
  - $ git clone https://git.suckless.org/dwm ~/.config/dwm
  - $ git clone https://git.suckless.org/st ~/.config/st
  - $ git clone https://git.suckless.org/dmenu ~/.config/dmenu
  - $ make && sudo make install`-`in each directory and install
```
- **Xmonad**
```
  - $ sudo pacman -S xmonad xmonad-contrib xmobar
```
- **Bspwm**
```
  - $ sudo pacman -S bspwm sxhkd
```
---
### Install dotfiles
```
  - Remove stock configuration in $HOME, else error will occur.
  - $ echo "dots" >> .gitignore
  - $ git clone --bare https://github.com/hoaxdream/dots.git $HOME/.config/dots
  - $ git --git-dir=$HOME/.config/dots/ --work-tree=$HOME checkout
  - $ git --git-dir=$HOME/.config/dots/ --work-tree=$HOME config --local status.showUntrackedFiles no
```
### File manager
- **nnn**
```
  - $ git clone https://github.com/jarun/nnn
  - $ cd nnn
  - $ make O_NERD=1 && sudo make install        # enable icons
  - install advcp nad advmv
  - $ wget http://ftp.gnu.org/gnu/coreutils/coreutils-8.32.tar.xz
  - $ tar xvJf coreutils-8.32.tar.xz
  - $ cd coreutils-8.32/
  - $ wget https://raw.githubusercontent.com/jarun/advcpmv/master/advcpmv-0.8-8.32.patch
  - $ patch -p1 -i advcpmv-0.8-8.32.patch
  - $ ./configure
  - $ make
  - install binaries and use cpg -g and mvg -g instead of cp and mv (prefered)
  - $ sudo mv ./src/cp /usr/local/bin/cpg
  - $ sudo mv ./src/mv /usr/local/bin/mvg
  - $ or install the binaries and create aliases
  - $ sudo mv ./src/cp /usr/local/bin/advcp
  - $ sudo mv ./src/mv /usr/local/bin/advmv
  - $ echo alias cp '/usr/local/bin/advcp -g' >> ~/.config/zsh/aliasrc
  - $ echo alias mv '/usr/local/bin/advmv -g' >> ~/.config/zsh/aliasrc
```
### Start session
```
  - $ startx
```
