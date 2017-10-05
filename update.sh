#!/bin/bash
source common.sh
getcmakemodules

echo "3.1 kms-cmake-utils"
cd kms-cmake-utils
git pull
cd ..

echo "3.2 kurento-module-creator"
cd kurento-module-creator/
git pull
cd ..

echo "3.3 gstreamer-1.7.x/1.8.1 (Fork of github/kurento/gstreamer 06.06.2017"
cd gstreamer
git pull
cd ..

echo "3.4 gst-plugins-base-1.5"
cd gst-plugins-base
git pull
cd ..

echo "3.5 jsoncpp"
cd jsoncpp
git pull
cd ..

echo "3.6 kms-jsonrpc"
cd kms-jsonrpc
git pull
cd ..

echo "3.7 libvpx"
cd libvpx
git pull https://github.com/webmproject/libvpx.git v1.5.0
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

echo "3.9 libevent"
cd libevent
git pull
cd ..

echo "3.10 kurento-media-server"
cd kurento-media-server
git pull
cd ..

echo "3.11 usersctp"
cd usrsctp
git pull
cd ..

echo "3.12 openwebrtc-gst-plugins"
cd openwebrtc-gst-plugins
git pull
cd ..

echo "3.13 libnice"
cd libnice
git pull
cd ..

echo "3.14 kms-elements"
cd kms-elements
git pull
cd ..

echo "3.15 opencv"
cd opencv
git pull https://github.com/itseez/opencv.git 2.4.13.1
cd ..

echo "3.16 kms-filters"
cd kms-filters
git pull
cd ..

echo "3.17 gst-plugins-good"
cd gst-plugins-good/
git pull
cd ..

echo "3.18 libsrtp"
cd libsrtp
git pull https://github.com/cisco/libsrtp.git v1.5.4
cd ..

echo "3.18 gst-plugins-bad"
cd gst-plugins-bad/
git pull
cd ..

echo "UPDATE DONE."
