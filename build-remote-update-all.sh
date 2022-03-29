#!/bin/bash

#if [ -z "$1" ]
#then
#      echo "needs branch argument"
#	  exit
#fi

#if false; then

cd kms-cmake-utils/
git remote update
cd ..

cd kurento-module-creator/
git remote update
cd ..

cd gstreamer/
git remote update
cd ..

cd gst-plugins-base/
git remote update
cd ..

#fi

cd jsoncpp/
git remote update
cd ..

#if false; then

cd kms-jsonrpc/
git remote update
cd ..

cd libvpx/
git remote update
cd ..

cd kms-core/
git remote update
cd ..

cd libevent/
git remote update
cd ..

cd kurento-media-server/
git remote update
cd ..

cd usrsctp/
git remote update
cd ..

cd openwebrtc-gst-plugins/
git remote update
cd ..


cd libnice/
git remote update
cd ..

cd kms-elements/
git remote update
cd ..

cd opencv/		
git remote update
cd ..

cd kms-filters/
git remote update
cd ..

cd gst-plugins-good/
git remote update
cd ..

cd libsrtp/
git remote update
cd ..

cd gst-plugins-bad/
git remote update
cd ..

cd glib/
git remote update
cd ..

#cd gst-libav/
#git remote update
#cd ..

cd openssl/
git remote update
cd ..

#fi
