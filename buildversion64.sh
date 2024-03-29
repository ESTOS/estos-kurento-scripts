#!/bin/bash
source common.sh

#here we can set what versions we want to clone
sh ./$1
#sh ./buildclone-estos6.3.sh

echo "3.1 kms-cmake-utils"

mkdir kms-cmake-utils-build
cd kms-cmake-utils-build/
mingw64-cmake ../kms-cmake-utils/
mingw64-make
pause
sudo mingw64-make install

cd ..
# getcmakemodules needs 'cd kms-cmake-utils'
getcmakemodules

pwd
pause 

echo "3.20 glib"
cd glib/
./autogen.sh
mingw64-configure \
  --disable-directsound --disable-direct3d \
  --disable-examples --disable-gtk-doc --disable-winscreencap \
  --disable-winks --disable-wasapi --disable-opencv
mingw64-make
pause
sudo mingw64-make install

cd ..

echo "3.2 kurento-module-creator"
cd kurento-module-creator/
make
pause
sudo make install
cd ..


echo "3.3 gstreamer-1.7.x/1.8.1 (Fork of github/kurento/gstreamer 06.06.2017"
cd gstreamer/
./autogen.sh ## Ignore configuration errors
mingw64-configure --disable-tools --disable-tests --disable-benchmarks --disable-examples --disable-debug --libexec=/usr/x86_64-w64-mingw32/sys-root/mingw/libexec
make
pause
sudo make install
cd ..


echo "3.4 gst-plugins-base-1.5"
cd gst-plugins-base/
./autogen.sh ## Ignore configuration errors
mingw64-configure --disable-debug
mingw64-make
pause
sudo mingw64-make install
cd ..

echo "3.5 jsoncpp"
mkdir jsoncpp-build
cd jsoncpp-build/
mingw64-cmake -DCMAKE_BUILD_TYPE=Release ../jsoncpp
mingw64-make
pause
sudo mingw64-make install
cd ..


echo "3.6 kms-jsonrpc"
mkdir kms-jsonrpc-build
cd kms-jsonrpc-build/
mingw64-cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_MODULE_PATH=$cmakemodules ../kms-jsonrpc
pause
sudo mingw64-make install
cd ..


echo "3.7 libvpx"
cd libvpx/
eval `rpm --eval %{mingw64_env}`
export AS=yasm
./configure --target=x86_64-win64-gcc --prefix=/usr/x86_64-w64-mingw32/sys-root/mingw/
mingw64-make
pause
sudo mingw64-make install
cd ..


echo "3.8 kms-core"
# if this is executed using root, cmake will not find the kurentocreator
if [[ $EUID == 0 ]]; then
	echo "Build this step as root will lead to troubles later! (e.g. kurentocreator will not be found) Stop here now."
	exit
fi
mkdir kms-core-build
cd kms-core-build/
mingw64-cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_MODULE_PATH=$cmakemodules -DCMAKE_INSTALL_PREFIX=/usr/x86_64-w64-mingw32/sys-root/mingw -DKURENTO_MODULES_DIR=/usr/x86_64-w64-mingw32/sys-root/mingw/share/kurento/modules/ ../kms-core
mingw64-make
pause
sudo mingw64-make install
cd ..


echo "3.9 libevent"
cd libevent/
./autogen.sh ## However, you should not build using configured Makefile
mingw64-configure
mingw64-make
pause
sudo mingw64-make install
cd ..


echo "3.10 kurento-media-server"
mkdir kurento-media-server-build
cd kurento-media-server-build/
mingw64-cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_MODULE_PATH=$cmakemodules ../kurento-media-server
mingw64-make
pause
sudo mingw64-make install
cd ..


echo "3.11 usersctp"
cd usrsctp/
./bootstrap
mingw64-configure
mingw64-make
pause
sudo mingw64-make install
cd ..


echo "3.12 openwebrtc-gst-plugins"
cd openwebrtc-gst-plugins/
./autogen.sh ## Ignore configuration errors
mingw64-configure
mingw64-make
pause
sudo mingw64-make install
sudo rm /usr/x86_64-w64-mingw32/sys-root/mingw/bin/libgstsctp-1.5.dll
sudo ln -s /usr/x86_64-w64-mingw32/sys-root/mingw/lib/libgstsctp-1.5.dll /usr/x86_64-w64-mingw32/sys-root/mingw/bin/libgstsctp-1.5.dll 
cd ..


echo "3.13 libnice"
cd libnice/
./autogen.sh ## Ignore configuration errors
mingw64-configure
mingw64-make
pause
sudo mingw64-make install
cd ..


echo "3.14 kms-elements"
mkdir kms-elements-build
cd kms-elements-build/
mingw64-cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_MODULE_PATH=$cmakemodules -DCMAKE_INSTALL_PREFIX=/usr/x86_64-w64-mingw32/sys-root/mingw -DKURENTO_MODULES_DIR=/usr/x86_64-w64-mingw32/sys-root/mingw/share/kurento/modules/ ../kms-elements
mingw64-make
pause
sudo mingw64-make install
cd ..

echo "3.15 opencv"
cd opencv
mkdir ../opencv-build
cd ../opencv-build
mingw64-cmake \
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
sed -i 's/-isystem\ \/usr\/x86_64-w64-mingw32\/sys-root\/mingw\/include/ /g' \
  modules/core/CMakeFiles/opencv_core.dir/includes_CXX.rsp
