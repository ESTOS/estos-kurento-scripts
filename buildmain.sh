#!/bin/bash
# build script for kurento for windows

#stop on error
set -e
#print all executed command
set -x

DOINSTALL=TRUE
DOBUILD=TRUE
MINGW=mingw32
#MINGW=mingw64
BUILDTYPE=RELEASE
#BUILDTYPE=DEBUG

if [ $MINGW = mingw32 ]; then
MINGWPATH=i686-w64-mingw32
MINGWX=x86
else
MINGWPATH=x86_64-w64-mingw32
MINGWX=x64
fi

if [ $BUILDTYPE = RELEASE ]; then
BUILD_TYPE=Release
CONFIGUREPARAMDEBUG=--disable-debug
DEBUGSUFFIX=
DEBUGOPENSSL=
else
BUILD_TYPE=Debug
CONFIGUREPARAMDEBUG=--enable-debug
DEBUGSUFFIX=d
DEBUGOPENSSL=--debug
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
	echo "3.1 kms-cmake-utils"
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

build_kurento-module-creator()
{
	echo "3.2 kurento-module-creator"
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
	echo "3.3 gstreamer"
	pushd "gstreamer"
	if [ $DOBUILD = TRUE ]; then
	./autogen.sh || true ## Ignore configuration errors
	mingw32-configure --disable-tools --disable-tests --disable-benchmarks --disable-examples \
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
	echo "3.4 gst-plugins-base-1.5"
	pushd "gst-plugins-base"
	if [ $DOBUILD = TRUE ]; then
	./autogen.sh || true ## Ignore configuration errors
	mingw32-configure $CONFIGUREPARAMDEBUG
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	fi
	popd
}

build_jsoncpp()
{
	echo "3.5 jsoncpp"
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
	echo "3.6 kms-jsonrpc"
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
	echo "3.7 libvpx"
	pushd "libvpx"
	if [ $MINGW = mingw32 ]; then
		eval `rpm --eval %{mingw32_env}`
	else
		eval `rpm --eval %{mingw64_env}`
	fi
	if [ $DOBUILD = TRUE ]; then
	export AS=yasm
	if [ $MINGW = mingw32 ]; then
		./configure --target=x86-win32-gcc --prefix=/usr/$MINGWPATH/sys-root/mingw/
	else
		./configure --target=x86_64-win64-gcc --prefix=/usr/$MINGWPATH/sys-root/mingw/
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
	echo "3.8 kms-core"
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
	echo "3.9 libevent"
	pushd "libevent"
	if [ $DOBUILD = TRUE ]; then
	./autogen.sh || true ## However, you should not build using configured Makefile
	mingw32-configure $CONFIGUREPARAMDEBUG
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	fi
	popd
}

build_kurento-media-server()
{
	echo "3.10 kurento-media-server"
	mkdir -p "kurento-media-server-build"
	pushd "kurento-media-server-build"
	if [ $DOBUILD = TRUE ]; then
	$MINGW-cmake -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
				  -DCMAKE_MODULE_PATH=$cmakemodules \
				  ../kurento-media-server
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	fi
	popd
}

build_usrsctp()
{
	echo "3.11 usersctp"
	pushd "usrsctp"
	./bootstrap
	if [ $DOBUILD = TRUE ]; then
	mingw32-configure $CONFIGUREPARAMDEBUG
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	fi
	popd
}

build_openwebrtc-gst-plugins()
{
	echo "3.12 openwebrtc-gst-plugins"
	pushd "openwebrtc-gst-plugins"
	if [ $DOBUILD = TRUE ]; then
	./autogen.sh || true ## Ignore configuration errors
	mingw32-configure $CONFIGUREPARAMDEBUG
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
	echo "3.13 libnice"
	pushd "libnice"
	if [ $DOBUILD = TRUE ]; then
	./autogen.sh || true ## Ignore configuration errors
	mingw32-configure $CONFIGUREPARAMDEBUG
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	fi
	popd
}

build_kms-elements()
{
	echo "3.14 kms-elements"
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
	echo "3.15 opencv"
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
	echo "3.16 kms-filters"
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
	echo "3.17 gst-plugins-good"
	pushd "gst-plugins-good"
	if [ $DOBUILD = TRUE ]; then
	./autogen.sh || true ## Ignore configuration errors
	mingw32-configure \
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
	echo "3.18 libsrtp"
	pushd "libsrtp"
	if [ $DOBUILD = TRUE ]; then
	mingw32-configure $CONFIGUREPARAMDEBUG
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	fi
	popd
}

