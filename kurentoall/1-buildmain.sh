#! /bin/sh

set -e #stop on error
set -x #print all executed command

BUILDTYPE=RELEASE
#BUILDTYPE=DEBUG

if [ -d /c/lwx/dev ]; then
ROOT_DIRECTORY=/c/lwx/dev/estos-kurento-scripts/kurentoall
export MAKEFLAGS="-j8"
else
ROOT_DIRECTORY=/x/dev/estos-kurento-scripts/kurentoall
fi

cd $ROOT_DIRECTORY

SAV_JAVA_HOME=$JAVA_HOME
SAV_PATH=$PATH
SAV_PKG_CONFIG_SYSTEM_INCLUDE_PATH=$PKG_CONFIG_SYSTEM_INCLUDE_PATH
SAV_PKG_CONFIG_PATH=$PKG_CONFIG_PATH
#MY_JAVA_HOME="/c/Programme/Eclipse-Adoptium/jdk-11.0.20.8-hotspot"
MY_JAVA_HOME=$ROOT_DIRECTORY/jdk-11
MY_PATH=$PATH:$ROOT_DIRECTORY/maven/bin
MY_PKG_CONFIG_SYSTEM_INCLUDE_PATH=$PKG_CONFIG_SYSTEM_INCLUDE_PATH:/usr/include
MY_PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig:$PKG_CONFIG_PATH:/usr/lib/pkgconfig

if [ $BUILDTYPE = RELEASE ]; then
BUILD_TYPE=Release
build_type=release
DEBUGOPENSSL=
else
BUILD_TYPE=Debug
build_type=debug
DEBUGOPENSSL=--debug
fi

# array of repo URL's and related tags
repos ()
{
cat <<EOF
https://github.com/ESTOS/glib.git						2.89.0
https://github.com/ESTOS/libnice.git					0.1.23
https://github.com/ESTOS/gstreamer.git					1.28.3
https://github.com/ESTOS/opencv.git						4.13.0
https://github.com/ESTOS/openssl.git					openssl-3.0.20
https://github.com/ESTOS/websocketpp.git				msys-estos-develop
https://github.com/ESTOS/kurento.git					msys-estos-main
EOF
}

build_tools ()
{
	#extract apache-maven-3.9.3-bin.zip/apache-maven-3.9.3 to /x/dev/estos-kurento-scripts/maven (maven\bin;naven\lib;...)
	if [ ! -d maven ]; then
		unzip /x/dev/tools/mingw/tools/apache-maven-3.9.3-bin.zip
		mv apache-maven-3.9.3 maven
	fi
	#Install https://adoptium.net/de/temurin/releases -> Windows x64 JDK 11-LTS zip
	if [ ! -d jdk-11 ]; then
		unzip /x/dev/tools/mingw/tools/OpenJDK11U-jdk_x64_windows_hotspot_11.0.20.1_1.zip
		mv jdk-11.0.20.1+1 jdk-11
	fi
}

build_glib()
{
	pushd "glib"
	meson setup --buildtype $build_type build-$BUILD_TYPE
	ninja -C build-$BUILD_TYPE
	ninja -C build-$BUILD_TYPE install
	popd
}

build_libnice()
{
	pushd "libnice"
	# meson setup --buildtype $build_type build-$BUILD_TYPE
	# tests/meson.build links libdl for a GStreamer test (LD_PRELOAD) — not available on Windows/MinGW.
	meson setup --buildtype $build_type \
		-Dtests=disabled \
		-Dexamples=disabled \
		build-$BUILD_TYPE
	ninja -C build-$BUILD_TYPE
	ninja -C build-$BUILD_TYPE install
	popd
}

build_gstreamer()
{
	pushd "gstreamer"
	# meson setup --buildtype $build_type build-$BUILD_TYPE
	# d3d12 WGC: MinGW g++ + WRL ComPtr fails on gstd3d12graphicscapture.cpp (incomplete type).
	meson setup --buildtype $build_type \
		-Dgst-plugins-bad:d3d12=disabled \
		build-$BUILD_TYPE
	ninja -C build-$BUILD_TYPE
	# -> /mingw64/
	ninja -C build-$BUILD_TYPE install
	popd
}

