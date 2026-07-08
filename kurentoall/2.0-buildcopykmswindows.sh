#! /bin/sh
set -e #stop on error
set -x #print all executed command

BUILDTYPE=RELEASE
#BUILDTYPE=DEBUG

if [ -d /c/lwx/dev ]; then
ROOT_DIRECTORY=/c/lwx/dev/estos-kurento-scripts/kurentoall
else
ROOT_DIRECTORY=/x/dev/estos-kurento-scripts/kurentoall
fi
TARGET_DIRECTORY=$ROOT_DIRECTORY/kmswindows
MINGW64_DIR=/mingw64
MINGW64_BIN_DIR=$MINGW64_DIR/bin
MINGW64_LIB_GSTREAMER_DIR=$MINGW64_DIR/lib/gstreamer-1.0

if [ $BUILDTYPE = RELEASE ]; then
BUILDPATH=build-RelWithDebInfo
BUILDPATHOPENCV=opencv-build-Release
else
BUILDPATH=build-Debug
BUILDPATHOPENCV=opencv-build-Debug
fi


cp_if_exists()
{
	src=$1
	dest=$2
	if [ -f "$src" ]; then
		cp -f "$src" -t "$dest"
	else
		echo "WARNING: missing $src" >&2
	fi
}

cp_mingw_bin()
{
	cp_if_exists "$MINGW64_BIN_DIR/$1" "$TARGET_DIRECTORY/bin"
}

cp_gst_plugin()
{
	cp_if_exists "$MINGW64_LIB_GSTREAMER_DIR/$1" "$TARGET_DIRECTORY/lib/gstreamer-1.0"
}

copy_kurento_build_dll()
{
	f=$(find "$ROOT_DIRECTORY/kurento/server/$BUILDPATH" -name "$1" -print -quit 2>/dev/null || true)
	if [ -n "$f" ]; then
		cp -f "$f" -t "$TARGET_DIRECTORY/bin/"
	else
		echo "WARNING: Kurento build DLL not found: $1" >&2
	fi
}

# Remove runtime DLLs from a previous deploy (exe and etc/ are kept).
clean_kmswindows_runtime_dlls()
{
	if [ -d "$TARGET_DIRECTORY/bin" ]; then
		find "$TARGET_DIRECTORY/bin" -maxdepth 1 -name '*.dll' -delete
	fi
	if [ -d "$TARGET_DIRECTORY/lib/kurento/modules" ]; then
		find "$TARGET_DIRECTORY/lib/kurento/modules" -maxdepth 1 -name '*.dll' -delete
	fi
	if [ -d "$TARGET_DIRECTORY/lib/gstreamer-1.0/kurento" ]; then
		find "$TARGET_DIRECTORY/lib/gstreamer-1.0/kurento" -maxdepth 1 -name '*.dll' -delete
	fi
	if [ -d "$TARGET_DIRECTORY/lib/gstreamer-1.0" ]; then
		find "$TARGET_DIRECTORY/lib/gstreamer-1.0" -maxdepth 1 -name '*.dll' -delete
	fi
}

# GStreamer MODULE plugins only (not shared libs in bin/).
# OpenCV filter plugins are not installed here — see minimal-opencv.
install_kurento_gst_plugins()
{
KURENTO_GST_PLUGINS=$TARGET_DIRECTORY/lib/gstreamer-1.0/kurento
mkdir -p $KURENTO_GST_PLUGINS
for plugin in \
	libwebrtcendpoint.dll \
	librtpendpoint.dll \
	librtcpdemux.dll \
	libkmscore.dll \
	libkmselements.dll \
	libkmsrecorderendpoint.dll
do
	if [ -f $TARGET_DIRECTORY/bin/$plugin ]; then
		mv -f $TARGET_DIRECTORY/bin/$plugin $KURENTO_GST_PLUGINS/
	fi
done
}

# OpenCV filter MODULE plugins into lib/gstreamer-1.0/kurento/ (minimal-opencv only).
install_opencv_filter_gst_plugins()
{
KURENTO_GST_PLUGINS=$TARGET_DIRECTORY/lib/gstreamer-1.0/kurento
mkdir -p $KURENTO_GST_PLUGINS
for plugin in \
	libkmsfacedetector.dll \
	libkmsimageoverlay.dll \
	libkmslogooverlay.dll \
	libkmsmovementdetector.dll \
	libkmsopencvfilter.dll
do
	if [ -f $TARGET_DIRECTORY/bin/$plugin ]; then
		mv -f $TARGET_DIRECTORY/bin/$plugin $KURENTO_GST_PLUGINS/
	fi
done
}

