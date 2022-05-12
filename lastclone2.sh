#!/bin/bash

#stop on error
#set -e
#print all executed command
#set -x

function gitclone2 {
cd $1 && \
pwd && \
echo git clone https:\/\/github.com\/ESTOS\/$1.git >> ../buildclone-last.sh && \
echo cd $1 >> ../buildclone-last.sh && \
git log -n 1 | grep "^commit" | sed 's/.* /git checkout /' >> ../buildclone-last.sh && \
echo cd .. >> ../buildclone-last.sh && \
cd ..
}

function gitclone {
#gitclone2 $1
cd $1 && \
pwd && \
VERSION=`git log -n 1 | grep "^commit" | sed 's/.* //'` && \
echo https:\/\/github.com\/ESTOS\/$1.git "                " $VERSION >> ../buildclone2-last && \
cd ..
}

#rm -rf buildclone-last.sh
rm -rf buildclone2-last

echo "3.1 kms-cmake-utils"
gitclone kms-cmake-utils

echo "3.2 kurento-module-creator"
gitclone kurento-module-creator

echo "3.3 gstreamer-1.7.x/1.8.1 (Fork of github/kurento/gstreamer 06.06.2017"
gitclone gstreamer

echo "3.4 gst-plugins-base-1.5"
gitclone gst-plugins-base

echo "3.5 jsoncpp"
gitclone jsoncpp

echo "3.6 kms-jsonrpc"
gitclone kms-jsonrpc

echo "3.7 libvpx"
gitclone libvpx

echo "3.8 kms-core"
gitclone kms-core

echo "3.9 libevent"
gitclone libevent

echo "3.10 kurento-media-server"
gitclone kurento-media-server

echo "3.11 usersctp"
gitclone usrsctp

echo "3.12 openwebrtc-gst-plugins"
gitclone openwebrtc-gst-plugins

echo "3.13 libnice"
gitclone libnice

echo "3.14 kms-elements"
gitclone kms-elements

echo "3.15 opencv"
gitclone opencv

echo "3.16 kms-filters"
gitclone kms-filters

echo "3.17 gst-plugins-good"
gitclone gst-plugins-good

echo "3.18 libsrtp"
gitclone libsrtp

echo "3.19 gst-plugins-bad"
gitclone gst-plugins-bad

echo "3.20 glib"
gitclone glib

echo "3.21 openssl"
gitclone openssl

echo "3.22 gst-libav"
gitclone gst-libav

#chmod 775 buildclone-last.sh

