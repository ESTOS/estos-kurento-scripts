#!/bin/bash
# build script for kurento for windows

#set -e #stop on error
#set -x #print all executed command

#MINGW=mingw32
MINGW=mingw64
BUILDTYPE=RELEASE
#BUILDTYPE=DEBUG

DOINSTALL=TRUE
DOBUILD=TRUE

if [ $MINGW = mingw32 ]; then
MINGWPATH=i686-w64-mingw32
MINGWX=x86
MINGWP1=mingw
else
MINGWPATH=x86_64-w64-mingw32
MINGWX=x64
MINGWP1=mingw64
fi

if [ $BUILDTYPE = RELEASE ]; then
BUILD_TYPE=Release
CONFIGUREPARAMDEBUG=--disable-debug
DEBUGSUFFIX=
DEBUGOPENSSL=
DEBUGLIBVPX=
DEBUGLIBSRTP=
else
BUILD_TYPE=Debug
CONFIGUREPARAMDEBUG=--enable-debug
DEBUGSUFFIX=d
DEBUGOPENSSL=--debug
DEBUGLIBVPX="--enable-debug --enable-debug-libs"
DEBUGLIBSRTP=--enable-debug-logging
fi

function pause() {
        echo -e "\e[30m\e[45m\e[5mPress ENTER to continue...\e[97m\e[49m"
#       read  
}

function getcmakemodules() {
	pushd "kms-cmake-utils-build"
	cmakemodules=`cmake -L | awk -f ../gawk-find-cmake`
	echo "cmake module path: " $cmakemodules
	popd
}

build_kms-cmake-utils()
{
	echo "--- 01 --- kms-cmake-utils ---"
	mkdir -p "kms-cmake-utils-build"
	pushd "kms-cmake-utils-build"
	if [ $DOBUILD = TRUE ]; then
	$MINGW-cmake -DCMAKE_BUILD_TYPE=$BUILD_TYPE ../kms-cmake-utils/
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	fi
	popd
}

build_glib()
{
	echo "--- 02 --- glib ---"
	pushd "glib"
	if [ $DOBUILD = TRUE ]; then
	./autogen.sh || true
	$MINGW-configure \
		--disable-directsound --disable-direct3d $CONFIGUREPARAMDEBUG \
		--disable-examples --disable-gtk-doc --disable-winscreencap \
		--disable-winks --disable-wasapi --disable-opencv
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	fi
	popd
}

build_kurento-module-creator()
{
	echo "--- 03 --- kurento-module-creator ---"
	mkdir -p "kurento-module-creator"
	pushd "kurento-module-creator"
	if [ $DOBUILD = TRUE ]; then
	make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo make install
	fi
	popd
}

build_gstreamer()
{
	echo "--- 04 --- gstreamer ---"
	pushd "gstreamer"
	if [ $DOBUILD = TRUE ]; then
	./autogen.sh || true ## Ignore configuration errors
	$MINGW-configure --disable-tools --disable-tests --disable-benchmarks --disable-examples \
					$CONFIGUREPARAMDEBUG --libexec=/usr/$MINGWPATH/sys-root/mingw/libexec
	make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo make install
	fi
	popd
}

build_gst-plugins-base()
{
	echo "--- 05 --- gst-plugins-base-1.5 ---"
	pushd "gst-plugins-base"
	if [ $DOBUILD = TRUE ]; then
	./autogen.sh || true ## Ignore configuration errors
	$MINGW-configure $CONFIGUREPARAMDEBUG
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	fi
	popd
}

build_jsoncpp()
{
	echo "--- 06 --- jsoncpp ---"
	mkdir -p "jsoncpp-build"
	pushd "jsoncpp-build"
	if [ $DOBUILD = TRUE ]; then
	$MINGW-cmake -DCMAKE_BUILD_TYPE=$BUILD_TYPE ../jsoncpp
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	fi
	popd
}

