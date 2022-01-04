# Void Installation UEFI EFISTUB Guide

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
    - Mount the file system
- Installation
  - Set repository
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
    - EFISTUB
    - GRUB
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

<pre>
$ dd bs=4M if=path/to/voidlinux.iso of=/dev/sdx conv=fsync oflag=direct status=progress
</pre>

### Pre installation

- Set shell
<pre>
- $ bash
</pre>

- Change font
<pre>
$ setfont LatGrkCyr-12x22
</pre>

- Check boot mode
<pre>
- $ ls /sys/firmware/efi    # shows output if it's UEFI
</pre>

- Check internet connection
<pre>
- $ ping -c 3 voidlinux.org
</pre>

- Partitioning
**Mount point** | **Partition** | **Partition type** | **Suggested size**
| --- | --- | --- | --- |
| /mnt/boot | /dev/nvme0n1p1 | EFI system partition | 512 MiB |
| /mnt | /dev/nvme0n1p2 | Linux Filesystem | Remainder of the device |

```
- $ lsblk -f    # show all drives
  - Create partition
    - $ wipefs -af /dev/nvme0n1   <b>Wipe the drive</b>
    - $ fdisk /dev/nvme0n1        <b>Use fdisk to parition disk</b>
    - Type <b>g</b> to set GPT disklabel
```
