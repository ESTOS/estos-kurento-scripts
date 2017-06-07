#!/bin/bash
function pause() {
	echo -e "\e[30m\e[45m\e[5mPress ENTER to continue...\e[97m\e[49m"
	read  
}

# if [ -d /usr/i686-w64-mingw32/sys-root/mingw/share/cmake-3.5 ]; then echo "hallo"; fi;
cmakemodules=/usr/i686-w64-mingw32/sys-root/mingw/share/cmake-3.5/Modules/
if [ -d /usr/i686-w64-mingw32/sys-root/mingw/share/cmake-3.6 ]; then
	cmakemodules=/usr/i686-w64-mingw32/sys-root/mingw/share/cmake-3.6/Modules/
fi

echo "cmake module path: " $cmakemodules

echo "3.1 kms-cmake-utils"
cd kms-cmake-utils
git pull
cd ..

#mkdir kms-cmake-utils-build
#cd kms-cmake-utils-build/
#mingw32-cmake ../kms-cmake-utils/
#mingw32-make
#pause
#sudo mingw32-make install
#cd ..


echo "3.2 kurento-module-creator"
cd kurento-module-creator/
git pull
#make
#pause
#sudo make install
cd ..


echo "3.3 gstreamer-1.7.x/1.8.1 (Fork of github/kurento/gstreamer 06.06.2017"
cd gstreamer/
git pull
#./autogen.sh ## Ignore configuration errors
#mingw32-configure --disable-tools --disable-tests --disable-benchmarks --disable-examples --disable-debug --libexec=/usr/i686-w64-mingw32/sys-root/mingw/libexec
#make
#pause
#sudo make install
cd ..


echo "3.4 gst-plugins-base-1.5"
cd gst-plugins-base/
git pull
#./autogen.sh ## Ignore configuration errors
#mingw32-configure --disable-debug
#mingw32-make
#pause
#sudo mingw32-make install
cd ..

echo "3.5 jsoncpp"
cd jsoncpp
git pull
cd ..
#mkdir jsoncpp-build
#cd jsoncpp-build/
#mingw32-cmake -DCMAKE_BUILD_TYPE=Release ../jsoncpp
#mingw32-make
#pause
#sudo mingw32-make install
#cd ..


echo "3.6 kms-jsonrpc"
cd kms-jsonrpc
git pull
cd ..
#mkdir kms-jsonrpc-build
#cd kms-jsonrpc-build/
#mingw32-cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_MODULE_PATH=$cmakemodules ../kms-jsonrpc
#pause
#sudo mingw32-make install
#cd ..


echo "3.7 libvpx"
cd libvpx/
git pull https://github.com/webmproject/libvpx.git v1.5.0
#eval `rpm --eval %{mingw32_env}`
#export AS=yasm
#./configure --target=x86-win32-gcc --prefix=/usr/i686-w64-mingw32/sys-root/mingw/
#mingw32-make
#pause
#sudo mingw32-make install
cd ..


echo "3.8 kms-core"
# if this is executed using root, cmake will not find the kurentocreator
if [[ $EUID == 0 ]]; then
	echo "Build this step as root will lead to troubles later! (e.g. kurentocreator will not be found) Stop here now."
	exit
fi
cd kms-core
git pull
cd ..

#mkdir kms-core-build
#cd kms-core-build/
#mingw32-cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_MODULE_PATH=$cmakemodules -DCMAKE_INSTALL_PREFIX=/usr/i686-w64-mingw32/sys-root/mingw -DKURENTO_MODULES_DIR=/usr/i686-w64-mingw32/sys-root/mingw/share/kurento/modules/ ../kms-core
#mingw32-make
#pause
#sudo mingw32-make install
#cd ..


echo "3.9 libevent"
cd libevent/
git pull
#./autogen.sh ## However, you should not build using configured Makefile
#mingw32-configure
#mingw32-make
#pause
#sudo mingw32-make install
cd ..


echo "3.10 kurento-media-server"
cd kurento-media-server
git pull
cd ..

#mkdir kurento-media-server-build
#cd kurento-media-server-build/
#mingw32-cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_MODULE_PATH=$cmakemodules ../kurento-media-server
#mingw32-make
#pause
#sudo mingw32-make install
#cd ..


echo "3.11 usersctp"
cd usrsctp/
git pull
#./bootstrap
#mingw32-configure
#mingw32-make
#pause
#sudo mingw32-make install
cd ..


echo "3.12 openwebrtc-gst-plugins"
cd openwebrtc-gst-plugins/
git pull
#./autogen.sh ## Ignore configuration errors
#mingw32-configure
#mingw32-make
#pause
#sudo mingw32-make install
#sudo ln -s /usr/i686-w64-mingw32/sys-root/mingw/lib/libgstsctp-1.5.dll /usr/i686-w64-mingw32/sys-root/mingw/bin/libgstsctp-1.5.dll 
cd ..


echo "3.13 libnice"
cd libnice/
git pull
#./autogen.sh ## Ignore configuration errors
#mingw32-configure
#mingw32-make
#pause
#sudo mingw32-make install
cd ..


echo "3.14 kms-elements"
cd kms-elements
git pull
cd ..

#mkdir kms-elements-build
#cd kms-elements-build/
#mingw32-cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_MODULE_PATH=$cmakemodules -DCMAKE_INSTALL_PREFIX=/usr/i686-w64-mingw32/sys-root/mingw -DKURENTO_MODULES_DIR=/usr/i686-w64-mingw32/sys-root/mingw/share/kurento/modules/ ../kms-elements
#mingw32-make
#pause
#sudo mingw32-make install
#cd ..


echo "3.16 kms-filters"
cd kms-filters
git pull
cd ..

#mkdir kms-filters-build
#cd kms-filters-build/
#mingw32-cmake -DCMAKE_BUILD_TYPE=Release \
#  -DCMAKE_MODULE_PATH=$cmakemodules \
#  -DCMAKE_INSTALL_PREFIX=/usr/i686-w64-mingw32/sys-root/mingw \
#  -DKURENTO_MODULES_DIR=/usr/i686-w64-mingw32/sys-root/mingw/share/kurento/modules/ \
#  -DCMAKE_C_FLAGS="-Wno-error=deprecated-declarations" \
#  ../kms-filters
#mingw32-make
#pause
#sudo mingw32-make install
#cd ..


echo "3.17 gst-plugins-good"
cd gst-plugins-good/
git pull
#./autogen.sh
#mingw32-configure \
#  --disable-wavpack --disable-valgrind --disable-directsound \
#  --disable-libcaca --disable-waveform \
#  --libexec=/usr/i686-w64-mingw32/sys-root/mingw/libexec \
#  --disable-debug --disable-gtk-doc --disable-examples
#printf "all:\ninstall:\nclean:\nuninstall:\n" > tests/Makefile
#mingw32-make
#pause
#sudo mingw32-make install
cd ..

echo "3.18 libsrtp"
cd libsrtp/
git pull https://github.com/cisco/libsrtp.git v1.5.4
#mingw32-configure
#mingw32-make
#pause
#sudo mingw32-make install
cd ..

echo "UPDATE DONE."