build_kms-jsonrpc()
{
	echo "--- 07 --- kms-jsonrpc ---"
	mkdir -p "kms-jsonrpc-build"
	pushd "kms-jsonrpc-build"
	if [ $DOBUILD = TRUE ]; then
	$MINGW-cmake -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
				  -DCMAKE_MODULE_PATH=$cmakemodules \
				  ../kms-jsonrpc
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	fi
	popd
}

build_libvpx()
{
	echo "--- 08 --- libvpx ---"
	pushd "libvpx"
	if [ $MINGW = mingw32 ]; then
		eval `rpm --eval %{mingw32_env}`
	else
		eval `rpm --eval %{mingw64_env}`
	fi
	if [ $DOBUILD = TRUE ]; then
	export AS=yasm
	if [ $MINGW = mingw32 ]; then
		#libvpx bug https://bugzilla.gnome.org/show_bug.cgi?id=763663 -mstackrealign
		./configure --target=x86-win32-gcc --prefix=/usr/$MINGWPATH/sys-root/mingw/ $DEBUGLIBVPX --extra-cflags=-mstackrealign
	else
		./configure --target=x86_64-win64-gcc --prefix=/usr/$MINGWPATH/sys-root/mingw/ $DEBUGLIBVPX
	fi
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	fi
	popd
}

build_kms-core()
{
	echo "--- 09 --- kms-core ---"
if [[ $EUID == 0 ]]; then
	echo "Build this step as root will lead to troubles later! (e.g. kurentocreator will not be found) Stop here now."
	exit
fi
	mkdir -p "kms-core-build"
	pushd "kms-core-build"
	if [ $DOBUILD = TRUE ]; then
	$MINGW-cmake -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
				  -DCMAKE_MODULE_PATH=$cmakemodules \
				  -DCMAKE_INSTALL_PREFIX=/usr/$MINGWPATH/sys-root/mingw \
				  -DKURENTO_MODULES_DIR=/usr/$MINGWPATH/sys-root/mingw/share/kurento/modules/ \
				  ../kms-core
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	fi
	popd
}

build_libevent()
{
	echo "--- 10 --- libevent ---"
	pushd "libevent"
	if [ $DOBUILD = TRUE ]; then
	./autogen.sh || true ## However, you should not build using configured Makefile
	$MINGW-configure $CONFIGUREPARAMDEBUG
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	fi
	popd
}

build_kurento-media-server()
{
	echo "--- 11 --- kurento-media-server ---"
	mkdir -p "kurento-media-server-build"
	pushd "kurento-media-server-build"
	if [ $DOBUILD = TRUE ]; then
#problem mit mingw -> too many sections (40348)... Fatal error: can't write 97 bytes to section .text of CMakeFiles/websocketTransport.dir/WebSocketTransport.cpp.obj because: 'File too big'
#nur bei 64 bit -> 32 bit ok
	if [ $MINGW = mingw64 ]; then
		$MINGW-cmake -DCMAKE_BUILD_TYPE=Release \
				  -DCMAKE_MODULE_PATH=$cmakemodules \
				  ../kurento-media-server
	else
	
		$MINGW-cmake -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
				  -DCMAKE_MODULE_PATH=$cmakemodules \
				  ../kurento-media-server
	fi
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	fi
	popd
}

build_usrsctp()
{
	echo "--- 12 --- usersctp ---"
	pushd "usrsctp"
	./bootstrap
	if [ $DOBUILD = TRUE ]; then
	$MINGW-configure $CONFIGUREPARAMDEBUG
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	fi
	popd
}

build_openwebrtc-gst-plugins()
{
	echo "--- 13 --- openwebrtc-gst-plugins ---"
	pushd "openwebrtc-gst-plugins"
	if [ $DOBUILD = TRUE ]; then
	./autogen.sh || true ## Ignore configuration errors
	$MINGW-configure $CONFIGUREPARAMDEBUG
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	sudo rm /usr/$MINGWPATH/sys-root/mingw/bin/libgstsctp-1.5.dll
	sudo ln -s -f /usr/$MINGWPATH/sys-root/mingw/lib/libgstsctp-1.5.dll \
		 /usr/$MINGWPATH/sys-root/mingw/bin/libgstsctp-1.5.dll
	fi
	popd
}

