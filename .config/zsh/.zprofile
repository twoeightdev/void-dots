[ $(tty) = "/dev/tty1" ] && ! pgrep -x X >/dev/null && exec startx
