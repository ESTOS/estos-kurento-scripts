#!/bin/bash

#if [ -z "$1" ]
#then
#      echo "needs branch argument"
#	  exit
#fi

#if false; then

rm -rf logstatus.txt

cd kms-cmake-utils/
pwd >> ../logstatus.txt
git status >> ../logstatus.txt
cd ..

cd kurento-module-creator/
pwd >> ../logstatus.txt
git status >> ../logstatus.txt
cd ..

cd gstreamer/
pwd >> ../logstatus.txt
git status >> ../logstatus.txt
cd ..

cd gst-plugins-base/
pwd >> ../logstatus.txt
git status >> ../logstatus.txt
cd ..

#fi

cd jsoncpp/
pwd >> ../logstatus.txt
git status >> ../logstatus.txt
cd ..

#if false; then

cd kms-jsonrpc/
pwd >> ../logstatus.txt
git status >> ../logstatus.txt
cd ..

cd libvpx/
pwd >> ../logstatus.txt
git status >> ../logstatus.txt
cd ..

cd kms-core/
pwd >> ../logstatus.txt
git status >> ../logstatus.txt
cd ..

cd libevent/
pwd >> ../logstatus.txt
git status >> ../logstatus.txt
cd ..

cd kurento-media-server/
pwd >> ../logstatus.txt
git status >> ../logstatus.txt
cd ..

cd usrsctp/
pwd >> ../logstatus.txt
git status >> ../logstatus.txt
cd ..

cd openwebrtc-gst-plugins/
pwd >> ../logstatus.txt
git status >> ../logstatus.txt
cd ..


cd libnice/
pwd >> ../logstatus.txt
git status >> ../logstatus.txt
cd ..

cd kms-elements/
pwd >> ../logstatus.txt
git status >> ../logstatus.txt
cd ..

cd opencv/	
pwd >> ../logstatus.txt	
git status >> ../logstatus.txt
cd ..

cd kms-filters/
pwd >> ../logstatus.txt
git status >> ../logstatus.txt
cd ..

cd gst-plugins-good/
pwd >> ../logstatus.txt
git status >> ../logstatus.txt
cd ..

cd libsrtp/
pwd >> ../logstatus.txt
git status >> ../logstatus.txt
cd ..

cd gst-plugins-bad/
pwd >> ../logstatus.txt
git status >> ../logstatus.txt
cd ..

cd gst-libav/
pwd >> ../logstatus.txt
git status >> ../logstatus.txt
cd ..

cd glib/
pwd >> ../logstatus.txt
git status >> ../logstatus.txt
cd ..

cd openssl/
pwd >> ../logstatus.txt
git status >> ../logstatus.txt
cd ..

#fi
