#!/bin/bash
function pause() {
        echo -e "\e[30m\e[45m\e[5mPress ENTER to continue...\e[97m\e[49m"
#       read  
}

function getcmakemodules() {
	cd kms-cmake-utils
	cmakemodules=`cmake -L | awk -f ../gawk-find-cmake`
	echo "cmake module path: " $cmakemodules
	cd ..
}

