#!/bin/bash
function pause() {
       echo -e "\e[30m\e[45m\e[5mPress ENTER to continue...\e[97m\e[49m"
       read  
}


echo "1. Checking dependencies..."
sudo dnf install autoconf automake mingw32-filesystem cmake mingw32-gcc-c++ maven mingw32-boost gettext-devel bison flex mingw32-glib2 mingw32-orc mingw32-libtheora mingw32-libvorbis mingw32-opus mingw32-libsigc++20 mingw32-glibmm24 yasm mingw32-openssl mingw32-libtiff mingw32-libpng mingw32-OpenEXR mingw32-jasper libtool glib2-devel gtk-doc mingw32-atk mingw32-cairo mingw32-gtk3 mingw32-speex mingw32-wavpack mingw32-libsoup

echo "2. Optional dependency..."
sudo dnf install indent astyle

echo -e "\e[30m\e[45m\e[5mPress ENTER to restart the computer! (or CTRL-C to stop here)\e[97m\e[49m"
read  

sudo shutdown -r now
