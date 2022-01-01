### Silent Boot
- Watchdog
```
  - $ nvim /etc/modprobe.d/watchdog.conf
blacklist iTCO_wdt
blacklist iTCO_vendor_support
```
- Nvidia
```
  - $ mkdir -vp /etc/pacman.d/hooks
  - $ nvim /etc/pacman.d/hooks/nvidia.hook
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia
Target=linux

[Action]
Description=Update Nvidia module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case $trg in linux) exit 0; esac; done; /usr/bin/mkinitcpio -P'

  - $