build_libnice()
{
	echo "--- 14 --- libnice ---"
	pushd "libnice"
	if [ $DOBUILD = TRUE ]; then
	./autogen.sh || true ## Ignore configuration errors
	$MINGW-configure $CONFIGUREPARAMDEBUG
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	fi
	popd
}

build_kms-elements()
{
	echo "--- 15 --- kms-elements ---"
	mkdir -p "kms-elements-build"
	pushd "kms-elements-build"
	if [ $DOBUILD = TRUE ]; then
	$MINGW-cmake -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
				  -DCMAKE_MODULE_PATH=$cmakemodules \
				  -DCMAKE_INSTALL_PREFIX=/usr/$MINGWPATH/sys-root/mingw \
				  -DKURENTO_MODULES_DIR=/usr/$MINGWPATH/sys-root/mingw/share/kurento/modules/ \
				  ../kms-elements
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	fi
	popd
}

build_opencv()
{
	echo "--- 16 --- opencv ---"
	mkdir -p "opencv-build"
	pushd "opencv-build"
	if [ $DOBUILD = TRUE ]; then
	$MINGW-cmake \
		-DCMAKE_BUILD_TYPE=$BUILD_TYPE \
		-DBUILD_PERF_TESTS=false \
		-DBUILD_TESTS=false \
		-DWITH_DSHOW=false \
		-DWITH_WIN32UI=false \
		-DWITH_OPENCL=false \
		-DWITH_VFW=false \
		-DBUILD_ZLIB=false \
		-DBUILD_TIFF=false \
		-DBUILD_JASPER=false \
		-DBUILD_JPEG=false \
		-DBUILD_PNG=false \
		-DBUILD_OPENEXR=false \
		-DWITH_FFMPEG=false \
		-DBUILD_opencv_flann=OFF \
		-DBUILD_opencv_photo=OFF \
		-DBUILD_opencv_video=OFF \
		-DBUILD_opencv_ml=OFF \
		../opencv
	sed -i 's/-isystem\ \/usr\/'$MINGWPATH'\/sys-root\/mingw\/include/ /g' \
		modules/core/CMakeFiles/opencv_core.dir/includes_CXX.rsp
	sed -i 's/-isystem\ \/usr\/'$MINGWPATH'\/sys-root\/mingw\/include\ / /g' \
		modules/highgui/CMakeFiles/opencv_highgui.dir/includes_CXX.rsp
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	sudo cp unix-install/opencv.pc /usr/$MINGWPATH/sys-root/mingw/lib/pkgconfig/
	sudo rm /usr/$MINGWPATH/sys-root/mingw/lib/libopencv_core.a
	sudo ln -s -f /usr/$MINGWPATH/sys-root/mingw/$MINGWX/mingw/lib/libopencv_core2413$DEBUGSUFFIX.dll.a \
		 /usr/$MINGWPATH/sys-root/mingw/lib/libopencv_core.a
	sudo rm /usr/$MINGWPATH/sys-root/mingw/lib/libopencv_highgui.a
	sudo ln -s -f /usr/$MINGWPATH/sys-root/mingw/$MINGWX/mingw/lib/libopencv_highgui2413$DEBUGSUFFIX.dll.a \
		 /usr/$MINGWPATH/sys-root/mingw/lib/libopencv_highgui.a
	sudo rm /usr/$MINGWPATH/sys-root/mingw/lib/libopencv_imgproc.a
	sudo ln -s -f /usr/$MINGWPATH/sys-root/mingw/$MINGWX/mingw/lib/libopencv_imgproc2413$DEBUGSUFFIX.dll.a \
		 /usr/$MINGWPATH/sys-root/mingw/lib/libopencv_imgproc.a
	sudo rm /usr/$MINGWPATH/sys-root/mingw/lib/libopencv_objdetect.a
	sudo ln -s -f /usr/$MINGWPATH/sys-root/mingw/$MINGWX/mingw/lib/libopencv_objdetect2413$DEBUGSUFFIX.dll.a \
		 /usr/$MINGWPATH/sys-root/mingw/lib/libopencv_objdetect.a
	sudo rm /usr/$MINGWPATH/sys-root/mingw/bin/libopencv_core2413.dll
	sudo rm /usr/$MINGWPATH/sys-root/mingw/bin/libopencv_highgui2413.dll
	sudo rm /usr/$MINGWPATH/sys-root/mingw/bin/libopencv_imgproc2413.dll
	sudo rm /usr/$MINGWPATH/sys-root/mingw/bin/libopencv_objdetect2413.dll
	sudo ln -s -f /usr/$MINGWPATH/sys-root/mingw/$MINGWX/mingw/bin/libopencv_core2413$DEBUGSUFFIX.dll \
		 /usr/$MINGWPATH/sys-root/mingw/bin/libopencv_core2413.dll
	sudo ln -s -f /usr/$MINGWPATH/sys-root/mingw/$MINGWX/mingw/bin/libopencv_highgui2413$DEBUGSUFFIX.dll \
		 /usr/$MINGWPATH/sys-root/mingw/bin/libopencv_highgui2413.dll
	sudo ln -s -f /usr/$MINGWPATH/sys-root/mingw/$MINGWX/mingw/bin/libopencv_imgproc2413$DEBUGSUFFIX.dll \
		 /usr/$MINGWPATH/sys-root/mingw/bin/libopencv_imgproc2413.dll
	sudo ln -s -f /usr/$MINGWPATH/sys-root/mingw/$MINGWX/mingw/bin/libopencv_objdetect2413$DEBUGSUFFIX.dll \
		 /usr/$MINGWPATH/sys-root/mingw/bin/libopencv_objdetect2413.dll
	fi
	popd
}

