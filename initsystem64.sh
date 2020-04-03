#!/bin/bash
function pause() {
       echo -e "\e[30m\e[45m\e[5mPress ENTER to continue...\e[97m\e[49m"
       read  
}


echo "1. Checking dependencies..."
sudo dnf install autoconf automake mingw64-filesystem cmake mingw64-gcc-c++ maven mingw64-boost gettext-devel bison flex mingw64-glib2 mingw64-orc mingw64-libtheora mingw64-libvorbis mingw64-opus mingw64-libsigc++20 mingw64-glibmm24 yasm mingw64-openssl mingw64-libtiff mingw64-libpng mingw64-OpenEXR mingw64-jasper libtool glib2-devel gtk-doc mingw64-atk mingw64-cairo mingw64-gtk3 mingw64-speex mingw64-wavpack mingw64-libsoup mingw64-gnutls mingw64-libidn2
sudo dnf install openssl-devel gnutls-devel mingw64-libtasn1

echo "2. Optional dependency..."
sudo dnf install indent astyle

echo -e "\e[30m\e[45m\e[5mPress ENTER to restart the computer! (or CTRL-C to stop here)\e[97m\e[49m"
read  

sudo shutdown -r now
