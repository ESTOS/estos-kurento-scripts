#! /bin/sh
set -e #stop on error
#set -x #print all executed command
if [ -d /c/lwx/dev ]; then
ROOT_DIRECTORY=/c/lwx/dev/estos-kurento-scripts/kurentoall
else
ROOT_DIRECTORY=/x/dev/estos-kurento-scripts/kurentoall
fi
TARGET_DIRECTORY=$ROOT_DIRECTORY/kmswindows
MINGW64_DIR=/mingw64
MINGW64_BIN_DIR=$MINGW64_DIR/bin
MINGW64_LIB_GSTREAMER_DIR=$MINGW64_DIR/lib/gstreamer-1.0

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
	f=$(find "$ROOT_DIRECTORY/kurento/server/build-Debug" -name "$1" -print -quit 2>/dev/null || true)
	if [ -n "$f" ]; then
		cp -f "$f" -t "$TARGET_DIRECTORY/bin/"
	else
		echo "WARNING: Kurento build DLL not found: $1" >&2
	fi
}

# Remove runtime DLLs from a previous "all" deploy (exe and etc/ are kept).
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

copy_kurento_files()
{
if [ ! -d $TARGET_DIRECTORY/bin ]; then
	mkdir -p $TARGET_DIRECTORY/bin
fi
find $ROOT_DIRECTORY/kurento/server/build-Debug -name "*.dll" | xargs cp -t $TARGET_DIRECTORY/bin/
cp $ROOT_DIRECTORY/kurento/server/build-Debug/media-server/server/kurento-media-server.exe $TARGET_DIRECTORY/bin/uc-media-server.exe

# kmswindows\lib\kurento\modules
if [ ! -d $TARGET_DIRECTORY/lib/kurento/modules ]; then
	mkdir -p $TARGET_DIRECTORY/lib/kurento/modules
fi	
mv $TARGET_DIRECTORY/bin/libkmscoremodule.dll $TARGET_DIRECTORY/lib/kurento/modules
mv $TARGET_DIRECTORY/bin/libkmselementsmodule.dll $TARGET_DIRECTORY/lib/kurento/modules
mv $TARGET_DIRECTORY/bin/libkmsfiltersmodule.dll $TARGET_DIRECTORY/lib/kurento/modules

install_kurento_gst_plugins

if [ 1 == 2 ]; then
# kurentoall\kmswindows\bin
libjsonrpc.dll
libkmscore.dll
libkmscoreimpl.dll
libkmselements.dll
libkmselementsimpl.dll
libkmsfacedetector.dll
libkmsfaceoverlay.dll
libkmsfiltersimpl.dll
libkmsgstcommons.dll
libkmsimageoverlay.dll
libkmslogooverlay.dll
libkmsmovementdetector.dll
libkmsopencvfilter.dll
libkmsrecorderendpoint.dll
libkmsrtpendpointlib.dll
libkmssdpagent.dll
libkmswebrtcendpoint.dll
librtcpdemux.dll
librtpendpoint.dll
libvp8parse.dll
libwebrtcdataproto.dll
libwebrtcendpoint.dll
uc-media-server.exe
# kurentoall\kmswindows\lib\kurento\modules
libkmscoremodule.dll
libkmselementsmodule.dll
libkmsfiltersmodule.dll
fi
}

# GStreamer MODULE plugins only (not shared libs in bin/).
# Optional plugins (OpenCV filters, vp8parse) go to kurento/disabled/ — not scanned at startup.
install_kurento_gst_plugins()
{
KURENTO_GST_PLUGINS=$TARGET_DIRECTORY/lib/gstreamer-1.0/kurento
KURENTO_GST_DISABLED=$KURENTO_GST_PLUGINS/disabled
mkdir -p $KURENTO_GST_PLUGINS $KURENTO_GST_DISABLED
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
for plugin in \
	libvp8parse.dll \
	libkmsfacedetector.dll \
	libkmsfaceoverlay.dll \
	libkmsimageoverlay.dll \
	libkmslogooverlay.dll \
	libkmsmovementdetector.dll \
	libkmsopencvfilter.dll
do
	if [ -f $TARGET_DIRECTORY/bin/$plugin ]; then
		mv -f $TARGET_DIRECTORY/bin/$plugin $KURENTO_GST_DISABLED/
	fi
done
# Re-deploy: move optional plugins out of the active plugin dir if they were copied earlier.
for plugin in libvp8parse.dll libkmsfacedetector.dll libkmsfaceoverlay.dll \
	libkmsimageoverlay.dll libkmslogooverlay.dll libkmsmovementdetector.dll libkmsopencvfilter.dll
do
	if [ -f $KURENTO_GST_PLUGINS/$plugin ]; then
		mv -f $KURENTO_GST_PLUGINS/$plugin $KURENTO_GST_DISABLED/
	fi
done
# remove disabled - not needed
rm -rf $KURENTO_GST_DISABLED
}

