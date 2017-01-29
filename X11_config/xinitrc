#!/bin/sh
#
# ~/xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
   for f in /etc/X11/xinit/xinitrc.d/*; do
     [ -x "$f" ] && . "$f"
   done
   unset f
fi

# exec gnome-session
# exec startkde
# exec startxfce4
# ... or the Window Manager of your choice


# xrandr --output LVDS-1-0 --mode 1366x768  --output VGA-0 --mode 1024x768 --dpi 96

 xrandr --setprovideroutputsource modesetting NVIDIA-0 
 xrandr --auto --dpi 96

if [ -f $HOME/.Xresources ]; then
   xrdb $HOME/.Xresources
fi
setxkbmap latam
bin/walls &
xcompmgr &

# Here Xfce is kept as default
session=${1:-xmonad}

case $session in
    awesome           ) exec awesome;;
    bspwm             ) exec bspwm;;
    catwm             ) exec catwm;;
    cinnamon          ) exec cinnamon-session;;
    dwm               ) exec dwm;;
    enlightenment     ) exec enlightenment_start;;
    ede               ) exec startede;;
    fluxbox           ) exec startfluxbox;;
    gnome             ) exec gnome-session;;
    gnome-classic     ) exec gnome-session --session=gnome-classic;;
    i3|i3wm           ) exec i3;;
    icewm             ) exec icewm-session;;
    jwm               ) exec jwm;;
    kde               ) exec startkde;;
    mate              ) exec mate-session;;
    monster|monsterwm ) exec monsterwm;;
    notion            ) exec notion;;
    openbox           ) exec openbox-session;;
    unity             ) exec unity;;
    xfce|xfce4        ) exec startxfce4;;
    xmonad            ) exec xmonad;;
    # No known session, try to run it as command
    *) exec $1;;
esac

