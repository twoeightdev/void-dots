[ $(tty) = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx
