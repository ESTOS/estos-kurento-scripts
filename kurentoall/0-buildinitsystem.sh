#! /bin/sh -x

#extract msys2-base-x86_64-20230718.tar.xz/msys64 to x:/dev/tools/mingw/msys64
#- msys64\msys2_shell.cmd
#'./.bashrc' -> '/home/user/.bashrc'
#'./.bash_logout' -> '/home/user/.bash_logout'
#'./.bash_profile' -> '/home/user/.bash_profile'
#'./.profile' -> '/home/user/.profile'
#'C:\WINDOWS\system32\drivers\etc\hosts' -> '/etc/hosts'
#'C:\WINDOWS\system32\drivers\etc\protocol' -> '/etc/protocols'
#'C:\WINDOWS\system32\drivers\etc\services' -> '/etc/services'
#'C:\WINDOWS\system32\drivers\etc\networks' -> '/etc/networks'
#pacman -Syuu
#to pack msys64.zip remove all paths in /home and empty /etc/hosts
#"C:\Program Files\7-Zip\7z.exe" x -y msys64.zip -> extract in x:/dev/tools/mingw

#- in msys64\mingw64.exe :
#/x/dev/estos-kurento-scripts/kurentoall/0-buildinitsystem.sh

pacman -Syuu --noconfirm
pacman -S --noconfirm git
pacman -S --noconfirm mingw-w64-x86_64-meson
pacman -S --noconfirm mingw-w64-x86_64-gcc
pacman -S --noconfirm mingw-w64-x86_64-cmake
pacman -S --noconfirm diffutils
pacman -S --noconfirm patch
pacman -S --noconfirm unzip

#for gstreamer -> pango installs harfbuzz and cairo
pacman -S --noconfirm mingw-w64-x86_64-pango

#for kurento
pacman -S --noconfirm mingw-w64-x86_64-boost
pacman -S --noconfirm mingw-w64-x86_64-libsigc++
# -> problem - conflict with glib from gstreamer Installation -> should be installed bevore Gstreamer Installation
pacman -S --noconfirm mingw-w64-x86_64-glibmm
# uuid add /usr/lib/pkgconfig
pacman -S --noconfirm libutil-linux-devel
pacman -S --noconfirm mingw-w64-x86_64-libvpx
pacman -S --noconfirm mingw-w64-x86_64-libevent
pacman -S --noconfirm make
pacman -S --noconfirm mingw-w64-x86_64-gdb
pacman -S --noconfirm mingw-w64-x86_64-libsoup

#cd /c/lwx/dev/estos-kurento-scripts/kurentoall
cd /x/dev/estos-kurento-scripts/kurentoall

#if [ ! -d kurentoall ]; then
#	mkdir kurentoall
#fi
#cd /x/dev/estos-kurento-scripts/kurentoall
#extract apache-maven-3.9.3-bin.zip/apache-maven-3.9.3 to /x/dev/estos-kurento-scripts/maven (maven\bin;naven\lib;...)
#unzip /x/dev/tools/mingw/tools/apache-maven-3.9.3-bin.zip
#mv apache-maven-3.9.3 maven
#Install https://adoptium.net/de/temurin/releases -> Windows x64 JDK 11-LTS zip
#unzip /x/dev/tools/mingw/tools/OpenJDK11U-jdk_x64_windows_hotspot_11.0.20.1_1.zip
#mv jdk-11.0.20.1+1 jdk-11
#./1-buildmain.sh help
#./1-buildmain.sh setup
#./1-buildmain.sh buildlog



