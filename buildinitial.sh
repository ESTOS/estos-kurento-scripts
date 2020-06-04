#!/bin/bash
source common.sh


echo "3.1 kms-cmake-utils"
git clone https://github.com/ESTOS/kms-cmake-utils.git -b 1.3.2

mkdir kms-cmake-utils-build
cd kms-cmake-utils-build/
mingw32-cmake ../kms-cmake-utils/
mingw32-make
pause
sudo mingw32-make install

cd ..
pwd
# getcmakemodules needs 'cd kms-cmake-utils'
getcmakemodules
#if false; then
pwd
pause 


echo "3.2 kurento-module-creator"
git clone https://github.com/ESTOS/kurento-module-creator.git -b estos6.1
cd kurento-module-creator/
#git checkout fedora
make
pause
sudo make install
cd ..

#if false; then

echo "3.3 gstreamer-1.7.x/1.8.1 (Fork of github/kurento/gstreamer 06.06.2017"
git clone https://github.com/ESTOS/gstreamer.git -b kms6.6.0
cd gstreamer/
./autogen.sh ## Ignore configuration errors
mingw32-configure --disable-tools --disable-tests --disable-benchmarks --disable-examples --disable-debug --libexec=/usr/i686-w64-mingw32/sys-root/mingw/libexec
make
pause
sudo make install
cd ..


echo "3.4 gst-plugins-base-1.5"
git clone https://github.com/ESTOS/gst-plugins-base.git -b kms6.6.0
cd gst-plugins-base/
./autogen.sh ## Ignore configuration errors
mingw32-configure --disable-debug
mingw32-make
pause
sudo mingw32-make install
cd ..

echo "3.5 jsoncpp"
git clone https://github.com/ESTOS/jsoncpp.git -b estos6.1
mkdir jsoncpp-build
cd jsoncpp-build/
mingw32-cmake -DCMAKE_BUILD_TYPE=Release ../jsoncpp
mingw32-make
pause
sudo mingw32-make install
cd ..

#fi

echo "3.6 kms-jsonrpc"
git clone https://github.com/ESTOS/kms-jsonrpc.git -b estos6.1
mkdir kms-jsonrpc-build
cd kms-jsonrpc-build/
mingw32-cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_MODULE_PATH=$cmakemodules ../kms-jsonrpc
pause
sudo mingw32-make install
cd ..

#if false; then

echo "3.7 libvpx"
git clone https://github.com/ESTOS/libvpx.git
cd libvpx/
git checkout v1.5.0
eval `rpm --eval %{mingw32_env}`
export AS=yasm
./configure --target=x86-win32-gcc --prefix=/usr/i686-w64-mingw32/sys-root/mingw/
mingw32-make
pause
sudo mingw32-make install
cd ..

#fi

echo "3.8 kms-core"
# if this is executed using root, cmake will not find the kurentocreator
if [[ $EUID == 0 ]]; then
	echo "Build this step as root will lead to troubles later! (e.g. kurentocreator will not be found) Stop here now."
	exit
fi
git clone https://github.com/ESTOS/kms-core.git -b initial
cd kms-core
git checkout b832954e8654f97d59f1e1a0c5d5ffea38cb1017 -b 6.6.2017
cd ..
mkdir kms-core-build
cd kms-core-build/
mingw32-cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_MODULE_PATH=$cmakemodules -DCMAKE_INSTALL_PREFIX=/usr/i686-w64-mingw32/sys-root/mingw -DKURENTO_MODULES_DIR=/usr/i686-w64-mingw32/sys-root/mingw/share/kurento/modules/ ../kms-core
mingw32-make
pause
sudo mingw32-make install
cd ..

#if false; then

echo "3.9 libevent"
git clone https://github.com/ESTOS/libevent.git -b estos6.1
cd libevent/
git checkout a73fb2f443ebf9687ee6ca81a6401d1f3751683f
./autogen.sh ## However, you should not build using configured Makefile
mingw32-configure
mingw32-make
pause
sudo mingw32-make install
cd ..