build_kms-filters()
{
	echo "--- 17 --- kms-filters ---"
	mkdir -p "kms-filters-build"
	pushd "kms-filters-build"
	if [ $DOBUILD = TRUE ]; then
	$MINGW-cmake -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
				  -DCMAKE_MODULE_PATH=$cmakemodules \
				  -DCMAKE_INSTALL_PREFIX=/usr/$MINGWPATH/sys-root/mingw \
				  -DKURENTO_MODULES_DIR=/usr/$MINGWPATH/sys-root/mingw/share/kurento/modules/ \
				  -DCMAKE_C_FLAGS="-Wno-error=deprecated-declarations" \
				  ../kms-filters
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	fi
	popd
}

build_gst-plugins-good()
{
	echo "--- 18 --- gst-plugins-good ---"
	pushd "gst-plugins-good"
	if [ $DOBUILD = TRUE ]; then
	./autogen.sh || true ## Ignore configuration errors
	$MINGW-configure \
		--disable-wavpack --disable-valgrind --disable-directsound \
		--disable-libcaca --disable-waveform \
		--libexec=/usr/$MINGWPATH/sys-root/mingw/libexec \
		$CONFIGUREPARAMDEBUG --disable-gtk-doc --disable-examples
	printf "all:\ninstall:\nclean:\nuninstall:\n" > tests/Makefile
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	fi
	popd
}

build_libsrtp()
{
	echo "--- 19 --- libsrtp ---"
	pushd "libsrtp"
	if [ $DOBUILD = TRUE ]; then
	$MINGW-configure $DEBUGLIBSRTP
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	fi
	popd
}

build_gst-plugins-bad()
{
	echo "--- 20 --- gst-plugins-bad ---"
	pushd "gst-plugins-bad"
	if [ $DOBUILD = TRUE ]; then
	./autogen.sh || true ## Ignore configuration errors
	$MINGW-configure \
		--disable-directsound --disable-direct3d $CONFIGUREPARAMDEBUG \
		--disable-examples --disable-gtk-doc --disable-winscreencap \
		--disable-winks --disable-wasapi --disable-opencv
	sed -i 's/\buint\b/unsigned/g' ext/opencv/gstmotioncells.cpp ## We may need this later
	printf "all:\ninstall:\nclean:\nuninstall:\n" > tests/Makefile
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	fi
	popd
}


