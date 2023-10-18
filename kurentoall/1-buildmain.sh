#! /bin/sh

set -e #stop on error
set -x #print all executed command
#export MAKEFLAGS="-j8"

ROOT_DIRECTORY=/x/dev/estos-kurento-scripts/kurentoall
#ROOT_DIRECTORY=/c/lwx/dev/estos-kurento-scripts/kurentoall
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

BUILDTYPE=RELEASE
#BUILDTYPE=DEBUG


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
https://github.com/ESTOS/glib.git						2.78.0
https://github.com/ESTOS/libnice.git					0.1.21
https://github.com/ESTOS/gstreamer.git					1.22.5
https://github.com/ESTOS/opencv.git						4.8.0
https://github.com/ESTOS/openssl.git					openssl-3.0.2
https://github.com/ESTOS/websocketpp.git				0.8.2
ssh://rolf.burkhardt@leonas1/git/kurento/kurento.git	msys-build-test
EOF
}
#https://github.com/ESTOS/kurento.git					7.0.1 -> needs cairo-float.patch
#https://github.com/ESTOS/cairo.git						1.18.0 -> ok without cairo-float.patch
#https://gitlab.freedesktop.org/cairo/cairo.git			1.17.6 -> problem with d2d1_3.h
#https://github.com/ESTOS/glib.git						2.74.1

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
	meson setup --buildtype $build_type build-$BUILD_TYPE
	ninja -C build-$BUILD_TYPE
	ninja -C build-$BUILD_TYPE install
	popd
}

build_cairo()
{
	pushd "cairo"
	meson setup --buildtype $build_type build-$BUILD_TYPE
	ninja -C build-$BUILD_TYPE
	ninja -C build-$BUILD_TYPE install
	popd
}

build_gstreamer()
{
	pushd "gstreamer"
	meson setup --buildtype $build_type build-$BUILD_TYPE
	#builderror:
	# diff -up hb-subset-threads.cc.old hb-subset-threads.cc > harfbuzz-5.2.0-1-hb-subset-threads.patch
#set +e
	#harfbuzz-5.2.0 1.22.5 -> pango installs harfbuzz and cairo
	#patch -N $ROOT_DIRECTORY/gstreamer/subprojects/harfbuzz-5.2.0/test/threads/hb-subset-threads.cc $ROOT_DIRECTORY/harfbuzz-5.2.0-1-hb-subset-threads.patch
	#Cairo 1.17.6 -> 1.18.0 is ok
	#/mingw64/include/d2d1_3.h must not exist else we get a build error	ID2D1DeviceContext4
	#../subprojects/cairo/src/win32/cairo-dwrite-font.cpp:729:50: error: 'MCW_PC' was not declared in this scope
	#- solution: add line: "#define	MCW_PC		0x00030000	/* Precision */" -> to /mingw64/include/float.h
	# diff -up /mingw64/include/float.h.old /mingw64/include/float.h > cairo-float.patch
	#patch -N /mingw64/include/float.h $ROOT_DIRECTORY/cairo-float.patch
#set -e
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
	
	#bin/build-run.sh --msys --build-only --$build_type
	#bin/build-run.sh --msys --build-only --verbose --$build_type
	#bin/build-run.sh --msys --addcmakeargs "-DCMAKE_INSTALL_PREFIX=$MINGW_PREFIX" --build-only --$build_type
	bin/build-run.sh --msys --addcmakeargs "-DCMAKE_INSTALL_PREFIX=$MINGW_PREFIX" --build-only --verbose --$build_type
	#bin/build-run.sh --msys --cmakeconfig-only --verbose
	
	export JAVA_HOME=$SAV_JAVA_HOME
	export PATH=$SAV_PATH
	export PKG_CONFIG_SYSTEM_INCLUDE_PATH=$SAV_PKG_CONFIG_SYSTEM_INCLUDE_PATH
	export PKG_CONFIG_PATH=$SAV_PKG_CONFIG_PATH
	popd
	popd
}

build_kurento_run()
{
	pushd "kurento"
	git submodule update --init --recursive --force
	pushd "server"
	export JAVA_HOME=$MY_JAVA_HOME
	export PATH=$MY_PATH
	export PKG_CONFIG_SYSTEM_INCLUDE_PATH=$MY_PKG_CONFIG_SYSTEM_INCLUDE_PATH
	export PKG_CONFIG_PATH=$MY_PKG_CONFIG_PATH
	
	#export KURENTO_CONF_FILE=$ROOT_DIRECTORY/kmswindows/etc/kurento/kurento.conf.json
	#export KURENTO_MODULES_CONFIG_PATH=$ROOT_DIRECTORY/kmswindows/etc/kurento/modules/kurento
	export KURENTO_CONF_FILE=$ROOT_DIRECTORY/kmswindows/config/kurento.conf.json
	export KURENTO_MODULES_CONFIG_PATH=$ROOT_DIRECTORY/kmswindows/config/kurento
	#export KURENTO_MODULES_PATH=$MINGW_PREFIX/kurento
	export KURENTO_MODULES_PATH=$ROOT_DIRECTORY/kmswindows/bin
	export GST_PLUGIN_PATH=/mingw64/lib/gstreamer-1.0
	
	bin/build-run.sh --msys --verbose --$build_type
	#bin/build-run.sh --msys --$build_type
	
	export JAVA_HOME=$SAV_JAVA_HOME
	export PATH=$SAV_PATH
	export PKG_CONFIG_SYSTEM_INCLUDE_PATH=$SAV_PKG_CONFIG_SYSTEM_INCLUDE_PATH
	export PKG_CONFIG_PATH=$SAV_PKG_CONFIG_PATH
	popd
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
	#cairo is installed with mingw-w64-x86_64-pango
	#build_cairo
	build_gstreamer
	#gstreamer is building libnice anyway so build the newer version after it
	build_libnice
	build_opencv
	build_openssl
	build_websocketpp
	build_kurento
}

case "$1" in
	setup)
		setup_workspace
		;;
	build)
		build
		;;
	buildlog)
		build > logbuildmain.txt 2>&1
		;;
	buildkurentolog)
		build_kurento > logbuildmainkurento.txt 2>&1
		;;
	buildalllog)
		setup_workspace > logbuildmain.txt 2>&1
		build >> logbuildmain.txt 2>&1
		;;
	build_*)
		set -x #print all executed command
		$1
		;;
	all)
		build
		;;
	*)
set +x
		echo ""
		echo "Usage:"
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

