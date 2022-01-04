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

```
$ dd bs=4M if=path/to/voidlinux.iso of=/dev/sdx conv=fsync oflag=direct status=progress
```

### Pre installation

- Set shell
```
- $ bash
```

- Change font
```
$ setfont LatGrkCyr-12x22
```

- Check boot mode
```
- $ ls /sys/firmware/efi    # shows output if it's UEFI
```

- Check internet connection
```
- $ ping -c 3 voidlinux.org
```

- Partitioning
```
- $ lsblk -f    # show all drives
  - Create partition
    - $ wipefs -af /dev/nvme0n1   # Wipe the drive
    - $ fdisk /dev/nvme0n1        # Use fdisk to parition disk
    - Type **g** to set GPT disklabel
```
