#!/bin/sh
#source common.sh
#getcmakemodules

function gitcheck {
cd $1
git remote -v >>../$lastcommitslog
echo -e "\r\n"
git log -n 1 >>../$lastcommitslog
echo -e "\r\n\r\n------------------------------------------------------\r\n\r\n" >> ../$lastcommitslog
cd ..
}

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

gitcheck glib
gitcheck libnice
gitcheck gstreamer
gitcheck opencv
gitcheck openssl
gitcheck websocketpp
gitcheck kurento

#diff $lastcommitslog $commitlogs_now
#ret=$?
#if [[ $ret -eq 0 ]]; then
#	echo "No changes since last check!"
#fi


#echo "LAST LOG UPDATE DONE."
