Void Installation UEFI EFISTUB Guide
====================================

**DISCLAIMER**
---
_I am not responsible for any damages, loss of data, system corruption, or any mishap you may somehow cause by following this guide._
_Use at your own risk._

## Table of Contents

- Bootable Flash Drive
- Pre installation
    - Set shell
    - Change font
    - Check boot mode
    - Check internet connection
    - Partitioning
        - Create partitions
        - Format partitions
        - Mount the filesystem
- Installation
    - Install Base meta package
    - Mount pseudo-filesystems
- Configure system
    - Copy DNS configuration
    - Chroot
    - Localization
    - Timezone
    - Hostname
    - Configure rc.conf
    - Root password
    - Fstab
    - Dracut
    - Non-free repo
    - Bootloader
    - Finalization
- Post installation
    - Services
    - Users
    - Sudoers
    - Change mirrors
- Dot files installation
- Misc
    - void-src
    - libxft patch

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
    - Create partition
        - `$ wipefs -af /dev/nvme0n1   # wipe drive`
        - `$ fdisk /dev/nvme0n1        # use fdisk to partition disk`
        - <code>Type <b>g</b> to set GPT disklabel</code>
    - Format parition
        - `$ mkfs.vfat /dev/nvme0n1p1`
        - `$ mkfs.ext4 /dev/nvme0n1p2`
    - Mount the filesystem
        - `$ mount /dev/nvme0n1p2 /mnt`
        - `$ mkdir /mnt/boot`
        - `$ mount /dev/nvme0n1p1 /mnt/boot`

### Installation

- Install Base meta package
    - `$ REPO=https://mirrors.servercentral.com/voidlinux/current`
    - `$ ARCH=x86_64`
    - `$ XBPS_ARCH=$ARCH xbps-install -S -r /mnt -R "$REPO" base-system`

- Mount pseudo-filesystems
    - `$ mount --rbind /sys /mnt/sys && mount --make-rslave /mnt/sys`
    - `$ mount --rbind /dev /mnt/dev && mount --make-rslave /mnt/dev`
    - `$ mount --rbind /proc /mnt/proc && mount --make-rslave /mnt/proc`

### Configure system

- Copy DNS configuration
    - `$ cp /etc/resolv.conf /mnt/etc/`

- Chroot
    - `$ PS1="(chroot)# " chroot /mnt/ /bin/bash`

- Localization
    - `$ echo "LANG=en_PH.UTF-8" > /etc/locale.conf`
    - `$ echo "LC_COLLATE=C" >> /etc/locale.conf`
    - `$ echo "en_PH.UTF-8 UTF-8" >> /etc/default/libc-locales`
    - `$ xbps-reconfigure -f glibc-locales`

- Timezone
    - `$ ln -sf /usr/share/zoneinfo/Asia/Manila /etc/localtime`

- Hostname
    - `$ echo art > /etc/hostname`

- Configure rc.conf
    - `$ xbps-install -Su neovim`
    - `$ nvim /etc/rc.conf`
    - `$ KEYMAP="us"            # uncomment KEYMAP
    - `$ FONT=LatGrkCyr-12x22   # uncomment FONT`

- Root password
    - `$ passwd`

- Fstab
    - `$ cp /proc/mounts /etc/fstab`
    - `Delete everything except / and /boot then add tmpfs:`
    - `Set root 0 1`
    - `Set boot 0 2`
    - `tmpfs    /tmp    tmpfs   defaults,nosuid,nodev   0 0`
    - `efivarfs /sys/firmware/efi/efivars   efivarfs    defaults    0 0`
    - `$ mount efivarfs`

- Dracut
    - `$ nvim /etc/dracut.conf.d/boot.conf`

```sh
hostonly=yes
hostonly_cmdline=no
use_fstab=yes
compress="cat"
omit_dracutmodules+=" dash i18n rpmversion btrfs lvm qemu multipatch qemu-net lunmask fstab-sys biosdevname dmraid dmsquash-live mdraid nbd nfs "
nofscks=yes
no_hostonly_commandline=yes
```

- Non-free repo
    - `$ xbps-install -Su void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree`
    - `$ xbps-install -Su`
    - `$ xbps-install -Su intel-ucode nvidia efibootmgr`

- Bootloader
    - `$ ls /boot`
    - `$ ROOT_UUID=$(blkid -s UUID -o value /dev/nvme0n1p2)`
    - kernel parameters:

