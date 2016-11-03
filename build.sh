#!/bin/bash
function pause() {
	echo -e "\e[30m\e[45m\e[5mPress ENTER to continue...\e[97m\e[49m"
	read  
}


# echo "1. Checking dependencies..."
#sudo dnf install autoconf automake mingw32-filesystem cmake mingw32-gcc-c++ maven mingw32-boost gettext-devel bison flex mingw32-glib2 mingw32-orc mingw32-libtheora mingw32-libvorbis mingw32-opus mingw32-libsigc++20 mingw32-glibmm24 yasm mingw32-openssl mingw32-libtiff mingw32-libpng mingw32-OpenEXR mingw32-jasper libtool glib2-devel gtk-doc mingw32-atk mingw32-cairo mingw32-gtk3 mingw32-speex mingw32-wavpack mingw32-libsoup
#
#echo "2. Optional dependency..."
#sudo dnf install indent astyle

# echo "Preparing build root directory..."
# mkdir kms
# cd kms

echo "3.1 kms-cmake-utils"
git clone https://github.com/Kurento/kms-cmake-utils.git
mkdir kms-cmake-utils-build
cd kms-cmake-utils-build/
mingw32-cmake ../kms-cmake-utils/
mingw32-make
pause
sudo mingw32-make install
cd ..


echo "3.2 kurento-module-creator"
git clone https://github.com/ESTOS/kurento-module-creator.git
cd kurento-module-creator/
git checkout fedora
make
pause
sudo make install
cd ..


echo "3.3 gstreamer-1.5"
git clone https://github.com/Kurento/gstreamer.git
cd gstreamer/
./autogen.sh ## Ignore configuration errors
mingw32-configure --disable-tools --disable-tests --disable-benchmarks --disable-examples --disable-debug --libexec=/usr/i686-w64-mingw32/sys-root/mingw/libexec
make
pause
sudo make install
cd ..


echo "3.4 gst-plugins-base-1.5"
git clone https://github.com/Kurento/gst-plugins-base.git
cd gst-plugins-base/
./autogen.sh ## Ignore configuration errors
mingw32-configure --disable-debug
mingw32-make
pause
sudo mingw32-make install
cd ..

echo "3.5 jsoncpp"
git clone https://github.com/ESTOS/jsoncpp.git
mkdir jsoncpp-build
cd jsoncpp-build/
mingw32-cmake -DCMAKE_BUILD_TYPE=Release ../jsoncpp
mingw32-make
pause
sudo mingw32-make install
cd ..


echo "3.6 kms-jsonrpc"
git clone https://github.com/ESTOS/kms-jsonrpc.git -b wip/premerge
mkdir kms-jsonrpc-build
cd kms-jsonrpc-build/
mingw32-cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_MODULE_PATH=/usr/i686-w64-mingw32/sys-root/mingw/share/cmake-3.5/Modules/ ../kms-jsonrpc
pause
sudo mingw32-make install
cd ..


echo "3.7 libvpx"
git clone https://github.com/webmproject/libvpx.git
cd libvpx/
git checkout v1.5.0
eval `rpm --eval %{mingw32_env}`
export AS=yasm
./configure --target=x86-win32-gcc --prefix=/usr/i686-w64-mingw32/sys-root/mingw/
mingw32-make
pause
sudo mingw32-make install
cd ..


echo "3.8 kms-core"
echo "Wenn dieser Schritt komplett unter root ausgeführt wird, findet cmake den kurentocreator nicht ..."
git clone https://github.com/ESTOS/kms-core.git
mkdir kms-core-build
cd kms-core-build/
mingw32-cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_MODULE_PATH=/usr/i686-w64-mingw32/sys-root/mingw/share/cmake-3.5/Modules/ -DCMAKE_INSTALL_PREFIX=/usr/i686-w64-mingw32/sys-root/mingw -DKURENTO_MODULES_DIR=/usr/i686-w64-mingw32/sys-root/mingw/share/kurento/modules/ ../kms-core
mingw32-make
pause
sudo mingw32-make install
cd ..