# Like install_kurento_gst_plugins, but keeps filter/OpenCV MODULE plugins in kurento/.
# (Used by minimal-estos; "all" still omits them — load errors at registry scan.)
install_kurento_gst_plugins_with_filters()
{
KURENTO_GST_PLUGINS=$TARGET_DIRECTORY/lib/gstreamer-1.0/kurento
mkdir -p $KURENTO_GST_PLUGINS
for plugin in \
	libwebrtcendpoint.dll \
	librtpendpoint.dll \
	librtcpdemux.dll \
	libkmscore.dll \
	libkmselements.dll \
	libkmsrecorderendpoint.dll \
	libkmsfacedetector.dll \
	libkmsfaceoverlay.dll \
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
	"$ROOT_DIRECTORY/opencv-build-Debug/install/bin" \
	"$ROOT_DIRECTORY/opencv-build-Debug/install/x64/mingw/bin" \
	"$ROOT_DIRECTORY/opencv-build-Debug/x64/mingw/bin"
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
find "$ROOT_DIRECTORY/opencv-build-Debug" -name "libopencv*.dll" 2>/dev/null \
	| while read -r f; do
	cp -f "$f" -t "$TARGET_DIRECTORY/bin/"
done
}

# GStreamer plugin scanner subprocess (avoids "Couldn't create helper process").
copy_gstreamer_plugin_scanner()
{
for scanner in \
	"$MINGW64_DIR/libexec/gstreamer-1.0/gst-plugin-scanner.exe" \
	"$MINGW64_BIN_DIR/gst-plugin-scanner.exe"
do
	if [ -f "$scanner" ]; then
		cp -f "$scanner" -t "$TARGET_DIRECTORY/bin/"
		return 0
	fi
done
echo "WARNING: gst-plugin-scanner.exe not found under $MINGW64_DIR" >&2
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

copy_estos_extra_bin_dlls()
{
for dll in \
	libogg-0.dll \
	libtiff-6.dll \
	libopenjp2-7.dll \
	libdeflate.dll \
	libLerc.dll \
	libjbig-0.dll \
	liblz4.dll \
	libwebp-7.dll \
	libsharpyuv-0.dll \
	libzimg-2.dll
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

# Some Windows/GStreamer builds resolve deps from the plugin directory.
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

sync_minimal_estos_runtime_deps()
{
copy_opencv_runtime_dlls
copy_estos_extra_bin_dlls
copy_gstreamer_plugin_scanner
sync_mingw_dll_deps
copy_opencv_beside_kurento_plugins
}

# kurentoall\kmswindows\bin
copy_bin_files()
{
if [ ! -d $TARGET_DIRECTORY/bin ]; then
	mkdir -p $TARGET_DIRECTORY/bin
fi
#cp $MINGW64_BIN_DIR/libavcodec-58.dll -t $TARGET_DIRECTORY/bin/
#cp $MINGW64_BIN_DIR/libavcodec-58.dll -t $TARGET_DIRECTORY/bin/
#cp $MINGW64_BIN_DIR/libavdevice-58.dll -t $TARGET_DIRECTORY/bin/
#cp $MINGW64_BIN_DIR/libavfilter-7.dll -t $TARGET_DIRECTORY/bin/
#cp $MINGW64_BIN_DIR/libavformat-58.dll -t $TARGET_DIRECTORY/bin/
#cp $MINGW64_BIN_DIR/libavresample-4.dll -t $TARGET_DIRECTORY/bin/
#cp $MINGW64_BIN_DIR/libavutil-56.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libboost_atomic-mt.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libboost_filesystem-mt.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libboost_log-mt.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libboost_program_options-mt.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libboost_thread-mt.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libbrotlicommon.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libbrotlidec.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libbz2-1.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libcairo-2.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libcairo-gobject-2.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libcairo-script-interpreter-2.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libcrypto-3-x64.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libcurl-4.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libdatrie-1.dll -t $TARGET_DIRECTORY/bin/
#cp $MINGW64_BIN_DIR/libdv-4.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libexpat-1.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libffi-8.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libfontconfig-1.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libfreetype-6.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libfribidi-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgcc_s_seh-1.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libges-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgio-2.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libglib-2.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libglibmm-2.4-1.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgmodule-2.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgobject-2.0-0.dll -t $TARGET_DIRECTORY/bin/
#cp $MINGW64_BIN_DIR/libgraphene-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstadaptivedemux-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstallocators-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstapp-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstaudio-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstbadaudio-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstbase-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstbasecamerabinsrc-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstcheck-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstcodecparsers-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstcodecs-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstcontroller-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstcuda-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstd3d11-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstd3dshader-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstdxva-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstfft-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstgl-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstinsertbin-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstisoff-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstmpegts-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstnet-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstpbutils-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstphotography-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstplay-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstplayer-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstreamer-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstriff-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstrtp-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstrtsp-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstrtspserver-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstsctp-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstsdp-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgsttag-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgsttranscoder-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgsturidownloader-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstvalidate-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstvalidate-default-overrides-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstvideo-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgstwebrtc-1.0-0.dll -t $TARGET_DIRECTORY/bin/
#cp $MINGW64_BIN_DIR/libgstwebrtcnice-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgthread-2.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libiconv-2.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libidn2-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libintl-8.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libjpeg-8.3.2.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libjson-glib-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libjsoncpp-26.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/liblzma-5.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libmp3lame-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libnettle-8.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libnghttp2-14.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libnghttp3-9.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libngtcp2-16.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libngtcp2_crypto_ossl-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libnice-10.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libopenh264-7.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libopus-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/liborc-0.4-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/liborc-test-0.4-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libpango-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libpangocairo-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libpangoft2-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libpangowin32-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libpcre2-16-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libpcre2-32-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libpcre2-8-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libpcre2-posix-3.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libpixman-1-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libpng16-16.dll -t $TARGET_DIRECTORY/bin/
#cp $MINGW64_BIN_DIR/libpostproc-55.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libpsl-5.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libsigc-2.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libsoup-3.0-0.dll -t $TARGET_DIRECTORY/bin/
#cp $MINGW64_BIN_DIR/libsoup-gnome-2.4-1.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libsqlite3-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libssh2-1.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libssl-3-x64.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libstdc++-6.dll -t $TARGET_DIRECTORY/bin/
#cp $MINGW64_BIN_DIR/libswresample-3.dll -t $TARGET_DIRECTORY/bin/
#cp $MINGW64_BIN_DIR/libswscale-5.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libunistring-5.dll -t $TARGET_DIRECTORY/bin/
#cp $MINGW64_BIN_DIR/libvorbis-0.dll -t $TARGET_DIRECTORY/bin/
#cp $MINGW64_BIN_DIR/libvorbisenc-2.dll -t $TARGET_DIRECTORY/bin/
#cp $MINGW64_BIN_DIR/libvorbisfile-3.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libwinpthread-1.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libxml2-16.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libzstd.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/zlib1.dll -t $TARGET_DIRECTORY/bin/
}

# kmswindows\lib\gstreamer-1.0
copy_gstreamer_files()
{	
if [ ! -d $TARGET_DIRECTORY/lib/gstreamer-1.0 ]; then
	mkdir -p $TARGET_DIRECTORY/lib/gstreamer-1.0
fi
# Kurento MODULE plugins: lib/gstreamer-1.0/kurento/ (see install_kurento_gst_plugins).
# Shared libs (libkmswebrtcendpoint.dll, libcairo-*.dll, …) stay in bin/ — not in GST_PLUGIN_PATH.
# MSYS plugins: lib/gstreamer-1.0/ (see below).
#load error libkmsfacedetector.dll
#load error libkmsfaceoverlay.dll
#load error libkmsimageoverlay.dll
#load error libkmslogooverlay.dll
#load error libkmsmovementdetector.dll
#load error libkmsopencvfilter.dll

#load error libgstogg.dll
#load error libgstvalidatessim.dll
#load error libgstvorbis.dll
#dont need? cp $MINGW64_BIN_DIR/libexample_device_provider.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#dont need? cp $MINGW64_BIN_DIR/libgdbus-example-objectmanager.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#dont need? cp $MINGW64_BIN_DIR/libgioenvironmentproxy.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#dont need? cp $MINGW64_DIR/lib/gio/modules/libgioopenssl.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/

cp $MINGW64_BIN_DIR/libfdk-aac-2.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libfdk-aac-2.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstaccurip.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstadaptivedemux2.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstadder.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstadpcmdec.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstadpcmenc.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstaes.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstaiff.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstalaw.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstalpha.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstalphacolor.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstamfcodec.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstapetag.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstapp.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstasf.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstasfmux.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstaudiobuffersplit.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstaudioconvert.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstaudiofx.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstaudiofxbad.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstaudiolatency.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstaudiomixer.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstaudiomixmatrix.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstaudioparsers.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstaudiorate.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstaudioresample.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstaudiotestsrc.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstaudiovisualizers.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstauparse.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstautoconvert.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstautodetect.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstavi.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstbayer.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstbz2.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstcairo.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstcamerabin.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstclosedcaption.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstcodecalpha.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstcodectimestamper.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstcoloreffects.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstcompositor.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstcoreelements.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstcoretracers.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstcurl.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstcutter.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstd3d.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstd3d11.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstdash.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstdebug.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstdebugutilsbad.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstdecklink.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstdeinterlace.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstdirectsound.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstdirectsoundsrc.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstdtls.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstsrtp.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_BIN_DIR/libsrtp2-1.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstdtmf.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#cp $MINGW64_LIB_GSTREAMER_DIR/libgstdv.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstdvbsubenc.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstdvbsuboverlay.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstdvdlpcmdec.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstdvdspu.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstdvdsub.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgsteffectv.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstencoding.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstequalizer.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstfaceoverlay.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstfdkaac.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstfestival.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstfieldanalysis.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstflv.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstflxdec.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstfreeverb.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstfrei0r.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstgaudieffects.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstgdp.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstgeometrictransform.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstges.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstgio.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstgoom.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstgoom2k1.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgsthls.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgsticydemux.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstid3demux.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstid3tag.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstimagefreeze.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstinter.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstinterlace.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstinterleave.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstipcpipeline.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstisomp4.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstivfparse.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstivtc.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstjp2kdecimator.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstjpeg.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstjpegformat.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstlame.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstlegacyrawparse.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstlevel.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstlibav.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstmatroska.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#cp $MINGW64_LIB_GSTREAMER_DIR/libgstmicrodns.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstmidi.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstmonoscope.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstmpegpsdemux.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstmpegpsmux.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstmpegtsdemux.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstmpegtsmux.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstmulaw.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstmultifile.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstmultipart.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstmxf.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstnavigationtest.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstnetsim.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstnice.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstnle.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstnvcodec.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstopengl.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstopenh264.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstopus.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstopusparse.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstoverlaycomposition.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstpango.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstpbtypes.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstpcapparse.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstplayback.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstpng.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstpnm.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstproxy.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstqsv.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstrawparse.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstrealmedia.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstremovesilence.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstreplaygain.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstrfbsrc.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstrist.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstrtmp2.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstrtp.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstrtpmanager.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstrtpmanagerbad.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstrtponvif.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstrtsp.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstrtspclientsink.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstsctp.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstsdpelem.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstsegmentclip.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstshapewipe.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstsiren.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstsmooth.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstsmoothstreaming.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstsmpte.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstsoup.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstspectrum.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstspeed.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstsubenc.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstsubparse.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstswitchbin.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgsttcp.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgsttimecode.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgsttranscode.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstttmlsubs.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgsttypefindfunctions.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstudp.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/validate/libgstvalidategapplication.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstvalidatetracer.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstvideobox.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstvideoconvertscale.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstvideocrop.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstvideofilter.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstvideofiltersbad.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstvideoframe_audiolevel.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstvideomixer.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstvideoparsersbad.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstvideorate.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstvideosignal.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstvideotestsrc.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstvmnc.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstvolume.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstwasapi.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstwaveform.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstwavenc.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstwavparse.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#cp $MINGW64_LIB_GSTREAMER_DIR/libgstwebrtc.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstwin32ipc.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstwinks.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstwinscreencap.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstxingmux.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#cp $MINGW64_LIB_GSTREAMER_DIR/libgsty4mdec.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#cp $MINGW64_LIB_GSTREAMER_DIR/libgsty4menc.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgsty4m.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
# Pango/Cairo/Freetype load HarfBuzz from bin/ (not plugin dir); keep versions consistent.
cp $MINGW64_BIN_DIR/libharfbuzz-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libharfbuzz-gobject-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libharfbuzz-subset-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgraphite2.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libthai-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libharfbuzz-0.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_BIN_DIR/libharfbuzz-gobject-0.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_BIN_DIR/libharfbuzz-subset-0.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#cp $MINGW64_BIN_DIR/libmicrodns.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#cp $MINGW64_LIB_GSTREAMER_DIR/libmoduletestplugin_a_library.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#cp $MINGW64_LIB_GSTREAMER_DIR/libmoduletestplugin_a_plugin.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#cp $MINGW64_LIB_GSTREAMER_DIR/libmoduletestplugin_b_library.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#cp $MINGW64_LIB_GSTREAMER_DIR/libmoduletestplugin_b_plugin.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#cp $MINGW64_BIN_DIR/libogg.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#cp $MINGW64_LIB_GSTREAMER_DIR/libresourceplugin.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#cp $MINGW64_LIB_GSTREAMER_DIR/libtest-utils.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#cp $MINGW64_LIB_GSTREAMER_DIR/libtestmodulea.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#cp $MINGW64_LIB_GSTREAMER_DIR/libtestmoduleb.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_BIN_DIR/libxml2-16.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
}

# estos minimal: MediaPipeline, Rtp/WebRtc, Player, Recorder, DispatcherOneToMany, Composite
# + module-filters (libkmsfiltersmodule, filter plugins, OpenCV runtime in bin/).
copy_kurento_files_minimal_estos()
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
	libkmsrecorderendpoint.dll \
	libkmsfacedetector.dll \
	libkmsfaceoverlay.dll \
	libkmsimageoverlay.dll \
	libkmslogooverlay.dll \
	libkmsmovementdetector.dll \
	libkmsopencvfilter.dll
do
	copy_kurento_build_dll "$dll"
done
cp $ROOT_DIRECTORY/kurento/server/build-Debug/media-server/server/kurento-media-server.exe $TARGET_DIRECTORY/bin/uc-media-server.exe

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

install_kurento_gst_plugins_with_filters
}

copy_bin_files_minimal_estos()
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
	libcairo-2.dll \
	libcairo-gobject-2.dll \
	libcrypto-3-x64.dll \
	libcurl-4.dll \
	libexpat-1.dll \
	libffi-8.dll \
	libfontconfig-1.dll \
	libfreetype-6.dll \
	libgcc_s_seh-1.dll \
	libgraphite2.dll \
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
	libharfbuzz-0.dll \
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
	libpixman-1-0.dll \
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

copy_gstreamer_files_minimal_estos()
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
	libgstavi.dll \
	libgstcairo.dll \
	libgstcompositor.dll \
	libgstcoreelements.dll \
	libgstdtls.dll \
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

copy_minimal_estos()
{
clean_kmswindows_runtime_dlls
copy_kurento_files_minimal_estos
copy_bin_files_minimal_estos
copy_gstreamer_files_minimal_estos
sync_minimal_estos_runtime_deps
}

case "$1" in
	kurento)
		set -x #print all executed command
		copy_kurento_files
		;;
	bin)
		set -x #print all executed command
		copy_bin_files
		;;
	gstreamer)
		set -x #print all executed command
		copy_kurento_files		
		copy_gstreamer_files
		;;
	all)
		set -x #print all executed command
		copy_kurento_files
		copy_bin_files
		copy_gstreamer_files
		;;
	minimal-estos)
		set -x #print all executed command
		copy_minimal_estos
		;;
	*)
set +x
		echo ""
		echo "Usage:"
		echo "  kurento          -> copy kurento files"		
		echo "  bin              -> copy bin files"		
		echo "  gstreamer        -> copy gstreamer files"
		echo "  all              -> copy all files"
		echo "  minimal-estos    -> estos subset (+ module-filters / OpenCV plugins)"
		echo ""
		;;
esac