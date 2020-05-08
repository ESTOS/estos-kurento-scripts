#!/bin/bash

#if [ -z "$1" ]
#then
#      echo "needs branch argument"
#	  exit
#fi

#if false; then

cd kms-cmake-utils/
git clean -xf
git checkout -f
cd ..

cd kurento-module-creator/
git clean -xf
git checkout -f
cd ..

cd gstreamer/
git clean -xf
git checkout -f
cd ..

cd gst-plugins-base/
git clean -xf
git checkout -f
cd ..

#fi

cd jsoncpp/
git clean -xf
git checkout -f
cd ..

#if false; then

cd kms-jsonrpc/
git clean -xf
git checkout -f
cd ..

cd libvpx/
git clean -xf
git checkout -f
cd ..

cd kms-core/
git clean -xf
git checkout -f
cd ..

cd libevent/
git clean -xf
git checkout -f
cd ..

cd kurento-media-server/
git clean -xf
git checkout -f
cd ..

cd usrsctp/
git clean -xf
git checkout -f
cd ..

cd openwebrtc-gst-plugins/
git clean -xf
git checkout -f
cd ..


cd libnice/
git clean -xf
git checkout -f
cd ..

cd kms-elements/
git clean -xf
git checkout -f
cd ..

cd opencv/		
git clean -xf
git checkout -f
cd ..

cd kms-filters/
git clean -xf
git checkout -f
cd ..

cd gst-plugins-good/
git clean -xf
git checkout -f
cd ..

cd libsrtp/
git clean -xf
git checkout -f
cd ..

cd gst-plugins-bad/
git clean -xf
git checkout -f
cd ..

cd glib/
git clean -xf
git checkout -f
cd ..

#cd gst-libav/
#git clean -xf
#git checkout -f
#cd ..

#fi
