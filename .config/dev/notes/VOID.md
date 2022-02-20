Void Installation UEFI EFISTUB Guide
====================================

**DISCLAIMER**
---
_I am not responsible for any damages, loss of data, system corruption, or any mishap you may somehow cause by following this guide._
_Use at your own risk._

## Table of Contents

- [Bootable Flash Drive](https://github.com/hoaxdream/void-dots/blob/main/.config/dev/notes/VOID.md#bootable-flash-drive)
- [Pre installation](https://github.com/hoaxdream/void-dots/blob/main/.config/dev/notes/VOID.md#pre-installation)
    - Set shell
    - Change font
    - Check boot mode
    - Check internet connection
    - Partitioning
        - Create partitions
        - Format partitions
        - Mount the filesystem
- [Installation](https://github.com/hoaxdream/void-dots/blob/main/.config/dev/notes/VOID.md#installation)
    - Install Base meta package
    - Mount pseudo-filesystems
- [Configure system](https://github.com/hoaxdream/void-dots/blob/main/.config/dev/notes/VOID.md#configure-system)
    - Copy DNS configuration
    - Chroot
    - Multilib and Non-free
    - Localization
    - Timezone
    - Hostname
    - Hosts
    - Network
    - Configure rc.conf
    - Root password
    - Fstab
    - Dracut
    - Bootloader
    - Finalization
- [Post installation](https://github.com/hoaxdream/void-dots/blob/main/.config/dev/notes/VOID.md#post-installation)
    - Users
    - Sudoers
- [Dot files installation](https://github.com/hoaxdream/void-dots/blob/main/.config/dev/notes/VOID.md#dot-files-installation)
- [Misc](https://github.com/hoaxdream/void-dots/blob/main/.config/dev/notes/VOID.md#misc)
    - EFI kernel hook
    - void-src
    - libxft patch
    - run as user service

---

###  Bootable Flash Drive

```sh
$ dd bs=4M if=path/to/voidlinux.iso of=/dev/sdx conv=fsync oflag=direct status=progress
```

### Pre installation

- Set shell
```sh
- $ bash
```

- Change font
```sh
$ setfont LatGrkCyr-12x22
```

- Check boot mode
```sh
- $ ls /sys/firmware/efi    # shows output if it's UEFI
```

- Check internet connection
```sh
- $ ping -c 3 voidlinux.org
```

Mount point | Partition | Partition type | Suggested size
| --- | --- | --- | --- |
| /mnt/boot | /dev/nvme0n1p1 | EFI system partition | 512 MiB |
| /mnt | /dev/nvme0n1p2 | Linux Filesystem | Remainder of the device |


- Partitioning
```sh
    - Create partition
        - $ wipefs -af /dev/nvme0n1   # wipe drive
        - $ fdisk /dev/nvme0n1        # use fdisk to partition disk
        - <code>Type <b>g</b> to set GPT disklabel</code>
    - Format parition
        - $ mkfs.vfat /dev/nvme0n1p1
        - $ mkfs.ext4 /dev/nvme0n1p2
    - Mount the filesystem
        - $ mount /dev/nvme0n1p2 /mnt
        - $ mkdir /mnt/boot
        - $ mount /dev/nvme0n1p1 /mnt/boot
```

### Installation

- Install Base meta package
```sh
    - $ REPO=https://mirrors.servercentral.com/voidlinux/current
    - $ ARCH=x86_64
    - $ mkdir -p /mnt/var/db/xbps/keys
    - $ cp /var/db/xbps/keys/* /mnt/var/db/xbps/keys/   # copy RSA keys
    - $ XBPS_ARCH=$ARCH xbps-install -S -r /mnt -R "$REPO" base-system
```

- Mount pseudo-filesystems
```sh
    - $ mount --rbind /sys /mnt/sys && mount --make-rslave /mnt/sys
    - $ mount --rbind /dev /mnt/dev && mount --make-rslave /mnt/dev
    - $ mount --rbind /proc /mnt/proc && mount --make-rslave /mnt/proc
```

### Configure system

- Copy DNS configuration
```sh
    - $ cp /etc/resolv.conf /mnt/etc/
nameserver 1.1.1.1
nameserver 1.0.0.1
```

- Chroot
```sh
    - $ PS1="(chroot)# " chroot /mnt/ /bin/bash
```

- Non-free repo
```sh
    - $ xbps-install -Su void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree
    - $ xbps-install -Su
    - $ cp /usr/share/xbps.d/*-repository-*.conf /etc/xbps.d/   # copy mirrors
    - $ sed -i 's|https://alpha.de.repo.voidlinux.org|https://mirrors.servercentral.com/voidlinux|g' /etc/xbps.d/*-repository-*.conf   # change mirrors
    - $ xbps-install -Su    # update
    - $ xpbs-query -L       # check new repo URL
```

- Localization
```sh
    - $ echo "LANG=en_PH.UTF-8" > /etc/locale.conf
    - $ echo "LC_COLLATE=C" >> /etc/locale.conf
    - $ echo "en_PH.UTF-8 UTF-8" > /etc/default/libc-locales
    - $ echo "en_PH ISO-8859-1" >> /etc/default/libc-locales
    - $ xbps-reconfigure -f glibc-locales
```

- Timezone
```sh
    - $ ln -sf /usr/share/zoneinfo/Asia/Manila /etc/localtime
    - $ xbps-install -Su neovim
```

- Hostname
```sh
    - $ echo art > /etc/hostname
```

- Hosts
```sh
127.0.0.1       localhost
::1             localhost
192.168.0.100   art.localdomain art

```

- Network
```
    - # 1st method: /etc/rc.local
    - ip link set dev enp0s31f6 up
    - ip addr add 192.168.0.100/24 brd + dev enp0s31f6
    - ip route add default via 192.168.0.1
    - # 2nd method dhcpcd
    - $ echo "static ip_address=192.168.0.1/100" >> /etc/dhcpcd.conf
    - $ echo "static routers=192.168.0.1" >> /etc/dhcpcd.conf
    - $ ehco "static domain_name_servers=1.1.1.1 1.0.0.1" >> /etc/dhcpcd.conf
    - $ cp -R /etc/sv/dhcpcd-eth0 /etc/sv/dhcpcd-enp0s31f6
    - $ sed -i 's/eth0/enp0s31f6/' /etc/sv/dhcpcd-enp0s31f6/run
    -
```

- Configure rc.conf
```sh
    - $ nvim /etc/rc.conf
    - $ KEYMAP="us"             # uncomment KEYMAP
    - $ FONT=LatGrkCyr-12x22    # uncomment FONT
```

- Root password
```sh
    - $ passwd
```

- Fstab
```sh
    - $ cp /proc/mounts /etc/fstab
    - Delete everything except / and /boot then add tmpfs and efivarfs:
    - Get UUID inside nvim with :r !blkid /dev/nvme0n1p2
    - Set root 0 1
    - Set boot 0 2
    - tmpfs    /tmp    tmpfs   defaults,nosuid,nodev   0 0
    - efivarfs /sys/firmware/efi/efivars   efivarfs    defaults    0 0
    - $ mount efivarfs`
```

- Dracut
```sh
    - $ nvim /etc/dracut.conf.d/boot.conf
```

```sh
hostonly=yes
hostonly_cmdline=no
use_fstab=yes
compress="cat"
# omit_dracutmodules+ is just one line. i just put \ so i can easily read them.
# and this comment is not included with boot.conf
omit_dracutmodules+=" dash i18n rpmversion convertfs btrfs lvm qemu \
multipatch qemu-net lunmask fstab-sys securityfs biosdevname \
dmraid dmsquash-live mdraid nbd nfs "
nofscks=yes
no_hostonly_commandline=yes
early_microcode=yes
```

- Bootloader
```sh
    - $ xbps-install -Su intel-ucode nvidia efibootmgr
    - $ ls /boot    # show kernel version
    - $ blkid -s UUID -o value /dev/nvme0n1p2   # root parition UUID
    # in my case i use nvme so i'll just do /dev/nvme0n1p2 -> root nvme partition
    # it is much better if you use UUID.
    # this is just one line kernel parameter i just put \ so i can easily read them.
    - $ efibootmgr -d /dev/nvme0n1 -p Y -c -L "Void" -l /vmlinuz-5.11.12_1 -u \
    - $ 'root=/dev/nvme0n1p2 rw quiet loglevel=0 console=tty2 nvidia-drm.modeset=1 \
    - $ nowatchdog ipv6.disable=1 udev.log_level=3 \
    - $ initrd=\initramfs-5.11.12_1.img' --verbose
```

- Finalization
```sh
    - $ xbps-query -l | grep linux  # check major and minor; linux5.15
    - $ xbps-reconfigure -fa linux<major>.<minor>
    - $ exit
    - $ umount -R /mnt
    - $ reboot
```

### Post installation

- Users
```sh
    # enable internet if using dhcpcd
    # if using rc.local no need to do this and just skip to installing zsh and add user.
    - $ ln -sf /etc/sv/dhcpcd-enp0s31f6 /var/service
    - $ xbps-install -S zsh
    - $ useradd -m -G users,wheel,input,video,audio,storage,disk -s /bin/zsh hoaxdream
    - $ passwd hoaxdream
```

- Sudoers
```sh
    # edit sudoers
    - $ visudo
    - Exit root and login user
```

### Dot files installation

```sh
    - $ sudo xbps-install -Syu git
    - $ git clone https://github.com/hoaxdream/void-bootstrap
    - $ cd void-bootstrap
    - $ sudo ./hhd.sh       # Run only for fresh disk configured for my system
    - $ sudo ./ssd.sh       # Run only for fresh disk configured for my system
    - $ ./setup.sh          # You only need this, install dot first
    - $ sudo ./root.sh      # Needs to be run as root configured for my system
    - $ sudo ./post.sh      # Needs to be run as root configured for my system
    - $ sudo reboot
```

### Misc

- EFI Kernel hook
```sh
    - $ nvim /etc/default/efibootmgr-kernel-hook
```

```sh
# Options for the kernel hook script installed by the efibootmgr package.
MODIFY_EFI_ENTRIES=1
OPTIONS="root=/dev/nvme0n1p2 rw quiet loglevel=0 console=tty2 nvidia-drm.modeset=1 nowatchdog ipv6.disable=1 udev.log_level=3"
DISK="/dev/nvme0n1"
PART=1
```

- void-src
```sh
    - $ git clone https://github.com/void-linux/void-packages.git
    - $ cd void-packages
    - $ ./xbps-src binary-bootstrap
    - $ echo XBPS_ALLOW_RESTRICTED=yes >> etc/conf
    - Builde a package:
        - $ ./xbps-src pkg <package_name>
        - $ xbps-install -S xtools
        - $ cd void-packages/masterdir
        - $ xi <package_name>
```

- libxft patch
```sh
    - $ cd void-packages/srcpkgs/libXft
    - $ mkdir patches
    - Copy the patch inside patches directory:
        - $ cd void-packages
        - $ ./xbps-src pkg -f libXft
        - $ sudo xbps-install -R./hostdir/binpkgs -f libXft
        - $ sudo xbps-install -R./hostdir/binpkgs -f libXft-devel
        - $ sudo xbps-pkgdb -m repolock libXft  # avoid overwritten by updates
```

- run as user service
```sh
    - $ sudo mkdir -p /etc/sv/hoaxdream/
    - $ sudo touch /etc/sv/hoaxdream/run
    - $ sudo chmod +x /etc/sv/hoaxdream/run
    - $ sudo -E nvim /etc/sv/hoaxdream/run
```

```sh
#!/bin/sh

UID=$(pwd -P)
UID=${UID##*/}

if [ -d "/home/${UID}/.local/var/service" ]; then
 chpst -u"${UID}" runsvdir /home/${UID}/.local/var/service
fi
```

- symlink services
```sh
    - $ ln -s ~/.config/sv/transmission-daemon ~/.local/var/service/transmission-daemon
    - $ sv status ~/.local/var/service/transmission-daemon
```
