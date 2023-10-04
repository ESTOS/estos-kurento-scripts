#! /bin/sh
set -x #print all executed command
ROOT_DIRECTORY=/x/dev/estos-kurento-scripts/kurentoall
TARGET_DIRECTORY=$ROOT_DIRECTORY/kmswindows
LIB_DIRECTORY=/mingw64/bin

if [ "$1" = ""  ] || [ "$1" = "kurento"  ]; then
#kurento files
find $ROOT_DIRECTORY/kurento/server/build-Debug -name "*.dll" | xargs cp -t $TARGET_DIRECTORY/bin/
cp $ROOT_DIRECTORY/kurento/server/build-Debug/media-server/server/kurento-media-server.exe $TARGET_DIRECTORY/bin/uc-media-server.exe
mv $TARGET_DIRECTORY/bin/libkmscoremodule.dll $TARGET_DIRECTORY/lib/kurento/modules
mv $TARGET_DIRECTORY/bin/libkmselementsmodule.dll $TARGET_DIRECTORY/lib/kurento/modules
mv $TARGET_DIRECTORY/bin/libkmsfiltersmodule.dll $TARGET_DIRECTORY/lib/kurento/modules
fi

#if [ "$1" = ""  ] || [ "$1" = "system"  ]; then
if [ "$1" = "mist1" ]; then
#system + submodules files
cp $LIB_DIRECTORY/libboost_atomic-mt.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libboost_filesystem-mt.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libboost_log-mt.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libboost_program_options-mt.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libboost_thread-mt.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libcrypto-3-x64.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libffi-8.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgcc_s_seh-1.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgio-2.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libglib-2.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libglibmm-2.4-1.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgmodule-2.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgobject-2.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstaudio-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstbase-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstpbutils-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstreamer-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstrtp-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstsdp-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgsttag-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstvideo-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libiconv-2.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libintl-8.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libjsoncpp-25.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/liborc-0.4-0.dll -t $TARGET_DIRECTORY/bin/
#cp $LIB_DIRECTORY/libpcre2-8-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libpcre2-8.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libsigc-2.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libssl-3-x64.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libstdc++-6.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libwinpthread-1.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/zlib1.dll -t $TARGET_DIRECTORY/bin/

fi

#LIB_DIRECTORY=/mingw64/bin
#if [ "$1" = ""  ] || [ "$1" = "system"  ]; then
if [ "$1" = "mist2" ]; then
cp $LIB_DIRECTORY/libavcodec-58.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libavdevice-58.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libavfilter-7.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libavformat-58.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libavresample-4.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libavutil-56.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libboost_atomic-mt.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libboost_filesystem-mt.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libboost_log-mt.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libboost_program_options-mt.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libboost_thread-mt.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libbz2-1.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libcairo-2.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libcairo-gobject-2.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libcairo-script-interpreter-2.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libcrypto-3-x64.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libdv-4.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libffi-8.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libfontconfig-1.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libfreetype-6.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libfribidi-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgcc_s_seh-1.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libges-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgio-2.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libglib-2.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libglibmm-2.4-1.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgmodule-2.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgobject-2.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgraphene-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstadaptivedemux-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstallocators-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstapp-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstaudio-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstbadaudio-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstbase-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstbasecamerabinsrc-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstcheck-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstcodecparsers-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstcodecs-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstcontroller-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstcuda-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstd3d11-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstfft-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstgl-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstinsertbin-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstisoff-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstmpegts-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstnet-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstpbutils-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstphotography-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstplay-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstplayer-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstreamer-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstriff-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstrtp-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstrtsp-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstrtspserver-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstsctp-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstsdp-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgsttag-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgsttranscoder-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgsturidownloader-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstvalidate-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstvalidate-default-overrides-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstvideo-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstwebrtc-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgstwebrtcnice-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libgthread-2.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libiconv-2.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libintl-8.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libjpeg-8.2.2.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libjsoncpp-25.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libjson-glib-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/liblzma-5.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libmp3lame-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libnice-10.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libopenh264-7.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libopus-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/liborc-0.4-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/liborc-test-0.4-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libpango-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libpangocairo-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libpangoft2-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libpangowin32-1.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libpcre2-8.dll -t $TARGET_DIRECTORY/bin/
#cp $LIB_DIRECTORY/libpcre2-16.dll -t $TARGET_DIRECTORY/bin/
#cp $LIB_DIRECTORY/libpcre2-32.dll -t $TARGET_DIRECTORY/bin/
#cp $LIB_DIRECTORY/libpcre2-posix.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libpixman-1-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libpng16-16.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libpostproc-55.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libsigc-2.0-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libsoup-2.4-1.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libsoup-gnome-2.4-1.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libssl-3-x64.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libstdc++-6.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libswresample-3.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libswscale-5.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libvorbis-0.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libvorbisenc-2.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libvorbisfile-3.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/libwinpthread-1.dll -t $TARGET_DIRECTORY/bin/
cp $LIB_DIRECTORY/zlib1.dll -t $TARGET_DIRECTORY/bin/