build_opencv()
{   
	mkdir -p opencv-build-$BUILD_TYPE
	pushd "opencv-build-$BUILD_TYPE"
	echo $PATH
	PATH=
	export PATH=/mingw64/bin:/usr/local/bin:/usr/bin:/bin
	unset JAVA_HOME
	cmake -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
		-DCMAKE_INSTALL_PREFIX=$MINGW_PREFIX \
		-DBUILD_opencv_videoio=OFF \
		-DOPENCV_BIN_INSTALL_PATH=$MINGW_PACKAGE_PREFIX/bin \
		-DOPENCV_LIB_INSTALL_PATH=$MINGW_PACKAGE_PREFIX/lib \
		-DOPENCV_GENERATE_PKGCONFIG=ON \
		-DBUILD_TESTS=OFF \
		-DBUILD_PERF_TESTS=OFF \
		-DBUILD_EXAMPLES=OFF \
		-DBUILD_opencv_apps=OFF\
		../opencv
	cmake --build .
	cmake --install .	
	export PATH=$SAV_PATH
	export JAVA_HOME=$SAV_JAVA_HOME 
	echo $PATH
	popd
}

build_openssl()
{
	pushd "openssl"
	./config shared no-sse2 $DEBUGOPENSSL
	make
	make install
	popd
}

build_websocketpp()
{
	mkdir -p websocketpp-build-$BUILD_TYPE
	pushd "websocketpp-build-$BUILD_TYPE"
	cmake  -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
		-DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
		-DCMAKE_INSTALL_PREFIX=$MINGW_PREFIX ../websocketpp
	cmake --build .
	cmake --install .
	popd
}

build_kurento()
{
	pushd "kurento"
	git submodule update --init --recursive --force
	pushd "server"
	export JAVA_HOME=$MY_JAVA_HOME
	export PATH=$MY_PATH
	export PKG_CONFIG_SYSTEM_INCLUDE_PATH=$MY_PKG_CONFIG_SYSTEM_INCLUDE_PATH
	export PKG_CONFIG_PATH=$MY_PKG_CONFIG_PATH
	
	if [ $BUILDTYPE = RELEASE ]; then
	bin/build-run.sh --msys --addcmakeargs "-DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DOpenCV_DIR=$MINGW_PREFIX/x64/mingw/lib -DCMAKE_INSTALL_PREFIX=$MINGW_PREFIX" --build-only --$build_type
	else
	bin/build-run.sh --msys --addcmakeargs "-DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DOpenCV_DIR=$MINGW_PREFIX/x64/mingw/lib -DCMAKE_INSTALL_PREFIX=$MINGW_PREFIX" --build-only --verbose --$build_type
	fi
	
	export JAVA_HOME=$SAV_JAVA_HOME
	export PATH=$SAV_PATH
	export PKG_CONFIG_SYSTEM_INCLUDE_PATH=$SAV_PKG_CONFIG_SYSTEM_INCLUDE_PATH
	export PKG_CONFIG_PATH=$SAV_PKG_CONFIG_PATH
	popd
	popd
}

kurento_run()
{
set +e #dont stop on error
	#todo
	#build_kurento
	#copy files to $ROOT_DIRECTORY/kmswindows
	#exit
	
	pushd "kmswindows"
	rm /c/Users/$USERNAME/AppData/Local/Microsoft/Windows/INetCache/gstreamer-1.0/registry.x86_64-mingw.bin
	export PATH="$ROOT_DIRECTORY/kmswindows/bin:$PATH"
	export GST_PLUGIN_PATH="$ROOT_DIRECTORY/kmswindows/lib/gstreamer-1.0/kurento:$ROOT_DIRECTORY/kmswindows/lib/gstreamer-1.0"
	export NICE_DEBUG="stun,nice,pseudotcp,pseudotcp-verbose,nice-verbose"
	export G_MESSAGES_DEBUG="libnice-stun,libnice,libnice-pseudotcp,libnice-pseudotcp-verbose,libnice-verbose,libnice-timer-verbose,udpsrcrxrtp,rtpsessiontxrtp"
	export G_MESSAGES_DEBUG="rtpsessiontxrtp"
	GSTDEBUGLEVEL=3
	GSTDEBUG=kms*:6,Kurento*:5
	$ROOT_DIRECTORY/kmswindows/bin/uc-media-server.exe -d $ROOT_DIRECTORY/kmswindows/log -s 500 -n 5 --gst-debug-level=$GSTDEBUGLEVEL --gst-debug=donttouchenv:1,$GSTDEBUG $ROOT_DIRECTORY/kmswindows/log/log.txt 2>&1
	popd
}