build_gst-plugins-bad()
{
	echo "3.19 gst-plugins-bad"
	pushd "gst-plugins-bad"
	if [ $DOBUILD = TRUE ]; then
	./autogen.sh || true ## Ignore configuration errors
	mingw32-configure \
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

build_glib()
{
	echo "3.20 glib"
	pushd "glib"
	if [ $DOBUILD = TRUE ]; then
	./autogen.sh || true
	mingw32-configure \
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

build_gst-libav()
{
	echo "3.21 gst-libav"
	pushd "gst-libav"
	if [ $DOBUILD = TRUE ]; then
	./autogen.sh || true ## Ignore configuration errors
	mingw32-configure $CONFIGUREPARAMDEBUG
	$MINGW-make
	fi
	if [ $DOINSTALL = TRUE ]; then
	sudo $MINGW-make install
	fi
	popd
}

build_gst-plugins-ugly()
{
	pushd "gst-plugins-ugly"
	if [ $DOBUILD = TRUE ]; then
	./autogen.sh || true ## Ignore configuration errors
	mingw32-configure \
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
	echo "3.22 openssl"
	pushd "openssl"
	if [ $DOBUILD = TRUE ]; then
	./Configure shared --cross-compile-prefix=$MINGWPATH- $DEBUGOPENSSL mingw
	$MINGW-make depend
	$MINGW-make
	cp libeay32.dll libcrypto-10.dll
	cp ssleay32.dll libssl-10.dll
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
https://github.com/ESTOS/gstreamer.git                    c5dd87a593feac9244152c83b7632043d461625f
https://github.com/ESTOS/gst-plugins-base.git             7bf50f79f694dda7676db8364d7c50bb2fef1c2b
https://github.com/ESTOS/jsoncpp.git                      79efbfde69a285caca20b494a0f94b0528847088
https://github.com/ESTOS/kms-jsonrpc.git                  ae5ae3184a41a293eb91e8c8a329dbc12b980411
https://github.com/ESTOS/libvpx.git                       a90944ce794986d8c0daab1449903909ba1956a7
https://github.com/ESTOS/kms-core.git                     2293119b92999337d0b42ab22b52a92d4dece306
https://github.com/ESTOS/libevent.git                     ba78ba9e8ba4c964dd5d14a281d7421c95d37937
https://github.com/ESTOS/kurento-media-server.git         4070af6023d4a0d97afa8231d35da027b91650a2
https://github.com/ESTOS/usrsctp.git                      6a7541145d3b802c632c9e164eecae58e7780f36
https://github.com/ESTOS/openwebrtc-gst-plugins.git       079ccd07956a33c8c5bcca1c1a39cc19b8167370
https://github.com/ESTOS/libnice.git                      269d2ea5ebfc80addf5f3fdac446eef46f6fd4be
https://github.com/ESTOS/kms-elements.git                 81a45062d30f95c772a78f90e9200dd9df8428f3
https://github.com/ESTOS/opencv.git                       d68e3502278d6fc5a1de0ce8f7951d9961b20913
https://github.com/ESTOS/kms-filters.git                  9a593d16e0899708101e8e8c1c66df2d7fe1a1cb
https://github.com/ESTOS/gst-plugins-good.git             aea740fdba5bb450ac191bdf3210bb2f3793b521
https://github.com/ESTOS/libsrtp.git                      5ec1baa78cd35b88bfbb2b0600a0f8262f3cf20b
https://github.com/ESTOS/gst-plugins-bad.git              015bcfb2b0cf03404b95131d3be18dbd8bb4c0b5
https://github.com/ESTOS/glib.git                         acee2a89397f8c91145bbeb174723026f931cae4
https://github.com/ESTOS/gst-libav.git                    493eee49c7171e7fc0bf0110e30d445ba573dc5e
https://github.com/ESTOS/gst-plugins-ugly.git             2685b0f252bf0ed6aa27a5c69e82e05289346ff1
EOF
}

setup_workspace()
{
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
	build_kms-cmake-utils
	getcmakemodules
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
	build_glib
	#build_gst-libav
	#build_gst-plugins-ugly
	#build_openssl
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
	build_*)
		build_kms-cmake-utils
		getcmakemodules
		$1
		;;
	all)
		build
		;;
	*)
		build_kms-cmake-utils
		getcmakemodules
		echo ""
		echo "Usage:"
		echo "setup -> clones all components"
		echo "buildnoinstall -> without install"
		echo "buildonlyinstall -> install without build"
		echo "Environment:"
		echo " CMAKEPATH     $cmakemodules"
		echo ""
		;;
esac
