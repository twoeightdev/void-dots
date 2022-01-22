# Gentoo UEFI EFISTUB Install
**DISCLAIMER**
---
_I am not responsible for any damages, loss of data, system corruption, or any mishap you may somehow cause by following this guide._
Use at your own risk or use [Arch Wiki](https://wiki.archlinux.org/index.php/installation_guide) as your guide.


**Before booting from usb stick check your hardware settings**
- Disable Secure Boot
- Disable Launch CSM or Legacy Support
- Set Boot Mode to **UEFI**

**Burn ISO with CLI using dd**
  - `dd bs=4M if=path/to/archlinux.iso of=/dev/sdx status=progress oflag=sync`

**Verify the boot mode**
    - If the command shows the directory without error, then the system is **UEFI**

  - `efivar -l`

**Test internet connection**
- `ping -c 3 gentoo.org`

**Prepare disk**
**Mount point** | **Partition** | **Partition type** | **Suggested size**
| :---: | :---: | :---: | :---: |
/mnt/boot | /dev/sdX1 | EFI system partition | 512 MiB
/mnt | /dev/sdX2 | Linux Filesystem | Remainder of the device
- **Partition drive**where _`X`_ is the number of the drive you want to use
  - `lsblk -f` - check which drive you want to use
  - `fdisk /dev/sdX`
  - Create **GPT** disklabel
  - Use the chart above
- **Format drive**
  - `mkfs.fat -n BOOT -F32 /dev/sdx1`
  - `mkfs.ext4 -L SYSTEM /dev/sdx2`
- **Mount disk**
  - `mount /dev/sdx2 /mnt/gentoo`
  - `mkdir /mnt/gentoo/boot`
  - `mount /dev/sdx1 /mnt/gentoo/boot`

**Base system install**
- **Sync date**
  - `date`
  - `ntpdate -u pool.ntp.org`
- **Stage 3 tarball**
  - `links https://www.gentoo.org/downloads/mirrors/
  - `links https://github.com/hoaxdream/portage/`
  - `tar xpvf stage3-* --xattrs-include='*.*' --numeric-owner`
  - `nano -w /mnt/gentoo/etc/portage/make.conf`

```
CFLAGS="-march=native -O2 -pipe"
MAKE_OPTS="-j8"
L10N="en-ph"
ACCEPT_LICENSE="*"

USE="-kde -systemd -aqua -css -qt4 -a52 -cjk -clamav -ldap -motif \
     -coreaudio -ieee1394 -emacs -xemacs -emboss -altivec -berkdb \
     -smartcard -cups -nls -neon -quicktime -ibm png jpeg pulseaudio X xinerama"

#ABI_X86="32 64"
#VIDEO_CARDS="nvidia"
INPUT_DEVICES="libinput"
```

- **Mirrors**
  - `mirrorselect -i -o >> /mnt/gentoo/etc/portage/make.conf`
  - `mkdir --parents /mnt/gentoo/etc/portage/repos.conf`
  - `cp /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf
  - `sync-rsync-verify-manifest` - `set this to no in gentoo.conf  if sync failed`
  - `cp --dereference /etc/resolv.conf /mnt/gentoo/etc/

- **Mount**
  - `mount --types proc /proc /mnt/gentoo/proc`
  - `mount --rbind /sys /mnt/gentoo/sys`
  - `mount --rbind /dev /mnt/gentoo/dev`
  - `mount --make-rslave /mnt/gentoo/sys`
  - `mount --make-rslave /mnt/gentoo/dev`
  - `test -L /dev/shm && rm /dev/shm && mkdir /dev/shm`
  - `mount --types tmpfs --options nosuid,nodev,noexec shm /dev/shm`
  - `chmod 1777 /dev/shm`

- **Chroot**
  - `chroot /mnt/gentoo /bin/bash`
  - `source /etc/profile`
  - `export PS1="(chroot) ${PS1}"`
  - `emerge-webrsync`
  - `emerge --sync`

- **Portage**
  - `cd`_`/etc/portage`_
  - `mkdir package.accept_keywords`
  - `echo "app-editors/neovim nvimpager tui luajit" > package.use/neovim`
  - `emerge -av eix`
  - `emerge -uvDNa @world`
  - `emerge -av cpuid2cpuflags`
  - `cpuid2cpuflags >> /etc/portage/make.conf`

- **Timezone**
  - `echo "Asia/Manila" > /etc/timezone`
  - `emerge --config sys-libs/timezone-data`
  - `ln -sf /usr/share/zoneinfo/Asia/Manila /etc/localtime`
  - `nvim`_`/etc/locale.gen`_
  - uncomment or add:
```
en_PH.UTF-8 UTF-8
en_PH ISO-8859-1`
```
  - `locale-gen`
  - `eselect locale list`
  - `eselect locale set X` - `select en_PH.utf8`
  - `env-update && source /etc/profile && export PS1="(chroot) ${PS1}"`

- **Fstab**
  - `find UUID lsblk -f`
  - `configure fstab in nvim`_`/etc/fstab`_
```
UUID=xxxxxx-xxxx    /boot    vfat    rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,utf8,errors=remount-ro 0 2`
UUID=xxxxxx-xxxx    /    ext4    rw,relatime    0 1
```

- **Kernel**
  - `emerge --ask sys-kernel/gentoo-sources`
  - `emerge --ask sys-apps/pciutils`
  - `copy config kernel from my github repo portage`
  - `cp config /usr/src/linux/.config`
  - `cd /usr/src/linux`
  - `make olddefconfig`
  - `check some kernel config with` _`make menuconfig`_
  - `make -j8`
  - `make -j8 modules_install`
  - `make install`

- **Initramfs**
  - `emerge --ask sys-kernel/genkernel`
  - `emerge --ask --noreplace sys-firmware/intel-microcode sys-apps/iucode_tool`
  - `genkernel --microcode-initramfs --install initramfs`

- **Bootloader**
  - `emerge -av sys-boot/efibootmgr`
  - `mkdir -p /boot/efi/boot`
  - `cp /boot/vmlinuz-* /boot/efi/boot/bootx64.efi`
  - `cp /boot/initramfs-* /boot/efi/boot/initramfs-5.X.img`
```
efibootmgr -d /dev/sdX -p 1 -c -L "Gentoo" -l "\efi\boot\bootx64.efi" -u 'root=UUID=xxxxx-xxx rw initrd=\efi\boot\initramfs-5.X.img'
```

- **Root password**
  - `passwd`

- **Network configuration**
  - `hostname="art" in`_`nvim /etc/conf.d/hostname`_
  - `emerge --ask --noreplace net-misc/netifrc`
  - `config_enp0s31f6 in` _`/etc/conf.d/net`_
  - `cd /etc/init.d`
  - `ln -s net.lo net.enp0s31f6`
  - `rc-update add net.enp0s31f6 default`
  - `nvim /etc/hosts`
```
127.0.0.1  art.homenetwork art localhost
```

- **System and networking tools**
  - `emerge -av sysklogd cronie mlocate`
  - `rc-update add sysklogd default`
  - `rc-update add cronie default`
  - `emerge --ask net-misc/dhcpcd`

- **Rebooting system**
  - `exit`
  - `cd`
  - `umount -l /mnt/gentoo/dev{/shm,/pts,}`
  - `umount -R /mnt/gentoo`
  - `reboot`

- **Finalizing**
  - `login as root`
  - `useradd -m -G users,wheel,audio,video,usb,portage -s /bin/bash hoaxdream`
  - `passwd hoaxdream`
  - `rm stage3-*.tar.*`
  - `rm -rf portage-*`
  - `emerge -av sudo`
  - `EDITOR=nvim visudo`
  - `uncomment wheel group`
  ```
  %wheel ALL=(ALL) ALL
  ```
  - `logout root`
  - `login with created username and password`

- **Patching**
  - `mkdir -p /etc/portage/patches/x11-libs/libXft`
  - `cd /etc/portage/patches/x11-libs/libXft`
  - `place .diff file here`
  - `wget https://gitlab.freedesktop.org/mawww/libxft/-/commit/7808631e7a9a605d5fe7a1077129c658d9ec47fc.patch`
  - `emerge -a libXft`
