#! /bin/sh
set -e #stop on error
set -x #print all executed command
echo "Prepare distribution package"

CPPARAMS=
#CPPARAMS=--preserve=timestamps
actualbuilddate=`date "+%Y%m%d_%H%M%S_%N"`
actualcommitlogs=lastcommitlogs_$actualbuilddate

source ./2.0-lastcommits.sh


rm -rf dist64
mkdir dist64
cd dist64
mkdir -p bin/
mkdir -p lib/gstreamer-1.0/
mkdir -p lib/gstreamer-1.0/kurento/
mkdir -p lib/kurento/modules/
mkdir -p etc/kurento/
mkdir -p etc/kurento/modules/

cp $CPPARAMS ../lastcommits_actual.txt $actualcommitlogs

export PREF=../kmswindows
cp $CPPARAMS -r $PREF/* .

# safe build timestamp into zip-file
#rm -rf emswindows64*
touch emswindows64_$actualbuilddate

# zip filename
zipfilename=emswindows64_$actualbuilddate.zip
zipsymfilename=emswindows64sym_$actualbuilddate.zip

# if zip is not installed
if ! pacman -Q zip >/dev/null 2>&1; then
    pacman -S --noconfirm zip
fi
echo "zip -r ../$zipfilename *"
zip -r ../$zipfilename *
cd ..
echo "zip -r ../$zipfilename *"
zip -r $zipsymfilename kmswindows-symbols/*

# upload to buildserver if available
if [ -f  localupload ]; then
	echo "upload $zipfilename ..."
 	curl -F "kurentozip=@$zipfilename" build.estos.de/kurento
fi

# do a linefeed
echo