```sh
$ efibootmgr -d /dev/nvme0n1 -p Y -c -L "Void" -l /vmlinuz-5.11.12_1 -u 'root=UUID=$ROOT_UUID ro quiet loglevel=0 console=tty2 nvidia-drm.modeset=1 nowatchdog ipv6.disable=1 udev.log_level=3 initrd=\initramfs-5.11.12_1.img' --verbose
```

- Finalization
    - `$ xbps-query -l | grep linux   # check major and minor; linux5.15`
    - `$ xbps-reconfigure -fa linux<major>.<minor>`
    - `$ exit`
    - `$ umount -R /mnt`
    - `$ reboot`

- EFI Kernel hook
    - `$ nvim /etc/default/efibootmgr-kernel-hook`

```sh
# Options for the kernel hook script installed by the efibootmgr package.
MODIFY_EFI_ENTRIES=1
OPTIONS="root=UUID=xxxx-xxxx-xxx-xxxx ro quiet loglevel=0 console=tty2 nvidia-drm.modeset=1 nowatchdog ipv6.disable=1 udev.log_level=3"
DISK="/dev/nvme0n1"
PART=1
```

### Post installation

- Services
    - `$ cp -R /etc/sv/dhcpcd-eth0 /etc/sv/dhcpcd-enp0s31f6`
    - `$ sed -i 's/eth0/enp0s31f6/' /etc/sv/dhcpcd-enp0s31f6/run`
    - `$ ln -sf /etc/sv/dhcpcd-enp0s31f6 /var/service   # enable internet`
- Users
    - `$ xbps-install -S zsh`
    - `$ useradd -m -G users,wheel,input,video,audio,storage,disk -s /bin/zsh hoaxdream`
    - `$ passwd hoaxdream`
- Sudoers
    - `$ EDITOR=nvim visudo`
    - Exit root and login user
- Change mirrors
    - `$ mkdir -p /etc/xbps.d`
    - `$ cp /usr/share/xbps.d/*-repository-*.conf /etc/xbps.d/`
    - `$ sudo sed -i 's|https://alpha.de.repo.voidlinux.org|https://https://mirrors.servercentral.com/voidlinux|g' /etc/xbps.d/*-repository-*.conf`
    - `$ xbps-install -Su    # update`
    - `$ xpbs-query -L       # check new repo URL`

### Dot files installation

```sh
    - $ sudo xbps-install -Syu git
    - $ git clone https://github.com/hoaxdream/void-bootstrap
    - $ cd bootstrap
    - $ ./1_pkgsinstall
    - $ ./2_dotsetup
    - $ sudo ./2a_partcore   # Run only for fresh disk
    - $ sudo ./2b_partdata   # Run only for fresh disk
    - $ sudo ./3_postinstall
    - $ ./4_fmanager
    - $ sudo reboot
```

### Misc

- void-src
    - `$ git clone https://github.com/void-linux/void-packages.git`
    - `$ cd void-packages`
    - `$ ./xbps-src binary-bootstrap`
    - `$ echo XBPS_ALLOW_RESTRICTED=yes >> etc/conf`
    - Builde a package:
        - `$ ./xbps-src pkg <package_name>`
        - `$ xbps-install -S xtools`
        - `$ cd void-packages/masterdir`
        - `$ xi <package_name>`
- libxft patch
    - `$ cd void-packages/srcpkgs/libXft`
    - `$ mkdir patches`
    - Copy the patch inside patches directory:
        - `$ cd void-packages`
        - `$ ./xbps-src pkg -f libXft`
        - `$ sudo xbps-install -R./hostdir/binpkgs -f libXft`
        - `$ sudo xbps-install -R./hostdir/binpkgs -f libXft-devel`
        - `$ sudo xbps-pkgdb -m repolock libXft  # avoid overwritten by updates`
- run as user service
    - `$ sudo mkdir -p /etc/sv/hoaxdream/`
    - `$ sudo touch /etc/sv/hoaxdream/run`
    - `$ sudo chmod +x /etc/sv/hoaxdream/run`
    - `$ sudo -E nvim /etc/sv/hoaxdream/run`
    - run:
```sh
#!/bin/sh

UID=$(pwd -P)
UID=${UID##*/}

if [ -d "/home/${UID}/.local/var/service" ]; then
 chpst -u"${UID}" runsvdir /home/${UID}/.local/var/service
fi
```
- symlink services
    - `$ ln -s ~/.config/sv/transmission-daemon ~/.local/var/service/transmission-daemon`
    - `$ sv status ~/.local/var/service/transmission-daemon`
