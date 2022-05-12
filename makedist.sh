echo "4. Prepare distribution package"

CPPARAMS=
#CPPARAMS=--preserve=timestamps
actualbuilddate=`date "+%Y%m%d_%H%M%S_%N"`
actualcommitlogs=lastcommitlogs_$actualbuilddate

source ./lastcommits.sh
cp $CPPARAMS lastcommits_actual.txt $actualcommitlogs

export PREF=/usr/i686-w64-mingw32/sys-root/mingw
rm -rf dist
mkdir dist
cd dist
mkdir -p bin/
mkdir -p lib/gstreamer-1.5/
mkdir -p lib/kurento/modules/
mkdir -p etc/kurento/
mkdir -p etc/kurento/modules/
mkdir -p etc/kurento/modules/kurento

export PREF=/usr/i686-w64-mingw32/sys-root/mingw
cp $CPPARAMS $PREF/bin/kurento-media-server.exe bin/uc-media-server.exe
cp $CPPARAMS $PREF/bin/libpcre-1.dll bin/
cp $CPPARAMS $PREF/bin/iconv.dll bin/
# cp $CPPARAMS $PREF/bin/libatk-1.0-0.dll bin/
cp $CPPARAMS $PREF/bin/libboost_filesystem-mt.dll bin/
cp $CPPARAMS $PREF/bin/libboost_log-mt.dll bin/
cp $CPPARAMS $PREF/bin/libboost_log_setup-mt.dll bin/
cp $CPPARAMS $PREF/bin/libboost_program_options-mt.dll bin/
cp $CPPARAMS $PREF/bin/libboost_regex-mt.dll bin/
cp $CPPARAMS $PREF/bin/libboost_system-mt.dll bin/
cp $CPPARAMS $PREF/bin/libboost_thread-mt.dll bin/
cp $CPPARAMS $PREF/bin/libbz2-1.dll bin/
# cp $CPPARAMS $PREF/bin/libcairo-2.dll bin/
# cp $CPPARAMS $PREF/bin/libcairo-gobject-2.dll bin/
cp $CPPARAMS ../openssl/libcrypto-10-no-sse.dll bin/
cp $CPPARAMS $PREF/bin/libcrypto-10.dll bin/
# libeay32.dll == libcrypto-10.dll -> need it with debug libssl-10.dll
# cp $CPPARAMS $PREF/bin/libcrypto-10.dll bin/libeay32.dll
# cp $CPPARAMS $PREF/bin/libepoxy-0.dll bin/
cp $CPPARAMS $PREF/bin/libexpat-1.dll bin/
cp $CPPARAMS $PREF/bin/libffi-6.dll bin/
# cp $CPPARAMS $PREF/bin/libfontconfig-1.dll bin/
# cp $CPPARAMS $PREF/bin/libfreetype-6.dll bin/
cp $CPPARAMS $PREF/bin/libgcc_s_sjlj-1.dll bin/
# cp $CPPARAMS $PREF/bin/libgdk-3-0.dll bin/
# cp $CPPARAMS $PREF/bin/libgdk_pixbuf-2.0-0.dll bin/
cp $CPPARAMS $PREF/bin/libgio-2.0-0.dll bin/
cp $CPPARAMS $PREF/bin/libglib-2.0-0.dll bin/
cp $CPPARAMS $PREF/bin/libglibmm-2.4-1.dll bin/
cp $CPPARAMS $PREF/bin/libgmodule-2.0-0.dll bin/
cp $CPPARAMS $PREF/bin/libgobject-2.0-0.dll bin/
#cp $CPPARAMS $PREF/bin/libgsm-1.dll bin/
cp $CPPARAMS $PREF/bin/libgstadaptivedemux-1.5-0.dll bin/
cp $CPPARAMS $PREF/bin/libgstapp-1.5-0.dll bin/
cp $CPPARAMS $PREF/bin/libgstaudio-1.5-0.dll bin/
# cp $CPPARAMS $PREF/bin/libgstbadaudio-1.5-0.dll bin/
# cp $CPPARAMS $PREF/bin/libgstbadbase-1.5-0.dll bin/
cp $CPPARAMS $PREF/bin/libgstbadvideo-1.5-0.dll bin/
cp $CPPARAMS $PREF/bin/libgstbase-1.5-0.dll bin/
# cp $CPPARAMS $PREF/bin/libgstbasecamerabinsrc-1.5-0.dll bin/
# cp $CPPARAMS $PREF/bin/libgstcodecparsers-1.5-0.dll bin/
# cp $CPPARAMS $PREF/bin/libgstfft-1.5-0.dll bin/
# cp $CPPARAMS $PREF/bin/libgstgl-1.5-0.dll bin/
# cp $CPPARAMS $PREF/bin/libgstmpegts-1.5-0.dll bin/
cp $CPPARAMS $PREF/bin/libgstnet-1.5-0.dll bin/
cp $CPPARAMS $PREF/bin/libgstpbutils-1.5-0.dll bin/
# cp $CPPARAMS $PREF/bin/libgstphotography-1.5-0.dll bin/
cp $CPPARAMS $PREF/bin/libgstreamer-1.5-0.dll bin/
cp $CPPARAMS $PREF/bin/libgstriff-1.5-0.dll bin/
cp $CPPARAMS $PREF/bin/libgstrtp-1.5-0.dll bin/
cp $CPPARAMS $PREF/bin/libgstrtsp-1.5-0.dll bin/
cp $CPPARAMS $PREF/bin/libgstsctp-1.5.dll bin/
cp $CPPARAMS $PREF/bin/libgstsdp-1.5-0.dll bin/
cp $CPPARAMS $PREF/bin/libgsttag-1.5-0.dll bin/
cp $CPPARAMS $PREF/bin/libgsturidownloader-1.5-0.dll bin/ # adaptivedemux need this
cp $CPPARAMS $PREF/bin/libgstvideo-1.5-0.dll bin/
# cp $CPPARAMS $PREF/bin/libgtk-3-0.dll bin/
# cp $CPPARAMS $PREF/bin/libHalf-12.dll bin/
cp $CPPARAMS $PREF/bin/libIex-2_2-12.dll bin/
# cp $CPPARAMS $PREF/bin/libIlmImf-2_2-22.dll bin/
# cp $CPPARAMS $PREF/bin/libIlmThread-2_2-12.dll bin/
cp $CPPARAMS $PREF/bin/libintl-8.dll bin/
# cp $CPPARAMS $PREF/bin/libjasper-1.dll bin/
# cp $CPPARAMS $PREF/bin/libjpeg-62.dll bin/
cp $CPPARAMS $PREF/bin/libjsonrpc.dll bin/
cp $CPPARAMS $PREF/bin/libkmscoreimpl.dll bin/
cp $CPPARAMS $PREF/bin/libkmselementsimpl.dll bin/
cp $CPPARAMS $PREF/bin/libkmsfiltersimpl.dll bin/
cp $CPPARAMS $PREF/bin/libkmsgstcommons.dll bin/
cp $CPPARAMS $PREF/bin/libkmsjsoncpp.dll bin/
#cp $CPPARAMS $PREF/bin/libkmsrtpsync.dll bin/
cp $CPPARAMS $PREF/bin/libkmssdpagent.dll bin/
cp $CPPARAMS $PREF/bin/libkmswebrtcendpointlib.dll bin/
#if [ -f $PREF/bin/libnettle-6-2.dll ]; then
#	cp $CPPARAMS $PREF/bin/libnettle-6-2.dll bin/
#else
#	cp $CPPARAMS $PREF/bin/libnettle-6.dll bin/
#fi
cp $CPPARAMS $PREF/bin/libnice-10.dll bin/
# cp $CPPARAMS $PREF/bin/libogg-0.dll bin/
# cp $CPPARAMS $PREF/bin/libopencv_core2413.dll bin/
# cp $CPPARAMS $PREF/bin/libopencv_highgui2413.dll bin/
# cp $CPPARAMS $PREF/bin/libopencv_imgproc2413.dll bin/
# cp $CPPARAMS $PREF/bin/libopencv_objdetect2413.dll bin/
cp $CPPARAMS $PREF/bin/libopus-0.dll bin/
cp $CPPARAMS $PREF/bin/liborc-0.4-0.dll bin/
cp $CPPARAMS $PREF/bin/liborc-test-0.4-0.dll bin/
# cp $CPPARAMS $PREF/bin/libpango-1.0-0.dll bin/
# cp $CPPARAMS $PREF/bin/libpangocairo-1.0-0.dll bin/
# cp $CPPARAMS $PREF/bin/libpangowin32-1.0-0.dll bin/
# cp $CPPARAMS $PREF/bin/libpixman-1-0.dll bin/
# cp $CPPARAMS $PREF/bin/libpng16-16.dll bin/
cp $CPPARAMS $PREF/bin/libsigc-2.0-0.dll bin/
cp $CPPARAMS $PREF/bin/libsoup-2.4-1.dll bin/
cp $CPPARAMS $PREF/bin/libspeex-1.dll bin/
cp $CPPARAMS $PREF/bin/libsqlite3-0.dll bin/
cp $CPPARAMS $PREF/bin/libssl-10.dll bin/
cp $CPPARAMS $PREF/bin/libstdc++-6.dll bin/
# cp $CPPARAMS $PREF/bin/libtiff-5.dll bin/
# cp $CPPARAMS $PREF/bin/libvorbis-0.dll bin/
# cp $CPPARAMS $PREF/bin/libvorbisenc-2.dll bin/
# cp $CPPARAMS $PREF/bin/libwavpack-1.dll bin/
cp $CPPARAMS $PREF/bin/libwebrtcdataproto.dll bin/
cp $CPPARAMS $PREF/bin/libwinpthread-1.dll bin/
cp $CPPARAMS $PREF/bin/libxml2-2.dll bin/
cp $CPPARAMS $PREF/bin/zlib1.dll bin/