build_gst-libav()
{
	echo "--- 21 --- gst-libav ---"
	pushd "gst-libav"
	if [ $DOBUILD = TRUE ]; then
	./autogen.sh || true ## Ignore configuration errors
	$MINGW-configure $CONFIGUREPARAMDEBUG
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	fi
	popd
}

build_gst-plugins-ugly()
{
	echo "--- 22 --- gst-plugins-ugly ---"
	pushd "gst-plugins-ugly"
	if [ $DOBUILD = TRUE ]; then
	./autogen.sh || true ## Ignore configuration errors
	$MINGW-configure \
		--libexec=/usr/$MINGWPATH/sys-root/mingw/libexec \
		$CONFIGUREPARAMDEBUG --disable-gtk-doc --disable-examples
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	fi
	popd
}

build_openssl()
{
	echo "--- 23 --- openssl ---"
	pushd "openssl"
	unset CC
	if [ $DOBUILD = TRUE ]; then
	#./Configure shared --cross-compile-prefix=$MINGWPATH- $DEBUGOPENSSL $MINGWP1
	./Configure shared no-sse2 --cross-compile-prefix=$MINGWPATH- $DEBUGOPENSSL $MINGWP1
	#./Configure shared 386 --cross-compile-prefix=$MINGWPATH- $DEBUGOPENSSL $MINGWP1
	$MINGW-make depend
	$MINGW-make
	if [ $MINGW = mingw64 ]; then
		cp libeay32.dll libcrypto-10-no-sse.dll
		#cp libcrypto-3-x64.dll libcrypto-10.dll
		#cp libssl-3-x64.dll libssl-10.dll
	else
		cp libeay32.dll libcrypto-10-no-sse.dll
		#cp ssleay32.dll libssl-10.dll
	fi
	fi
	#if [ $DOINSTALL = TRUE ]; then
	#sudo $MINGW-make install
	#fi
	popd
}

build_bcg729()
{
	echo "--- 24 --- bcg729 ---"
	mkdir -p "bcg729-build"
	pushd "bcg729-build"
	if [ $DOBUILD = TRUE ]; then
	$MINGW-cmake -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
				  -DCMAKE_MODULE_PATH=$cmakemodules \
				  -DCMAKE_INSTALL_PREFIX=/usr/$MINGWPATH/sys-root/mingw \
				  -DENABLE_TESTS=YES \
				  ../bcg729
	#set
	$MINGW-make
	fi
	#if [ $DOINSTALL = TRUE ]; then
	#sudo $MINGW-make install
	#fi
	popd	
}

