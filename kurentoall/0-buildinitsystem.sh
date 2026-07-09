#! /bin/sh -x

###### STEPS to prepare msys64 buildenvironment #####
###### out of the cold:
# get base from https://repo.msys2.org/distrib/x86_64/ or latest from tools repository x:\dev\tools\mingw\
#extract msys2-base-x86_64-20260322.tar.xz/msys64 to x:/dev/tools/mingw/msys64
#open msys64\msys2_shell.cmd
#'./.bashrc' -> '/home/user/.bashrc'
#'./.bash_logout' -> '/home/user/.bash_logout'
#'./.bash_profile' -> '/home/user/.bash_profile'
#'./.profile' -> '/home/user/.profile'
#'C:\WINDOWS\system32\drivers\etc\hosts' -> '/etc/hosts'
#'C:\WINDOWS\system32\drivers\etc\protocol' -> '/etc/protocols'
#'C:\WINDOWS\system32\drivers\etc\services' -> '/etc/services'
#'C:\WINDOWS\system32\drivers\etc\networks' -> '/etc/networks'
#call pacman -Syuu
#close the shell
#open msys64\msys2_shell.cmd again
#call pacman -Syuu again
###### now it has all basic tools updated
#call /x/dev/estos-kurento-scripts/kurentoall/0-buildinitsystem.sh to install the basic tools for Kurento
#pack msys64.zip -> remove all paths in /home and empty /etc/hosts
###### with existing prepared msys64.zip from the tools repository x:\dev\tools\mingw\
#"C:\Program Files\7-Zip\7z.exe" x -y msys64.zip -> extract in x:/dev/tools/mingw
#call pacman -Syuu
######
#in './.bashrc' -> '/home/user/.bashrc' add cd /x/dev/estos-kurento-scripts/kurentoall
###### END of prepare msys64 buildenvironment #####

###### prepare initial build environment for Kurento
#open msys64\mingw64.exe :
#call /x/dev/estos-kurento-scripts/kurentoall/0-buildinitsystem.sh

pacman -Syuu --noconfirm
pacman -S --noconfirm git
pacman -S --noconfirm mingw-w64-x86_64-meson
pacman -S --noconfirm mingw-w64-x86_64-gcc
pacman -S --noconfirm mingw-w64-x86_64-cmake
# pacman -S --noconfirm mingw-w64-x86_64-indent
# pacman -S --noconfirm mingw-w64-x86_64-astyle -> braucht astyle 2.06
pacman -S --noconfirm diffutils
pacman -S --noconfirm patch
pacman -S --noconfirm unzip
pacman -S --noconfirm zip

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
pacman -S --noconfirm mingw-w64-x86_64-libsoup3

#cd /x/dev/estos-kurento-scripts/kurentoall

# maven and jdk are installed in 1-buildmain.sh in build_tools()
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

#pacman usage:
#pacman -Ss git -> suchen
#pacman -Q mingw-w64-x86_64-boost mingw-w64-x86_64-boost-libs -> Status
#pacman -R mingw-w64-x86_64-astyle

#kurento commit in msys64:
#- install astyle 2.06 from cygwin
#- PATH="/x/tools/cygwin64/bin:${PATH}"