fi

#LIB_DIRECTORY=/mingw64/bin
#if [ "$1" = ""  ] || [ "$1" = "system"  ]; then
if [ "$1" = "mist3" ]; then
# -t $TARGET_DIRECTORY/lib/gstreamer-1.0/

libexample_device_provider.dll
libfdk_aac.dll
libgdbus-example-objectmanager.dll
libgioenvironmentproxy.dll
libgioopenssl.dll
libgstaccurip.dll
libgstadaptivedemux2.dll
libgstadder.dll
libgstadpcmdec.dll
libgstadpcmenc.dll
libgstaes.dll
libgstaiff.dll
libgstalaw.dll
libgstalpha.dll
libgstalphacolor.dll
libgstamfcodec.dll
libgstapetag.dll
libgstapp.dll
libgstasf.dll
libgstasfmux.dll
libgstaudiobuffersplit.dll
libgstaudioconvert.dll
libgstaudiofx.dll
libgstaudiofxbad.dll
libgstaudiolatency.dll
libgstaudiomixer.dll
libgstaudiomixmatrix.dll
libgstaudioparsers.dll
libgstaudiorate.dll
libgstaudioresample.dll
libgstaudiotestsrc.dll
libgstaudiovisualizers.dll
libgstauparse.dll
libgstautoconvert.dll
libgstautodetect.dll
libgstavi.dll
libgstbayer.dll
libgstbz2.dll
libgstcairo.dll
libgstcamerabin.dll
libgstclosedcaption.dll
libgstcodecalpha.dll
libgstcodectimestamper.dll
libgstcoloreffects.dll
libgstcompositor.dll
libgstcoreelements.dll
libgstcoretracers.dll
libgstcurl.dll
libgstcutter.dll
libgstd3d.dll
libgstd3d11.dll
libgstdash.dll
libgstdebug.dll
libgstdebugutilsbad.dll
libgstdecklink.dll
libgstdeinterlace.dll
libgstdirectsound.dll
libgstdirectsoundsrc.dll
libgstdtls.dll
libgstdtmf.dll
libgstdv.dll
libgstdvbsubenc.dll
libgstdvbsuboverlay.dll
libgstdvdlpcmdec.dll
libgstdvdspu.dll
libgstdvdsub.dll
libgsteffectv.dll
libgstencoding.dll
libgstequalizer.dll
libgstfaceoverlay.dll
libgstfdkaac.dll
libgstfestival.dll
libgstfieldanalysis.dll
libgstflv.dll
libgstflxdec.dll
libgstfreeverb.dll
libgstfrei0r.dll
libgstgaudieffects.dll
libgstgdp.dll
libgstgeometrictransform.dll
libgstges.dll
libgstgio.dll
libgstgoom.dll
libgstgoom2k1.dll
libgsthls.dll
libgsticydemux.dll
libgstid3demux.dll
libgstid3tag.dll
libgstimagefreeze.dll
libgstinter.dll
libgstinterlace.dll
libgstinterleave.dll
libgstipcpipeline.dll
libgstisomp4.dll
libgstivfparse.dll
libgstivtc.dll
libgstjp2kdecimator.dll
libgstjpeg.dll
libgstjpegformat.dll
libgstlame.dll
libgstlegacyrawparse.dll
libgstlevel.dll
libgstlibav.dll
libgstmatroska.dll
libgstmicrodns.dll
libgstmidi.dll
libgstmonoscope.dll
libgstmpegpsdemux.dll
libgstmpegpsmux.dll
libgstmpegtsdemux.dll
libgstmpegtsmux.dll
libgstmulaw.dll
libgstmultifile.dll
libgstmultipart.dll
libgstmxf.dll
libgstnavigationtest.dll
libgstnetsim.dll
libgstnice.dll
libgstnle.dll
libgstnvcodec.dll
libgstogg.dll
libgstopengl.dll
libgstopenh264.dll
libgstopus.dll
libgstopusparse.dll
libgstoverlaycomposition.dll
libgstpango.dll
libgstpbtypes.dll
libgstpcapparse.dll
libgstplayback.dll
libgstpng.dll
libgstpnm.dll
libgstproxy.dll
libgstqsv.dll
libgstrawparse.dll
libgstrealmedia.dll
libgstremovesilence.dll
libgstreplaygain.dll
libgstrfbsrc.dll
libgstrist.dll
libgstrtmp2.dll
libgstrtp.dll
libgstrtpmanager.dll
libgstrtpmanagerbad.dll
libgstrtponvif.dll
libgstrtsp.dll
libgstrtspclientsink.dll
libgstsctp.dll
libgstsdpelem.dll
libgstsegmentclip.dll
libgstshapewipe.dll
libgstsiren.dll
libgstsmooth.dll
libgstsmoothstreaming.dll
libgstsmpte.dll
libgstsoup.dll
libgstspectrum.dll
libgstspeed.dll
libgstsubenc.dll
libgstsubparse.dll
libgstswitchbin.dll
libgsttcp.dll
libgsttimecode.dll
libgsttranscode.dll
libgstttmlsubs.dll
libgsttypefindfunctions.dll
libgstudp.dll
libgstvalidategapplication.dll
libgstvalidatessim.dll
libgstvalidatetracer.dll
libgstvideobox.dll
libgstvideoconvertscale.dll
libgstvideocrop.dll
libgstvideofilter.dll
libgstvideofiltersbad.dll
libgstvideoframe_audiolevel.dll
libgstvideomixer.dll
libgstvideoparsersbad.dll
libgstvideorate.dll
libgstvideosignal.dll
libgstvideotestsrc.dll
libgstvmnc.dll
libgstvolume.dll
libgstvorbis.dll
libgstwasapi.dll
libgstwaveform.dll
libgstwavenc.dll
libgstwavparse.dll
libgstwebrtc.dll
libgstwin32ipc.dll
libgstwinks.dll
libgstwinscreencap.dll
libgstxingmux.dll
libgsty4mdec.dll
libgsty4menc.dll
libharfbuzz-0.dll
libharfbuzz-gobject-0.dll
libharfbuzz-subset-0.dll
libkmscore.dll
libkmselements.dll
libkmsfacedetector.dll
libkmsfaceoverlay.dll
libkmsgstcommons.dll
libkmsimageoverlay.dll
libkmslogooverlay.dll
libkmsmovementdetector.dll
libkmsopencvfilter.dll
libkmsrecorderendpoint.dll
libkmsrtpendpointlib.dll
libkmswebrtcendpoint.dll
libmicrodns.dll
libmoduletestplugin_a_library.dll
libmoduletestplugin_a_plugin.dll
libmoduletestplugin_b_library.dll
libmoduletestplugin_b_plugin.dll
libogg.dll
libresourceplugin.dll
librtcpdemux.dll
librtpendpoint.dll
libtest-utils.dll
libtestmodulea.dll
libtestmoduleb.dll
libwebrtcdataproto.dll
libwebrtcendpoint.dll
libxml2.dll
			   
fi