# array of repo URL's and related tags
repos ()
{
    cat <<EOF
https://github.com/ESTOS/kms-cmake-utils.git              d408e638eaabffdb09c508813706abcd52c88cbf
https://github.com/ESTOS/kurento-module-creator.git       422d3f3f91cd875af93713c1f71037cb6e9e0d85
https://github.com/ESTOS/gstreamer.git                    28c20b94242ddc014d098fd2124c7fd71f0ae1fd
https://github.com/ESTOS/gst-plugins-base.git             0a2d80755aef80670b9ab8fc66b3dd7ae1e68597
https://github.com/ESTOS/jsoncpp.git                      79efbfde69a285caca20b494a0f94b0528847088
https://github.com/ESTOS/kms-jsonrpc.git                  ae5ae3184a41a293eb91e8c8a329dbc12b980411
https://github.com/ESTOS/libvpx.git                       a90944ce794986d8c0daab1449903909ba1956a7
https://github.com/ESTOS/kms-core.git                     fe702d1c2b9ec8d67e1ceae132eb1e61fa5661b5
https://github.com/ESTOS/libevent.git                     ba78ba9e8ba4c964dd5d14a281d7421c95d37937
https://github.com/ESTOS/kurento-media-server.git         d9e73c6f5b940dc10c9f99202fc666fe8fd05256
https://github.com/ESTOS/usrsctp.git                      ee2c72bc0cd58de72f662902826e7661794f5e6e
https://github.com/ESTOS/openwebrtc-gst-plugins.git       079ccd07956a33c8c5bcca1c1a39cc19b8167370
https://github.com/ESTOS/libnice.git                      dfc34d514efbfa2c9dab6d595c6e2c0f4e92331e
https://github.com/ESTOS/kms-elements.git                 47116211f5b21e50656f53af7e66dfc27f51d1ad
https://github.com/ESTOS/opencv.git                       d68e3502278d6fc5a1de0ce8f7951d9961b20913
https://github.com/ESTOS/kms-filters.git                  9a593d16e0899708101e8e8c1c66df2d7fe1a1cb
https://github.com/ESTOS/gst-plugins-good.git             1cc9f64bd2763c5580fd2d34a3568cf22b1b5c8d
https://github.com/ESTOS/libsrtp.git                      5ec1baa78cd35b88bfbb2b0600a0f8262f3cf20b
https://github.com/ESTOS/gst-plugins-bad.git              ce2dcb310f2fb80fabf0024052f3a56c9ac42f53
https://github.com/ESTOS/glib.git                         b92bcfb3685a9999a8fad4cd7a2d6c10a133d859
https://github.com/ESTOS/openssl.git                      12ad22dd16ffe47f8cde3cddb84a160e8cdb3e30
https://github.com/ESTOS/gst-libav.git                    c8b5c6f9131a9952ef6db0674a9941b10a3e2613
https://github.com/ESTOS/gst-plugins-ugly.git             2685b0f252bf0ed6aa27a5c69e82e05289346ff1
https://github.com/ESTOS/bcg729.git                       faaa895862165acde6df8add722ba4f85a25007d
EOF
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
}

build()
{
set -e #stop on error
set -x #print all executed command
	build_kms-cmake-utils
	getcmakemodules
	build_glib
	build_kurento-module-creator
	build_gstreamer
	build_gst-plugins-base
	build_jsoncpp
	build_kms-jsonrpc
	build_libvpx
	build_kms-core
	build_libevent
	build_kurento-media-server
	build_usrsctp
	build_openwebrtc-gst-plugins
	build_libnice
	build_kms-elements
	build_opencv
	build_kms-filters
	build_gst-plugins-good
	build_libsrtp
	build_gst-plugins-bad
	build_gst-libav
	#build_gst-plugins-ugly
	build_openssl
	#build_bcg729
}

case "$1" in
	setup)
		setup_workspace
		;;
	buildonlyinstall)
		DOINSTALL=TRUE
		DOBUILD=FALSE
		build
		;;
	buildnoinstall)
		DOINSTALL=FALSE
		DOBUILD=TRUE
		build
		;;
	build)
		build
		;;
	buildlog)
		build > logbuildmain.txt 2>&1
		;;
	buildalllog)
		setup_workspace > logbuildmain.txt 2>&1
		build >> logbuildmain.txt 2>&1
		;;
	build_*)
		build_kms-cmake-utils
		getcmakemodules
		set -x #print all executed command
		$1
		;;
	all)
		build
		;;
	*)
		build_kms-cmake-utils > /dev/null 2>&1
		getcmakemodules > /dev/null 2>&1
		echo ""
		echo "Usage:"
		echo "  setup            -> clones all components"
		echo "  buildonlyinstall -> install without build"
		echo "  buildnoinstall   -> build without install"
		echo "  build            -> build"
		echo "  buildlog         -> build + log to logbuildmain.txt"
		echo "  buildalllog      -> setup + build + log to logbuildmain.txt"
		echo "  build_*          -> build selected component"
		echo "  all              -> build"
		echo "Environment:"
		echo "  CMAKEPATH     $cmakemodules"
		echo ""
		;;
esac
