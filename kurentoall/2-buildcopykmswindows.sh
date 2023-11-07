#! /bin/sh
set -e #stop on error
#set -x #print all executed command
ROOT_DIRECTORY=/x/dev/estos-kurento-scripts/kurentoall
TARGET_DIRECTORY=$ROOT_DIRECTORY/kmswindows
MINGW64_DIR=/mingw64
MINGW64_BIN_DIR=$MINGW64_DIR/bin
MINGW64_LIB_GSTREAMER_DIR=$MINGW64_DIR/lib/gstreamer-1.0

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

# kurentoall\kmswindows\bin
copy_bin_files()
{
if [ ! -d $TARGET_DIRECTORY/bin ]; then
	mkdir -p $TARGET_DIRECTORY/bin
fi
cp $MINGW64_BIN_DIR/libavcodec-58.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libavcodec-58.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libavdevice-58.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libavfilter-7.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libavformat-58.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libavresample-4.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libavutil-56.dll -t $TARGET_DIRECTORY/bin/
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
cp $MINGW64_BIN_DIR/libdv-4.dll -t $TARGET_DIRECTORY/bin/
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
cp $MINGW64_BIN_DIR/libgraphene-1.0-0.dll -t $TARGET_DIRECTORY/bin/
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
cp $MINGW64_BIN_DIR/libgstwebrtcnice-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libgthread-2.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libiconv-2.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libidn2-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libintl-8.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libjpeg-8.2.2.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libjson-glib-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libjsoncpp-25.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/liblzma-5.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libmp3lame-0.dll -t $TARGET_DIRECTORY/bin/
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
cp $MINGW64_BIN_DIR/libpostproc-55.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libpsl-5.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libsigc-2.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libsoup-2.4-1.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libsoup-gnome-2.4-1.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libsqlite3-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libssl-3-x64.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libstdc++-6.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libswresample-3.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libswscale-5.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libunistring-5.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libvorbis-0.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libvorbisenc-2.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libvorbisfile-3.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libwinpthread-1.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/libxml2-2.dll -t $TARGET_DIRECTORY/bin/
cp $MINGW64_BIN_DIR/zlib1.dll -t $TARGET_DIRECTORY/bin/
}

# kmswindows\lib\gstreamer-1.0
copy_gstreamer_files()
{	
if [ ! -d $TARGET_DIRECTORY/lib/gstreamer-1.0 ]; then
	mkdir -p $TARGET_DIRECTORY/lib/gstreamer-1.0
fi
# kurent files
cp $TARGET_DIRECTORY/bin/libkmscore.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $TARGET_DIRECTORY/bin/libkmselements.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#load error libkmsfacedetector.dll
#load error libkmsfaceoverlay.dll
cp $TARGET_DIRECTORY/bin/libkmsgstcommons.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#load error libkmsimageoverlay.dll
#load error libkmslogooverlay.dll
#load error libkmsmovementdetector.dll
#load error libkmsopencvfilter.dll
#load error libwebrtcendpoint.dll
cp $TARGET_DIRECTORY/bin/libkmsrecorderendpoint.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $TARGET_DIRECTORY/bin/libkmsrtpendpointlib.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $TARGET_DIRECTORY/bin/libkmswebrtcendpoint.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $TARGET_DIRECTORY/bin/librtcpdemux.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $TARGET_DIRECTORY/bin/librtpendpoint.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $TARGET_DIRECTORY/bin/libwebrtcdataproto.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/

#load error libgstogg.dll
#load error libgstvalidatessim.dll
#load error libgstvorbis.dll
#dont need? cp $MINGW64_BIN_DIR/libexample_device_provider.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#dont need? cp $MINGW64_BIN_DIR/libgdbus-example-objectmanager.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#dont need? cp $MINGW64_BIN_DIR/libgioenvironmentproxy.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#dont need? cp $MINGW64_DIR/lib/gio/modules/libgioopenssl.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/

cp $MINGW64_BIN_DIR/libfdk_aac.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
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
cp $MINGW64_LIB_GSTREAMER_DIR/libgstdtmf.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstdv.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
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
cp $MINGW64_LIB_GSTREAMER_DIR/libgstmicrodns.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
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
cp $MINGW64_LIB_GSTREAMER_DIR/libgstwebrtc.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstwin32ipc.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstwinks.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstwinscreencap.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgstxingmux.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgsty4mdec.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_LIB_GSTREAMER_DIR/libgsty4menc.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_BIN_DIR/libharfbuzz-0.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_BIN_DIR/libharfbuzz-gobject-0.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_BIN_DIR/libharfbuzz-subset-0.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_BIN_DIR/libmicrodns.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#cp $MINGW64_LIB_GSTREAMER_DIR/libmoduletestplugin_a_library.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#cp $MINGW64_LIB_GSTREAMER_DIR/libmoduletestplugin_a_plugin.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#cp $MINGW64_LIB_GSTREAMER_DIR/libmoduletestplugin_b_library.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#cp $MINGW64_LIB_GSTREAMER_DIR/libmoduletestplugin_b_plugin.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_BIN_DIR/libogg.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#cp $MINGW64_LIB_GSTREAMER_DIR/libresourceplugin.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#cp $MINGW64_LIB_GSTREAMER_DIR/libtest-utils.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#cp $MINGW64_LIB_GSTREAMER_DIR/libtestmodulea.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
#cp $MINGW64_LIB_GSTREAMER_DIR/libtestmoduleb.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
cp $MINGW64_BIN_DIR/libxml2-2.dll -t $TARGET_DIRECTORY/lib/gstreamer-1.0/
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
	*)
set +x
		echo ""
		echo "Usage:"
		echo "  kurento          -> copy kurento files"		
		echo "  bin              -> copy bin files"		
		echo "  gstreamer        -> copy gstreamer files"
		echo "  all              -> copy all files"
		echo ""
		;;
esac