#used for gnutls in libnice - mingw32-gnutls
cp $CPPARAMS $PREF/bin/libgmp-10.dll bin/
cp $CPPARAMS $PREF/bin/libgnutls-30.dll bin/
cp $CPPARAMS $PREF/bin/libhogweed-4.dll bin/
cp $CPPARAMS $PREF/bin/libnettle-6.dll bin/
cp $CPPARAMS $PREF/bin/libp11-kit-0.dll bin/
cp $CPPARAMS $PREF/bin/libtasn1-6.dll bin/
#used for gnutls in libnice - mingw32-libidn2
cp $CPPARAMS $PREF/bin/libidn2-0.dll bin/

# cp $CPPARAMS $PREF/lib/gstreamer-1.5/libfacedetector.dll lib/gstreamer-1.5/
# cp $CPPARAMS $PREF/lib/gstreamer-1.5/libfaceoverlay.dll lib/gstreamer-1.5/
# cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstaccurip.dll lib/gstreamer-1.5/
# cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstadder.dll lib/gstreamer-1.5/
# cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstadpcmdec.dll lib/gstreamer-1.5/
# cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstadpcmenc.dll lib/gstreamer-1.5/
# cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstaiff.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstalaw.dll lib/gstreamer-1.5/
# cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstalpha.dll lib/gstreamer-1.5/
# cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstalphacolor.dll lib/gstreamer-1.5/
# cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstapetag.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstapp.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstasf.dll lib/gstreamer-1.5/
# cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstasfmux.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstaudioconvert.dll lib/gstreamer-1.5/
# cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstaudiofx.dll lib/gstreamer-1.5/
# cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstaudiofxbad.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstaudiomixer.dll lib/gstreamer-1.5/
# cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstaudioparsers.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstaudiorate.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstaudioresample.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstaudiotestsrc.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstaudiovisualizers.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstauparse.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstautoconvert.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstautodetect.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstavi.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstbayer.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstbz2.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstcairo.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstcamerabin2.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstcoloreffects.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstcompositor.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstcoreelements.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstcoretracers.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstcutter.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstd3dvideosink.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstdashdemux.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstdataurisrc.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstdebug.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstdebugutilsbad.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstdeinterlace.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstdirectsoundsink.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstdirectsoundsrc.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstdtls.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstdtmf.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstdvbsuboverlay.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstdvdlpcmdec.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstdvdspu.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstdvdsub.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgsteffectv.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstencodebin.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstequalizer.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstfestival.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstfieldanalysis.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstflv.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstflxdec.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstfreeverb.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstfrei0r.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstgaudieffects.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstgdkpixbuf.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstgdp.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstgeometrictransform.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstgio.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstgoom.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstgoom2k1.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstgsm.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstgtksink.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgsthls.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgsticydemux.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstid3demux.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstid3tag.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstimagefreeze.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstinter.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstinterlace.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstinterleave.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstisomp4.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstivfparse.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstivtc.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstjp2kdecimator.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstjpeg.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstjpegformat.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstlevel.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstmatroska.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstmidi.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstmpegpsdemux.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstmpegpsmux.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstmpegtsdemux.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstmpegtsmux.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstmulaw.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstmultifile.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstmultipart.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstmxf.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstnavigationtest.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstnetsim.dll lib/gstreamer-1.5/
#compatible to estos6.2
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstnice15.dll lib/gstreamer-1.5/libgstnice15.dll
#for estos6.3
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstnice15.dll lib/gstreamer-1.5/libgstnice.dll
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstogg.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstopenexr.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstopengl.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstopus.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstopusparse.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstpango.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstpcapparse.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstplayback.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstpng.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstpnm.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstrawparse.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstremovesilence.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstreplaygain.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstrfbsrc.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstrmdemux.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstrtp.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstrtpmanager.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstrtponvif.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstrtsp.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstsdpelem.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstsegmentclip.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstshapewipe.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstsiren.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstsmooth.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstsmoothstreaming.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstsmpte.dll lib/gstreamer-1.5/
#compatible to estos6.2 -> dont copy for 6.3 else we get an error in at startup
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstsouphttpsrc.dll lib/gstreamer-1.5/libgstsouphttpsrc.dll
#for estos6.3
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstsouphttpsrc.dll lib/gstreamer-1.5/libgstsoup.dll
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstspectrum.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstspeed.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstspeex.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstsrtp.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgststereo.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstsubenc.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstsubparse.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgsttcp.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgsttypefindfunctions.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstudp.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstvideobox.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstvideoconvert.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstvideocrop.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstvideofilter.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstvideofiltersbad.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstvideoframe_audiolevel.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstvideomixer.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstvideoparsersbad.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstvideorate.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstvideorepair.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstvideoscale.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstvideosignal.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstvideotestsrc.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstvmnc.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstvolume.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstvorbis.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstwasapi.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstwaveformsink.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstwavenc.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstwavpack.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstwavparse.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstwinscreencap.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstxingmux.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgsty4mdec.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgsty4menc.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstyadif.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libimageoverlay.dll lib/gstreamer-1.5/
#compatible to estos6.2
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libkmscoreplugins.dll lib/gstreamer-1.5/libkmscoreplugins.dll
#for estos6.3
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libkmscoreplugins.dll lib/gstreamer-1.5/libkmscore.dll
#compatible to estos6.2
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libkmselementsplugins.dll lib/gstreamer-1.5/libkmselementsplugins.dll
#for estos6.3
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libkmselementsplugins.dll lib/gstreamer-1.5/libkmselements.dll
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/liblogooverlay.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libmovementdetector.dll lib/gstreamer-1.5/
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libopencvfilter.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/librtcpdemux.dll lib/gstreamer-1.5/
#compatible to estos6.2
cp $CPPARAMS $PREF/lib/gstreamer-1.5/librtpendpoint.dll lib/gstreamer-1.5/librtpendpoint.dll
#for estos6.3
cp $CPPARAMS $PREF/lib/gstreamer-1.5/librtpendpoint.dll lib/gstreamer-1.5/libkmsrtpendpoint.dll
#cp $CPPARAMS $PREF/lib/gstreamer-1.5/libvp8parse.dll lib/gstreamer-1.5/
#compatible to estos6.2
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libwebrtcendpoint.dll lib/gstreamer-1.5/libwebrtcendpoint.dll
#for estos6.3
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libwebrtcendpoint.dll lib/gstreamer-1.5/libkmswebrtcendpoint.dll
#compatible to estos6.2
cp $CPPARAMS $PREF/lib/gstreamer-1.5/librecorderendpoint.dll lib/gstreamer-1.5/librecorderendpoint.dll
#for estos6.3
cp $CPPARAMS $PREF/lib/gstreamer-1.5/librecorderendpoint.dll lib/gstreamer-1.5/libkmsrecorderendpoint.dll
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstvpx.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/gstreamer-1.5/libgstlibav.dll lib/gstreamer-1.5/
cp $CPPARAMS $PREF/lib/kurento/modules/libkmscoremodule.dll lib/kurento/modules/
cp $CPPARAMS $PREF/lib/kurento/modules/libkmselementsmodule.dll lib/kurento/modules/
cp $CPPARAMS $PREF/lib/kurento/modules/libkmsfiltersmodule.dll lib/kurento/modules/
cp $CPPARAMS $PREF/etc/kurento/kurento.conf.json etc/kurento/
#sed -i 's/\/\/.*//' etc/kurento/kurento.conf.json
#sed -i 's/"resources": {/"resources": {\n"exceptionLimit": 0.99,/' etc/kurento/kurento.conf.json
sed -i 's/"\/\/exceptionLimit": "0.8"/"exceptionLimit": "0.99"/' etc/kurento/kurento.conf.json
#switch tls on
cp $CPPARAMS ../etc/defaultCertificate.pem etc/kurento/
sed -i 's/"\/\/secure": {/"secure": {/' etc/kurento/kurento.conf.json
sed -i 's/"\/\/port": 8433/"port": 8433/' etc/kurento/kurento.conf.json
sed -i 's/"\/\/certificate": "defaultCertificate.pem"/"certificate": "defaultCertificate.pem"/' etc/kurento/kurento.conf.json
sed -i 's/"\/\/password": ""/"password": ""/' etc/kurento/kurento.conf.json

cp $CPPARAMS $PREF/etc/kurento/modules/kurento/*.* etc/kurento/modules/kurento/

# replace configs and pack some additional files into the zip file
cp $CPPARAMS ../etc/SdpEndpoint.conf.json etc/kurento/modules/kurento/
cp $CPPARAMS ../etc/README.md .
cp $CPPARAMS ../etc/LICENSE-2.0.txt .
cp $CPPARAMS -R ../etc/liblicenses .
cp $CPPARAMS ../$actualcommitlogs .


# safe build timestamp into zip-file
rm emswindows*
touch emswindows_$actualbuilddate

# zip filename
zipfilename=emswindows_$actualbuilddate.zip

echo "zip -r ../$zipfilename *"
zip -r ../$zipfilename *
cd ..

# upload to buildserver if available
if [ -f  localupload ]; then
	echo "upload $zipfilename ..."
 	curl -F "kurentozip=@$zipfilename" build.estos.de/kurento
fi

# do a linefeed
echo