setup_workspace()
{
set +e #dont stop on error
set -x #print all executed command	
    local url tag rname ldir
	# split url, local dir, and tag
	repos | while read url tag; do
		#url=${i%\!*}
		#tag=${i#*\!}
		rname=${url##*/}
		ldir=${rname%.git}

		# checkout/update workspace
		mkdir -p "$ldir"
		pushd "$ldir"
		if [ -d .git ]; then
			if [ "$url" == "$(git remote get-url origin)" ]; then
				# workspace exists -> fetching latest data
				git fetch --all
			else
				# unknown/wrong workspace -> cleanup
				echo "wrong repository"
				#rm -rf ./.git ./*
				exit
			fi
		fi
		if [ ! -d .git ]; then
			git clone "$url" .
		fi
		git checkout "$tag"
		popd
	done
	
	build_tools
}

build()
{
set -e #stop on error
set -x #print all executed command
	build_glib
	build_gstreamer
	#gstreamer is building libnice anyway so build the newer version after it
	build_libnice
	build_opencv
	build_openssl
	build_websocketpp
	build_kurento
}

case "$1" in
	run)
		kurento_run
		;;
	setup)
		start=$(date +%s)
		date
		setup_workspace
		end=$(date +%s)
		date
		echo "Time: $((end - start)) Seconds"
		;;
	build)
		start=$(date +%s)
		date
		build
		end=$(date +%s)
		date
		echo "Time: $((end - start)) Seconds"
		;;
	buildlog)
		start=$(date +%s)
		echo "Start: $(date)" > logbuildmain.txt 2>&1
		build >> logbuildmain.txt 2>&1
		end=$(date +%s)
		echo "End: $(date)" >> logbuildmain.txt 2>&1
		echo "Time: $((end - start)) Seconds" >> logbuildmain.txt 2>&1
		;;
	buildkurentolog)
		start=$(date +%s)
		echo "Start: $(date)" > logbuildmainkurento.txt
		build_kurento >> logbuildmainkurento.txt 2>&1
		end=$(date +%s)
		echo "End: $(date)" >> logbuildmainkurento.txt 2>&1
		echo "Time: $((end - start)) Seconds" >> logbuildmainkurento.txt 2>&1
		;;
	buildalllog)
		start=$(date +%s)
		echo "Start: $(date)" > logbuildmain.txt 2>&1
		setup_workspace >> logbuildmain.txt 2>&1
		build >> logbuildmain.txt 2>&1
		end=$(date +%s)
		echo "End: $(date)" >> logbuildmain.txt 2>&1
		echo "Time: $((end - start)) Seconds" >> logbuildmain.txt 2>&1
		;;
	build_*)
		start=$(date +%s)
		echo "Start: $(date)" > logbuildmain.txt 2>&1
		set -x #print all executed command
		$1
		end=$(date +%s)
		echo "End: $(date)" >> logbuildmain.txt 2>&1
		echo "Time: $((end - start)) Seconds" >> logbuildmain.txt 2>&1
		;;
	all)
		build
		;;
	*)
set +x
		echo ""
		echo "Usage:"
		echo "  run              -> start kurento"
		echo "  setup            -> clones all components"
		echo "  build            -> build"
		echo "  buildlog         -> build + log to logbuildmain.txt"
		echo "  buildkurentolog  -> build_kurento + log to logbuildmainkurento.txt"
		echo "  buildalllog      -> setup + build + log to logbuildmain.txt"
		echo "  build_*          -> build selected component"
		echo "  all              -> build"
		echo ""
		;;
esac