echo "3.9 libevent"
git clone https://github.com/libevent/libevent.git
cd libevent/
./autogen.sh ## However, you should not build using configured Makefile
mingw32-configure
mingw32-make
pause
sudo mingw32-make install
cd ..


echo "3.10 kurento-media-server"
git clone https://github.com/ESTOS/kurento-media-server.git
mkdir kurento-media-server-build
cd kurento-media-server-build/
mingw32-cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_MODULE_PATH=/usr/i686-w64-mingw32/sys-root/mingw/share/cmake-3.5/Modules/ ../kurento-media-server
mingw32-make
pause
sudo mingw32-make install
cd ..


echo "3.11 usersctp"
git clone https://github.com/ESTOS/usrsctp.git -b wip/premerge
cd usrsctp/
./bootstrap
mingw32-configure
mingw32-make
pause
sudo mingw32-make install
cd ..


echo "3.12 openwebrtc-gst-plugins"
git clone https://github.com/ESTOS/openwebrtc-gst-plugins.git -b wip/premerge
cd openwebrtc-gst-plugins/
./autogen.sh ## Ignore configuration errors
mingw32-configure
mingw32-make
pause
sudo mingw32-make install
sudo ln -s /usr/i686-w64-mingw32/sys-root/mingw/lib/libgstsctp-1.5.dll /usr/i686-w64-mingw32/sys-root/mingw/bin/libgstsctp-1.5.dll 
cd ..


echo "3.13 libnice"
git clone https://github.com/ESTOS/libnice.git
cd libnice/
./autogen.sh ## Ignore configuration errors
mingw32-configure
mingw32-make
pause
sudo mingw32-make install
cd ..


echo "3.14 kms-elements"
git clone https://github.com/ESTOS/kms-elements.git
mkdir kms-elements-build
cd kms-elements-build/
mingw32-cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_MODULE_PATH=/usr/i686-w64-mingw32/sys-root/mingw/share/cmake-3.5/Modules/ -DCMAKE_INSTALL_PREFIX=/usr/i686-w64-mingw32/sys-root/mingw -DKURENTO_MODULES_DIR=/usr/i686-w64-mingw32/sys-root/mingw/share/kurento/modules/ ../kms-elements
mingw32-make
pause
sudo mingw32-make install
cd ..


echo "3.15 opencv"
git clone https://github.com/itseez/opencv.git
cd opencv/
git checkout 2.4.13.1
mkdir ../opencv-build
cd ../opencv-build/
mingw32-cmake \
  -DBUILD_PERF_TESTS=false \
  -DBUILD_TESTS=false \
  -DWITH_DSHOW=false \
  -DWITH_WIN32UI=false \
  -DWITH_OPENCL=false \
  -DWITH_VFW=false \
  -DBUILD_ZLIB=false \
  -DBUILD_TIFF=false \
  -DBUILD_JASPER=false \
  -DBUILD_JPEG=false \
  -DBUILD_PNG=false \
  -DBUILD_OPENEXR=false \
  -DWITH_FFMPEG=false \
  -DBUILD_opencv_flann=OFF \
  -DBUILD_opencv_photo=OFF \
  -DBUILD_opencv_video=OFF \
  -DBUILD_opencv_ml=OFF \
  ../opencv
sed -i 's/-isystem\ \/usr\/i686-w64-mingw32\/sys-root\/mingw\/include/ /g' \
  modules/core/CMakeFiles/opencv_core.dir/includes_CXX.rsp
sed -i 's/-isystem\ \/usr\/i686-w64-mingw32\/sys-root\/mingw\/include\ / /g' ./modules/highgui/CMakeFiles/opencv_highgui.dir/includes_CXX.rsp
mingw32-make
sudo mingw32-make install
sudo cp unix-install/opencv.pc /usr/i686-w64-mingw32/sys-root/mingw/lib/pkgconfig/
sudo ln -s /usr/i686-w64-mingw32/sys-root/mingw/x86/mingw/lib/libopencv_core2413.dll.a \
  /usr/i686-w64-mingw32/sys-root/mingw/lib/libopencv_core.a
