#! /bin/sh

#20230718-msys2-base-x86_64
#extract 20230718-msys2-base-x86_64.tar.xz to 20230718-msys2-base-x86_64
#- 20230718-msys2-base-x86_64\msys64\msys2_shell.cmd
#pacman -Syuu
#- in mingw64.exe :

pacman -Syuu
pacman -S git
pacman -S mingw-w64-x86_64-meson
pacman -S mingw-w64-x86_64-gcc
pacman -S mingw-w64-x86_64-cmake
pacman -S diffutils
pacman -S patch

#for kurento
pacman -S mingw-w64-x86_64-boost
pacman -S mingw-w64-x86_64-libsigc++
# -> problem - conflict with glib from gstreamer Installation -> should be installed bevore Gstreamer Installation
pacman -S mingw-w64-x86_64-glibmm
# uuid add /usr/lib/pkgconfig
pacman -S libutil-linux-devel
pacman -S mingw-w64-x86_64-libvpx
pacman -S mingw-w64-x86_64-libevent
pacman -S make
pacman -S mingw-w64-x86_64-gdb


cd /x/dev/estos-kurento-scripts

if [ ! -d kurentoall ]; then
	mkdir kurentoall
fi
cd kurentoall