copy_opencv_runtime_dlls()
{
for dir in \
	"$MINGW64_BIN_DIR" \
	"$MINGW64_DIR/x64/mingw/bin" \
	"$ROOT_DIRECTORY/$BUILDPATHOPENCV/install/bin" \
	"$ROOT_DIRECTORY/$BUILDPATHOPENCV/install/x64/mingw/bin" \
	"$ROOT_DIRECTORY/$BUILDPATHOPENCV/x64/mingw/bin"
do
	if [ ! -d "$dir" ]; then
		continue
	fi
	for f in "$dir"/libopencv*.dll; do
		if [ -f "$f" ]; then
			cp -f "$f" -t "$TARGET_DIRECTORY/bin/"
		fi
	done
done
find "$ROOT_DIRECTORY/$BUILDPATHOPENCV" -name "libopencv*.dll" 2>/dev/null \
	| while read -r f; do
	cp -f "$f" -t "$TARGET_DIRECTORY/bin/"
done
}

_resolve_mingw_dll()
{
_name=$1
for _dir in "$MINGW64_BIN_DIR" "$MINGW64_DIR/x64/mingw/bin"; do
	if [ -f "$_dir/$_name" ]; then
		echo "$_dir/$_name"
		return 0
	fi
done
return 1
}

_skip_pe_dependency()
{
	case "$(echo "$1" | tr '[:upper:]' '[:lower:]')" in
	kernel32.dll|ntdll.dll|msvcrt.dll|msvcrt\ *|api-ms-*.dll|\
	libgcc_s_seh-1.dll|libwinpthread-1.dll|libstdc++-6.dll)
		return 0
		;;
	esac
	return 1
}