echo "3.10 kurento-media-server"
git clone https://github.com/ESTOS/kurento-media-server.git -b estos6.1
mkdir kurento-media-server-build
cd kurento-media-server-build/
mingw32-cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_MODULE_PATH=$cmakemodules ../kurento-media-server
mingw32-make
pause
sudo mingw32-make install
cd ..


echo "3.11 usersctp"
git clone https://github.com/ESTOS/usrsctp.git -b estos6.1
cd usrsctp/
./bootstrap
mingw32-configure
mingw32-make
pause
sudo mingw32-make install
cd ..


echo "3.12 openwebrtc-gst-plugins"
git clone https://github.com/ESTOS/openwebrtc-gst-plugins.git -b estos6.1
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
git checkout 75ed7e4d12032cab8f5b6e550e641d728a61136a -b initial
./autogen.sh ## Ignore configuration errors
mingw32-configure --enable-compile-warnings=yes
mingw32-make
pause
sudo mingw32-make install
cd ..

#fi

echo "3.14 kms-elements"
git clone https://github.com/ESTOS/kms-elements.git -b initial
cd kms-elements
git checkout 7ba0209a57f549b771a8000ee46d0d7367345c23 -b 6.6.2017
cd ..
mkdir kms-elements-build
cd kms-elements-build/
mingw32-cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_MODULE_PATH=$cmakemodules -DCMAKE_INSTALL_PREFIX=/usr/i686-w64-mingw32/sys-root/mingw -DKURENTO_MODULES_DIR=/usr/i686-w64-mingw32/sys-root/mingw/share/kurento/modules/ ../kms-elements
mingw32-make
pause
sudo mingw32-make install
cd ..

#if false; then

echo "3.15 opencv"		
git clone https://github.com/ESTOS/opencv.git
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

#fi

echo "3.16 kms-filters"
git clone https://github.com/ESTOS/kms-filters.git -b estos6.1
mkdir kms-filters-build
cd kms-filters-build/
mingw32-cmake -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_MODULE_PATH=$cmakemodules \
  -DCMAKE_INSTALL_PREFIX=/usr/i686-w64-mingw32/sys-root/mingw \
  -DKURENTO_MODULES_DIR=/usr/i686-w64-mingw32/sys-root/mingw/share/kurento/modules/ \
  -DCMAKE_C_FLAGS="-Wno-error=deprecated-declarations" \
  ../kms-filters
mingw32-make
pause
sudo mingw32-make install
cd ..
#fi
#if false; then

echo "3.17 gst-plugins-good"
git clone https://github.com/ESTOS/gst-plugins-good.git -b kms6.6.0
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
git clone https://github.com/ESTOS/libsrtp.git
cd libsrtp/
git checkout v1.5.4
mingw32-configure
mingw32-make
pause
sudo mingw32-make install
cd ..

echo "3.19 gst-plugins-bad"
git clone https://github.com/ESTOS/gst-plugins-bad.git -b estos6.1
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


echo "3.20 gst-libav"
git clone https://github.com/ESTOS/gst-libav.git
cd gst-libav/
git checkout 493eee49c7171e7fc0bf0110e30d445ba573dc5e
./autogen.sh || true
mingw32-configure
mingw32-make
pause
sudo mingw32-make install

cd ..

echo "3.21 gst-plugins-ugly"
git clone https://github.com/ESTOS/gst-plugins-ugly.git
cd gst-plugins-ugly/
git checkout 2685b0f252bf0ed6aa27a5c69e82e05289346ff1
./autogen.sh || true
mingw32-configure \
  --libexec=/usr/i686-w64-mingw32/sys-root/mingw/libexec \
  --disable-debug --disable-gtk-doc --disable-examples
mingw32-make
pause
sudo mingw32-make install

cd ..

#fi

echo "BUILD DONE."
