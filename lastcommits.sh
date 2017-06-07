#!/bin/bash
function pause() {
	echo -e "\e[30m\e[45m\e[5mPress ENTER to continue...\e[97m\e[49m"
	read  
}

function gitcheck {
cd $1
git remote -v >>../$lastcommitslog
echo -e "\r\n"
git log -n 1 >>../$lastcommitslog
echo -e "\r\n\r\n------------------------------------------------------\r\n\r\n" >> ../$lastcommitslog
cd ..
}

# if [ -d /usr/i686-w64-mingw32/sys-root/mingw/share/cmake-3.5 ]; then echo "hallo"; fi;
cmakemodules=/usr/i686-w64-mingw32/sys-root/mingw/share/cmake-3.5/Modules/
if [ -d /usr/i686-w64-mingw32/sys-root/mingw/share/cmake-3.6 ]; then
	cmakemodules=/usr/i686-w64-mingw32/sys-root/mingw/share/cmake-3.6/Modules/
fi

echo "cmake module path: " $cmakemodules

commitlogs_now=lastcommits_before_`date "+%Y%m%d_%H%M%S_%N"`.txt
lastcommitslog=lastcommits_actual.txt

echo "commit log now: " $commitlogs_now
echo "last commit log: " $lastcommitslog

# move lastcommitlog into an archive
if [ -e $lastcommitslog ]; then
	mv $lastcommitslog $commitlogs_now
	rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi
else
	touch $commitlogs_now
fi
touch $lastcommitslog

echo "3.1 kms-cmake-utils"
gitcheck kms-cmake-utils

echo "3.2 kurento-module-creator"
gitcheck kurento-module-creator/

echo "3.3 gstreamer-1.7.x/1.8.1 (Fork of github/kurento/gstreamer 06.06.2017"
gitcheck gstreamer

echo "3.4 gst-plugins-base-1.5"
gitcheck gst-plugins-base

echo "3.5 jsoncpp"
gitcheck jsoncpp

echo "3.6 kms-jsonrpc"
gitcheck kms-jsonrpc

echo "3.7 libvpx"
gitcheck libvpx

echo "3.8 kms-core"
gitcheck kms-core

echo "3.9 libevent"
gitcheck libevent/

echo "3.10 kurento-media-server"
gitcheck kurento-media-server

echo "3.11 usersctp"
gitcheck usrsctp

echo "3.12 openwebrtc-gst-plugins"
gitcheck openwebrtc-gst-plugins/

echo "3.13 libnice"
gitcheck libnice

echo "3.14 kms-elements"
gitcheck kms-elements

echo "3.16 kms-filters"
gitcheck kms-filters

echo "3.17 gst-plugins-good"
gitcheck gst-plugins-good

echo "3.18 libsrtp"
gitcheck libsrtp

diff $lastcommitslog $commitlogs_now
ret=$?
if [[ $ret -eq 0 ]]; then
	echo "No changes since last check!"
fi


echo "LAST LOG UPDATE DONE."