sudo ln -s /usr/i686-w64-mingw32/sys-root/mingw/x86/mingw/lib/libopencv_highgui2413.dll.a \
  /usr/i686-w64-mingw32/sys-root/mingw/lib/libopencv_highgui.a
sudo ln -s /usr/i686-w64-mingw32/sys-root/mingw/x86/mingw/lib/libopencv_imgproc2413.dll.a \
  /usr/i686-w64-mingw32/sys-root/mingw/lib/libopencv_imgproc.a
sudo ln -s /usr/i686-w64-mingw32/sys-root/mingw/x86/mingw/lib/libopencv_objdetect2413.dll.a \
  /usr/i686-w64-mingw32/sys-root/mingw/lib/libopencv_objdetect.a
sudo ln -s /usr/i686-w64-mingw32/sys-root/mingw/x86/mingw/bin/libopencv_core2413.dll /usr/i686-w64-mingw32/sys-root/mingw/bin/libopencv_core2413.dll
sudo ln -s /usr/i686-w64-mingw32/sys-root/mingw/x86/mingw/bin/libopencv_highgui2413.dll /usr/i686-w64-mingw32/sys-root/mingw/bin/libopencv_highgui2413.dll
sudo ln -s /usr/i686-w64-mingw32/sys-root/mingw/x86/mingw/bin/libopencv_imgproc2413.dll /usr/i686-w64-mingw32/sys-root/mingw/bin/libopencv_imgproc2413.dll
sudo ln -s /usr/i686-w64-mingw32/sys-root/mingw/x86/mingw/bin/libopencv_objdetect2413.dll /usr/i686-w64-mingw32/sys-root/mingw/bin/libopencv_objdetect2413.dll
cd ..


echo "3.16 kms-filters"
git clone https://github.com/ESTOS/kms-filters.git
mkdir kms-filters-build
cd kms-filters-build/
mingw32-cmake -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_MODULE_PATH=/usr/i686-w64-mingw32/sys-root/mingw/share/cmake-3.5/Modules/ \
  -DCMAKE_INSTALL_PREFIX=/usr/i686-w64-mingw32/sys-root/mingw \
  -DKURENTO_MODULES_DIR=/usr/i686-w64-mingw32/sys-root/mingw/share/kurento/modules/ \
  -DCMAKE_C_FLAGS="-Wno-error=deprecated-declarations" \
  ../kms-filters
mingw32-make
pause
sudo mingw32-make install
cd ..


echo "3.17 gst-plugins-good"
git clone https://github.com/Kurento/gst-plugins-good.git
cd gst-plugins-good/
./autogen.sh
mingw32-configure \
  --disable-wavpack --disable-valgrind --disable-directsound \
  --disable-libcaca --disable-waveform \
  --libexec=/usr/i686-w64-mingw32/sys-root/mingw/libexec \
  --disable-debug --disable-gtk-doc --disable-examples
printf "all:\ninstall:\nclean:\nuninstall:\n" > tests/Makefile
mingw32-make
pause
sudo mingw32-make install
cd ..

echo "3.18 libsrtp"
git clone https://github.com/cisco/libsrtp.git
cd libsrtp/
git checkout v1.5.4
mingw32-configure
mingw32-make
pause
sudo mingw32-make install
cd ..

echo "3.18 gst-plugins-bad"
git clone https://github.com/Kurento/gst-plugins-bad.git
cd gst-plugins-bad/
./autogen.sh
mingw32-configure \
  --disable-directsound --disable-direct3d --disable-debug \
  --disable-examples --disable-gtk-doc --disable-winscreencap \
  --disable-winks --disable-wasapi --disable-opencv
sed -i 's/\buint\b/unsigned/g' ext/opencv/gstmotioncells.cpp ## We may need this later
printf "all:\ninstall:\nclean:\nuninstall:\n" > tests/Makefile
mingw32-make
pause
sudo mingw32-make install

cd ..

echo "BUILD DONE."
