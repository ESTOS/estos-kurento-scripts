#!/bin/bash

set -x

#if [ -z "$1" ]
#then
#      echo "needs branch argument"
#	  exit
#fi

#if false; then

cd kms-cmake-utils && \
rm -rf * && \
git checkout -f && \
cd ..

cd kurento-module-creator && \
rm -rf * && \
git checkout -f && \
cd ..

cd gstreamer && \
rm -rf * && \
git checkout -f && \
cd ..

cd gst-plugins-base && \
rm -rf * && \
git checkout -f && \
cd ..

#fi

cd jsoncpp && \
rm -rf * && \
git checkout -f && \
cd ..

#if false; then

cd kms-jsonrpc && \
rm -rf * && \
git checkout -f && \
cd ..

cd libvpx && \
rm -rf * && \
git checkout -f && \
cd ..

cd kms-core && \
rm -rf * && \
git checkout -f && \
cd ..

cd libevent && \
rm -rf * && \
git checkout -f && \
cd ..

cd kurento-media-server && \
rm -rf * && \
git checkout -f && \
cd ..

cd usrsctp && \
rm -rf * && \
git checkout -f && \
cd ..

cd openwebrtc-gst-plugins && \
rm -rf * && \
git checkout -f && \
cd ..


cd libnice && \
rm -rf * && \
git checkout -f && \
cd ..

cd kms-elements && \
rm -rf * && \
git checkout -f && \
cd ..

cd opencv/		
rm -rf *
git checkout -f
cd ..

cd kms-filters && \
rm -rf * && \
git checkout -f && \
cd ..

cd gst-plugins-good && \
rm -rf * && \
git checkout -f && \
cd ..

cd libsrtp && \
rm -rf * && \
git checkout -f && \
cd ..

cd gst-plugins-bad && \
rm -rf * && \
git checkout -f && \
cd ..

cd glib && \
rm -rf * && \
git checkout -f && \
cd ..

cd gst-libav && \
rm -rf * && \
git checkout -f && \
cd ..

#fi