sed -i 's/-isystem\ \/usr\/x86_64-w64-mingw32\/sys-root\/mingw\/include\ / /g' ./modules/highgui/CMakeFiles/opencv_highgui.dir/includes_CXX.rsp
mingw64-make
sudo mingw64-make install
sudo cp unix-install/opencv.pc /usr/x86_64-w64-mingw32/sys-root/mingw/lib/pkgconfig/
sudo rm /usr/x86_64-w64-mingw32/sys-root/mingw/lib/libopencv_core.a
sudo ln -s /usr/x86_64-w64-mingw32/sys-root/mingw/x64/mingw/lib/libopencv_core2413.dll.a \
  /usr/x86_64-w64-mingw32/sys-root/mingw/lib/libopencv_core.a
sudo rm /usr/x86_64-w64-mingw32/sys-root/mingw/lib/libopencv_highgui.a
sudo ln -s /usr/x86_64-w64-mingw32/sys-root/mingw/x64/mingw/lib/libopencv_highgui2413.dll.a \
  /usr/x86_64-w64-mingw32/sys-root/mingw/lib/libopencv_highgui.a
sudo rm /usr/x86_64-w64-mingw32/sys-root/mingw/lib/libopencv_imgproc.a
sudo ln -s /usr/x86_64-w64-mingw32/sys-root/mingw/x64/mingw/lib/libopencv_imgproc2413.dll.a \
  /usr/x86_64-w64-mingw32/sys-root/mingw/lib/libopencv_imgproc.a
sudo rm /usr/x86_64-w64-mingw32/sys-root/mingw/lib/libopencv_objdetect.a
sudo ln -s /usr/x86_64-w64-mingw32/sys-root/mingw/x64/mingw/lib/libopencv_objdetect2413.dll.a \
  /usr/x86_64-w64-mingw32/sys-root/mingw/lib/libopencv_objdetect.a
sudo rm /usr/x86_64-w64-mingw32/sys-root/mingw/bin/libopencv_core2413.dll
sudo rm /usr/x86_64-w64-mingw32/sys-root/mingw/bin/libopencv_highgui2413.dll
sudo rm /usr/x86_64-w64-mingw32/sys-root/mingw/bin/libopencv_imgproc2413.dll
sudo rm /usr/x86_64-w64-mingw32/sys-root/mingw/bin/libopencv_objdetect2413.dll
sudo ln -s /usr/x86_64-w64-mingw32/sys-root/mingw/x64/mingw/bin/libopencv_core2413.dll /usr/x86_64-w64-mingw32/sys-root/mingw/bin/libopencv_core2413.dll
sudo ln -s /usr/x86_64-w64-mingw32/sys-root/mingw/x64/mingw/bin/libopencv_highgui2413.dll /usr/x86_64-w64-mingw32/sys-root/mingw/bin/libopencv_highgui2413.dll
sudo ln -s /usr/x86_64-w64-mingw32/sys-root/mingw/x64/mingw/bin/libopencv_imgproc2413.dll /usr/x86_64-w64-mingw32/sys-root/mingw/bin/libopencv_imgproc2413.dll
sudo ln -s /usr/x86_64-w64-mingw32/sys-root/mingw/x64/mingw/bin/libopencv_objdetect2413.dll /usr/x86_64-w64-mingw32/sys-root/mingw/bin/libopencv_objdetect2413.dll
cd ..


echo "3.16 kms-filters"
mkdir kms-filters-build
cd kms-filters-build/
mingw64-cmake -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_MODULE_PATH=$cmakemodules \
  -DCMAKE_INSTALL_PREFIX=/usr/x86_64-w64-mingw32/sys-root/mingw \
  -DKURENTO_MODULES_DIR=/usr/x86_64-w64-mingw32/sys-root/mingw/share/kurento/modules/ \
  -DCMAKE_C_FLAGS="-Wno-error=deprecated-declarations" \
  ../kms-filters
mingw64-make
pause
sudo mingw64-make install
cd ..


echo "3.17 gst-plugins-good"
cd gst-plugins-good/
./autogen.sh
mingw64-configure \
  --disable-wavpack --disable-valgrind --disable-directsound \
  --disable-libcaca --disable-waveform \
  --libexec=/usr/x86_64-w64-mingw32/sys-root/mingw/libexec \
  --disable-debug --disable-gtk-doc --disable-examples
printf "all:\ninstall:\nclean:\nuninstall:\n" > tests/Makefile
mingw64-make
pause
sudo mingw64-make install
cd ..

echo "3.18 libsrtp"
cd libsrtp/
mingw64-configure
mingw64-make
pause
sudo mingw64-make install
cd ..

echo "3.19 gst-plugins-bad"
cd gst-plugins-bad/
./autogen.sh
mingw64-configure \
  --disable-directsound --disable-direct3d --disable-debug \
  --disable-examples --disable-gtk-doc --disable-winscreencap \
  --disable-winks --disable-wasapi --disable-opencv
sed -i 's/\buint\b/unsigned/g' ext/opencv/gstmotioncells.cpp ## We may need this later
printf "all:\ninstall:\nclean:\nuninstall:\n" > tests/Makefile
mingw64-make
pause
sudo mingw64-make install

cd ..

#echo "3.21 gst-libav"
#cd gst-libav/
#./autogen.sh
#mingw64-configure \
#  --disable-directsound --disable-direct3d \
#  --disable-examples --disable-gtk-doc --disable-winscreencap \
#  --disable-winks --disable-wasapi --disable-opencv
#printf "all:\ninstall:\nclean:\nuninstall:\n" > tests/Makefile
#mingw64-make
#pause
##sudo mingw64-make install

#cd ..

echo "3.22 openssl"
cd openssl/
unset CC
./Configure shared no-sse2 --cross-compile-prefix=x86_64-w64-mingw32- mingw64
mingw64-make depend
mingw64-make
cp libeay32.dll libcrypto-10-no-sse.dll
#cp ssleay32.dll libssl-10.dll
pause
#sudo mingw64-make install

cd ..

echo "BUILD DONE."
