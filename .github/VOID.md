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
  - $ REPO=https://alpha.de.repo.voidlinux.org/current  # or below
  - $ REPO=https://void.webconverger.org/current
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
  - $ xbps-install -Su neovim
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
  - Mount efivars
  efivarfs  /sys/firmware/efi/efivars  efivarfs  defaults     0 0
  - $ mount efivarfs
```
-- **Dracut**
```
  - $ nvim /etc/dracut.conf.d/boot.conf
  hostonly=yes
  hostonly_cmdline=no
  use_fstab=yes
  compress="cat"
  omit_dracutmodules+=" dash i18n rpmversion btrfs lvm qemu multipatch qemu-net lunmask fstab-sys biosdevname dmraid dmsquash-live mdraid nbd nfs "
  nofscks=yes
  no_hostonly_commandline=yes
```
-- **Finishing install**
```
  - $ xbps-install -Su void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree
  - $ xbps-install -Su
  - $ xbps-install -Su intel-ucode nvidia efibootmgr
```
- **EFIBSTUB**
```
  - $ ls /boot
  - $ ROOT_UUID=$(blkid -s UUID -o value /dev/nvme0n1p2)
  - $ efibootmgr -d /dev/nvme0n1 -p Y -c -L "Void" -l /vmlinuz-5.11.12_1 -u 'root=UUID=$ROOT_UUID ro quiet loglevel=0 console=tty2 nvidia-drm.modeset=1 nowatchdog ipv6.disable=1 udev.log_level=3 initrd=\initramfs-5.11.12_1.img' --verbose
```
- **GRUB**
```
  - $ xbps-install grub-x86_64-efi
  - $ grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id="Void"
```
- **Finalization**
```
  - $ xbps-query -l | grep linux                # check major and minor; linux5.15
  - $ xbps-reconfigure -fa linux<major>.<minor>
  - $ exit
  - $ umount -R /mnt
  - $ reboot
```
- **Post Install**
```
  - $ ln -sf /etc/sv/dhcpcd /var/service    # enable internet
  - $ xbps-install -S zsh
  - $ useradd -m -G users,wheel,input,video,audio,storage,disk -s /bin/zsh hoaxdream
  - $ passwd hoaxdream
  - $ EDITOR=nvim visudo
  - exit root and login user
```
#### Change mirrors
```
  - $ mkdir -p /etc/xbps.d
  - $ cp /usr/share/xbps.d/*-repository-*.conf /etc/xbps.d/
  - $ sudo sed -i 's|https://alpha.de.repo.voidlinux.org|https://void.webconverger.org|g' /etc/xbps.d/*-repository-*.conf
  - $ xbps-install -Su    # update
  - $ xpbs-query -L       # check new repo URL
```
#### Bootstrap [void-bootstrap](https://github.com/hoaxdream/void-bootstrap)
```
  - $ sudo xbps-install -Syu git
  - $ git clone https://github.com/hoaxdream/void-bootstrap
  - $ cd bootstrap
  - $ ./pkgsinstall
  - $ ./dotsetup
  - $ sudo ./partcore   # Run only for fresh disk
  - $ sudo ./partdata   # Run only for fresh disk
  - $ sudo ./postinstall
  - $ ./fmanager
  - $ sudo reboot
```
#### void src
```
- $ git clone https://github.com/void-linux/void-packages.git
- $ cd void-packages
- $ ./xbps-src binary-bootstrap
- $ echo XBPS_ALLOW_RESTRICTED=yes >> etc/conf
- Build a package:
  - $ ./xbps-src pkg <package_name>
  - $ xbps-install -S xtools
  - $ cd void-packages/masterdir
  - $ xi <package_name>
```
#### libxft-bgra
```
- $ cd void-packages/srcpkgs/libXft
- $ mkdir patches
- Copy the patch inside patches directory
- $ cd void-packages
- $ ./xbps-src pkg -f libXft
- $ sudo xbps-install -R./hostdir/binpkgs -f libXft
- $ sudo xbps-install -R./hostdir/binpkgs -f libXft-devel
- $ sudo xbps-pkgdb -m repolock libXft  # avoid overwritten by updates
```

# Missing
signal-cli
siggo
libxft-bgra-git
discord
lib32-gtk3