# Copy transitive PE dependencies of deployed DLLs into kmswindows/bin (from MSYS2).
sync_mingw_dll_deps()
{
	_objdump=$MINGW64_BIN_DIR/objdump.exe
	if [ ! -x "$_objdump" ]; then
		echo "WARNING: objdump not found, skipping sync_mingw_dll_deps" >&2
		return 0
	fi

	_sync_one()
	{
		_dll=$1
		_depth=$2
		if [ ! -f "$_dll" ] || [ "$_depth" -gt 5 ]; then
			return 0
		fi
		_deps=$("$_objdump" -p "$_dll" 2>/dev/null | sed -n 's/^[[:space:]]*DLL Name:[[:space:]]*//p' | tr -d '\r')
		for _dep in $_deps; do
			if _skip_pe_dependency "$_dep"; then
				continue
			fi
			if [ -f "$TARGET_DIRECTORY/bin/$_dep" ]; then
				continue
			fi
			_src=$(_resolve_mingw_dll "$_dep")
			if [ -n "$_src" ]; then
				cp -f "$_src" -t "$TARGET_DIRECTORY/bin/"
				_sync_one "$TARGET_DIRECTORY/bin/$_dep" $(($_depth + 1))
			fi
		done
	}

	for _dll in "$TARGET_DIRECTORY/lib/gstreamer-1.0"/*.dll \
		"$TARGET_DIRECTORY/lib/gstreamer-1.0/kurento"/*.dll \
		"$TARGET_DIRECTORY/bin"/libkms*.dll \
		"$TARGET_DIRECTORY/bin"/libkmsgstcommons.dll \
		"$TARGET_DIRECTORY/bin"/libkmssdpagent.dll \
		"$TARGET_DIRECTORY/bin"/libjsonrpc.dll
	do
		if [ -f "$_dll" ]; then
			_sync_one "$_dll" 0
		fi
	done
}

copy_minimal_extra_bin_dlls()
{
for dll in libogg-0.dll
do
	cp_mingw_bin "$dll"
done
}

copy_minimal_opencv_extra_bin_dlls()
{
for dll in \
	libtiff-6.dll \
	libopenjp2-7.dll \
	libdeflate.dll \
	libLerc.dll \
	libjbig-0.dll \
	liblz4.dll \
	libwebp-7.dll \
	libsharpyuv-0.dll \
	libzimg-2.dll \
	libcairo-2.dll \
	libcairo-gobject-2.dll \
	libfontconfig-1.dll \
	libfreetype-6.dll \
	libgraphite2.dll \
	libharfbuzz-0.dll \
	libpixman-1-0.dll
do
	cp_mingw_bin "$dll"
done
for _dir in "$MINGW64_BIN_DIR" "$MINGW64_DIR/x64/mingw/bin"; do
	for f in "$_dir"/libtbb*.dll "$_dir"/libtbbmalloc*.dll; do
		if [ -f "$f" ]; then
			cp -f "$f" -t "$TARGET_DIRECTORY/bin/"
		fi
	done
done
}

copy_opencv_beside_kurento_plugins()
{
if [ ! -d "$TARGET_DIRECTORY/lib/gstreamer-1.0/kurento" ]; then
	return 0
fi
for f in "$TARGET_DIRECTORY/bin"/libopencv*.dll; do
	if [ -f "$f" ]; then
		cp -f "$f" -t "$TARGET_DIRECTORY/lib/gstreamer-1.0/kurento/"
	fi
done
}

sync_minimal_runtime_deps()
{
copy_minimal_extra_bin_dlls
sync_mingw_dll_deps
}

sync_minimal_opencv_runtime_deps()
{
copy_opencv_runtime_dlls
copy_minimal_opencv_extra_bin_dlls
sync_mingw_dll_deps
copy_opencv_beside_kurento_plugins
}

# --- minimal deploy ---

copy_kurento_files_minimal()
{
if [ ! -d $TARGET_DIRECTORY/bin ]; then
	mkdir -p $TARGET_DIRECTORY/bin
fi
for dll in \
	libjsonrpc.dll \
	libkmscoreimpl.dll \
	libkmselementsimpl.dll \
	libkmsfiltersimpl.dll \
	libkmsgstcommons.dll \
	libkmssdpagent.dll \
	libkmswebrtcendpoint.dll \
	libkmsrtpendpointlib.dll \
	libwebrtcdataproto.dll \
	libkmscore.dll \
	libkmselements.dll \
	libwebrtcendpoint.dll \
	librtpendpoint.dll \
	librtcpdemux.dll \
	libkmsrecorderendpoint.dll
do
	copy_kurento_build_dll "$dll"
done
cp $ROOT_DIRECTORY/kurento/server/$BUILDPATH/media-server/server/kurento-media-server.exe $TARGET_DIRECTORY/bin/uc-media-server.exe

if [ ! -d $TARGET_DIRECTORY/lib/kurento/modules ]; then
	mkdir -p $TARGET_DIRECTORY/lib/kurento/modules
fi
for dll in libkmscoremodule.dll libkmselementsmodule.dll libkmsfiltersmodule.dll
do
	copy_kurento_build_dll "$dll"
	if [ -f $TARGET_DIRECTORY/bin/$dll ]; then
		mv -f $TARGET_DIRECTORY/bin/$dll $TARGET_DIRECTORY/lib/kurento/modules/
	fi
done

install_kurento_gst_plugins
}

copy_opencv_filter_plugins()
{
for dll in \
	libkmsfacedetector.dll \
	libkmsimageoverlay.dll \
	libkmslogooverlay.dll \
	libkmsmovementdetector.dll \
	libkmsopencvfilter.dll
do
	copy_kurento_build_dll "$dll"
done
install_opencv_filter_gst_plugins
}

copy_bin_files_minimal()
{
if [ ! -d $TARGET_DIRECTORY/bin ]; then
	mkdir -p $TARGET_DIRECTORY/bin
fi
for dll in \
	libboost_atomic-mt.dll \
	libboost_filesystem-mt.dll \
	libboost_log-mt.dll \
	libboost_program_options-mt.dll \
	libboost_thread-mt.dll \
	libbrotlicommon.dll \
	libbrotlidec.dll \
	libbz2-1.dll \
	libcrypto-3-x64.dll \
	libcurl-4.dll \
	libexpat-1.dll \
	libffi-8.dll \
	libgcc_s_seh-1.dll \
	libgio-2.0-0.dll \
	libglib-2.0-0.dll \
	libglibmm-2.4-1.dll \
	libgmodule-2.0-0.dll \
	libgobject-2.0-0.dll \
	libgstadaptivedemux-1.0-0.dll \
	libgstallocators-1.0-0.dll \
	libgstapp-1.0-0.dll \
	libgstaudio-1.0-0.dll \
	libgstbadaudio-1.0-0.dll \
	libgstbase-1.0-0.dll \
	libgstcodecparsers-1.0-0.dll \
	libgstcontroller-1.0-0.dll \
	libgstfft-1.0-0.dll \
	libgstinsertbin-1.0-0.dll \
	libgstisoff-1.0-0.dll \
	libgstmpegts-1.0-0.dll \
	libgstnet-1.0-0.dll \
	libgstpbutils-1.0-0.dll \
	libgstreamer-1.0-0.dll \
	libgstrtp-1.0-0.dll \
	libgstrtsp-1.0-0.dll \
	libgstsctp-1.0-0.dll \
	libgstsdp-1.0-0.dll \
	libgsttag-1.0-0.dll \
	libgsturidownloader-1.0-0.dll \
	libgstvideo-1.0-0.dll \
	libgstwebrtc-1.0-0.dll \
	libgthread-2.0-0.dll \
	libiconv-2.dll \
	libidn2-0.dll \
	libintl-8.dll \
	libjpeg-8.3.2.dll \
	libjson-glib-1.0-0.dll \
	libjsoncpp-26.dll \
	liblzma-5.dll \
	libnettle-8.dll \
	libnghttp2-14.dll \
	libnghttp3-9.dll \
	libngtcp2-16.dll \
	libngtcp2_crypto_ossl-0.dll \
	libnice-10.dll \
	libopenh264-7.dll \
	libopus-0.dll \
	liborc-0.4-0.dll \
	libpcre2-8-0.dll \
	libpng16-16.dll \
	libpsl-5.dll \
	libsigc-2.0-0.dll \
	libsoup-3.0-0.dll \
	libsqlite3-0.dll \
	libssh2-1.dll \
	libssl-3-x64.dll \
	libstdc++-6.dll \
	libsrtp2-1.dll \
	libunistring-5.dll \
	libwinpthread-1.dll \
	libxml2-16.dll \
	libzstd.dll \
	zlib1.dll
do
	cp_mingw_bin "$dll"
done
}

copy_gstreamer_files_minimal()
{
if [ ! -d $TARGET_DIRECTORY/lib/gstreamer-1.0 ]; then
	mkdir -p $TARGET_DIRECTORY/lib/gstreamer-1.0
fi
for plugin in \
	libgstapp.dll \
	libgstalaw.dll \
	libgstaudioconvert.dll \
	libgstaudiomixer.dll \
	libgstaudioparsers.dll \
	libgstaudiorate.dll \
	libgstaudioresample.dll \
	libgstaudiotestsrc.dll \
	libgstavi.dll \
	libgstcompositor.dll \
	libgstcoreelements.dll \
	libgstdtls.dll \
	libgstdtmf.dll \
	libgstflv.dll \
	libgsthls.dll \
	libgsticydemux.dll \
	libgstid3demux.dll \
	libgstisomp4.dll \
	libgstjpeg.dll \
	libgstlibav.dll \
	libgstmatroska.dll \
	libgstmulaw.dll \
	libgstnice.dll \
	libgstopenh264.dll \
	libgstopus.dll \
	libgstopusparse.dll \
	libgstplayback.dll \
	libgstpng.dll \
	libgstrtp.dll \
	libgstrtpmanager.dll \
	libgstrtpmanagerbad.dll \
	libgstrtmp2.dll \
	libgstsctp.dll \
	libgstsdpelem.dll \
	libgstsoup.dll \
	libgstsrtp.dll \
	libgsttypefindfunctions.dll \
	libgstudp.dll \
	libgstvideobox.dll \
	libgstvideoconvertscale.dll \
	libgstvideoparsersbad.dll \
	libgstvideorate.dll \
	libgstvolume.dll \
	libgstwavparse.dll
do
	cp_gst_plugin "$plugin"
done
}

copy_gstreamer_files_minimal_opencv()
{
cp_gst_plugin libgstcairo.dll
}

copy_minimal()
{
clean_kmswindows_runtime_dlls
copy_kurento_files_minimal
copy_bin_files_minimal
copy_gstreamer_files_minimal
sync_minimal_runtime_deps
}

copy_minimal_opencv()
{
copy_opencv_filter_plugins
copy_gstreamer_files_minimal_opencv
sync_minimal_opencv_runtime_deps
}

case "$1" in
	minimal)
		set -x #print all executed command
		copy_minimal
		;;
	minimal-opencv)
		set -x #print all executed command
		copy_minimal
		copy_minimal_opencv
		;;
	*)
set +x
		echo ""
		echo "Usage:"
		echo "  minimal          -> deploy kmswindows (core + filters module, no OpenCV plugins)"
		echo "  minimal-opencv   -> minimal + OpenCV filter GST plugins and runtime"
		echo ""
		;;
esac
