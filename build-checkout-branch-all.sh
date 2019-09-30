#!/bin/bash

if [ -z "$1" ]
then
      echo "needs branch argument"
	  exit
fi

#if false; then

cd kms-cmake-utils/
git checkout origin/$1 -b $1
git checkout -f $1
git pull origin $1
cd ..

cd kurento-module-creator/
git checkout origin/$1 -b $1
git checkout -f $1
git pull origin $1
cd ..

cd gstreamer/
git checkout origin/$1 -b $1
git checkout -f $1
git pull origin $1
cd ..

cd gst-plugins-base/
git checkout origin/$1 -b $1
git checkout -f $1
git pull origin $1
cd ..

#fi

cd jsoncpp/
git checkout origin/$1 -b $1
git checkout -f $1
git pull origin $1
cd ..

#if false; then

cd kms-jsonrpc/
git checkout origin/$1 -b $1
git checkout -f $1
git pull origin $1
cd ..

cd libvpx/
git checkout origin/$1 -b $1
git checkout -f $1
git pull origin $1
cd ..

cd kms-core/
git checkout origin/$1 -b $1
git checkout -f $1
git pull origin $1
cd ..

cd libevent/
git checkout origin/$1 -b $1
git checkout -f $1
git pull origin $1
cd ..

cd kurento-media-server/
git checkout origin/$1 -b $1
git checkout -f $1
git pull origin $1
cd ..

cd usrsctp/
git checkout origin/$1 -b $1
git checkout -f $1
git pull origin $1
cd ..

cd openwebrtc-gst-plugins/
git checkout origin/$1 -b $1
git checkout -f $1
git pull origin $1
cd ..


cd libnice/
git checkout origin/$1 -b $1
git checkout -f $1
git pull origin $1
cd ..

cd kms-elements/
git checkout origin/$1 -b $1
git checkout -f $1
git pull origin $1
cd ..

cd opencv/		
git checkout origin/$1 -b $1
git checkout -f $1
git pull origin $1
cd ..

cd kms-filters/
git checkout origin/$1 -b $1
git checkout -f $1
git pull origin $1
cd ..

cd gst-plugins-good/
git checkout origin/$1 -b $1
git checkout -f $1
git pull origin $1
cd ..

cd libsrtp/
git checkout origin/$1 -b $1
git checkout -f $1
git pull origin $1
cd ..

cd gst-plugins-bad/
git checkout origin/$1 -b $1
git checkout -f $1
git pull origin $1
cd ..

#cd gst-libav/
#git checkout origin/$1 -b $1
#git checkout -f $1
#git pull origin $1
#cd ..

#cd glib/
#git checkout origin/$1 -b $1
#git checkout -f $1
#git pull origin $1
#cd ..

#fi
