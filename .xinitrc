#!/bin/sh

# starts 1 random rc file (login script? seems like it but i dunno -- not really necessary tho)

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# change resolution to a usable mode
xrandr --output eDP-1 --mode 1920x1200

# make vim keyboard layout :)
setxkbmap -option caps:escape

# Options:
# qtile, kde, soon others too!...
session="qtile"

if [ "$session" == "qtile" ] ; then
    # set wallpaper
    xwallpaper --screen 0 --output eDP-1 --zoom ~/.config/backgrounds/heartNebula.jpg

    # set custom keybinds
    xbindkeys

    # start qtile!
    qtile start

elif [ "$session" == "kde" ] ; then

    # for KDE Plasma use below 
    export DESKTOP_SESSION=plasma
    exec startplasma-x11

elif [ "$session" == "cinnamon" ] ; then

    # for Cinnamon desktop (Linux mint) use below 
    exec cinnamon-session

elif [ "$session" == "gnome" ] ; then

    # for GNOME desktop use below 
    export XDG_SESSION_TYPE=x11
    export GDK_BACKEND=x11
    exec gnome-session
fi



