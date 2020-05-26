echo "4. Prepare distribution package"

actualbuilddate=`date "+%Y%m%d_%H%M%S_%N"`
actualcommitlogs=lastcommitlogs_$actualbuilddate

source ./lastcommits.sh
cp --preserve=timestamps lastcommits_actual.txt $actualcommitlogs

export PREF=/usr/x86_64-w64-mingw32/sys-root/mingw
rm -rf dist64
mkdir dist64
cd dist64
mkdir -p bin/
mkdir -p lib/gstreamer-1.5/
mkdir -p lib/kurento/modules/
mkdir -p etc/kurento/
mkdir -p etc/kurento/modules/
mkdir -p etc/kurento/modules/kurento

export PREF=/usr/x86_64-w64-mingw32/sys-root/mingw
cp --preserve=timestamps $PREF/bin/kurento-media-server.exe bin/uc-media-server.exe
cp --preserve=timestamps $PREF/bin/libpcre-1.dll bin/
cp --preserve=timestamps $PREF/bin/iconv.dll bin/
# cp --preserve=timestamps $PREF/bin/libatk-1.0-0.dll bin/
cp --preserve=timestamps $PREF/bin/libboost_filesystem-mt.dll bin/
cp --preserve=timestamps $PREF/bin/libboost_log-mt.dll bin/
cp --preserve=timestamps $PREF/bin/libboost_log_setup-mt.dll bin/
cp --preserve=timestamps $PREF/bin/libboost_program_options-mt.dll bin/
cp --preserve=timestamps $PREF/bin/libboost_regex-mt.dll bin/
cp --preserve=timestamps $PREF/bin/libboost_system-mt.dll bin/
cp --preserve=timestamps $PREF/bin/libboost_thread-mt.dll bin/
cp --preserve=timestamps $PREF/bin/libbz2-1.dll bin/
# cp --preserve=timestamps $PREF/bin/libcairo-2.dll bin/
# cp --preserve=timestamps $PREF/bin/libcairo-gobject-2.dll bin/
cp --preserve=timestamps $PREF/bin/libcrypto-10.dll bin/
# libeay32.dll == libcrypto-10.dll -> need it with debug libssl-10.dll
# cp --preserve=timestamps $PREF/bin/libcrypto-10.dll bin/libeay32.dll
# cp --preserve=timestamps $PREF/bin/libepoxy-0.dll bin/
cp --preserve=timestamps $PREF/bin/libexpat-1.dll bin/
cp --preserve=timestamps $PREF/bin/libffi-6.dll bin/
# cp --preserve=timestamps $PREF/bin/libfontconfig-1.dll bin/
# cp --preserve=timestamps $PREF/bin/libfreetype-6.dll bin/
#32Bit
#cp --preserve=timestamps $PREF/bin/libgcc_s_sjlj-1.dll bin/
#64Bit
cp --preserve=timestamps $PREF/bin/libgcc_s_seh-1.dll bin/
# cp --preserve=timestamps $PREF/bin/libgdk-3-0.dll bin/
# cp --preserve=timestamps $PREF/bin/libgdk_pixbuf-2.0-0.dll bin/
cp --preserve=timestamps $PREF/bin/libgio-2.0-0.dll bin/
cp --preserve=timestamps $PREF/bin/libglib-2.0-0.dll bin/
cp --preserve=timestamps $PREF/bin/libglibmm-2.4-1.dll bin/
cp --preserve=timestamps $PREF/bin/libgmodule-2.0-0.dll bin/
cp --preserve=timestamps $PREF/bin/libgobject-2.0-0.dll bin/
#cp --preserve=timestamps $PREF/bin/libgsm-1.dll bin/
cp --preserve=timestamps $PREF/bin/libgstadaptivedemux-1.5-0.dll bin/
cp --preserve=timestamps $PREF/bin/libgstapp-1.5-0.dll bin/
cp --preserve=timestamps $PREF/bin/libgstaudio-1.5-0.dll bin/
# cp --preserve=timestamps $PREF/bin/libgstbadaudio-1.5-0.dll bin/
# cp --preserve=timestamps $PREF/bin/libgstbadbase-1.5-0.dll bin/
# cp --preserve=timestamps $PREF/bin/libgstbadvideo-1.5-0.dll bin/
cp --preserve=timestamps $PREF/bin/libgstbase-1.5-0.dll bin/
# cp --preserve=timestamps $PREF/bin/libgstbasecamerabinsrc-1.5-0.dll bin/
# cp --preserve=timestamps $PREF/bin/libgstcodecparsers-1.5-0.dll bin/
# cp --preserve=timestamps $PREF/bin/libgstfft-1.5-0.dll bin/
# cp --preserve=timestamps $PREF/bin/libgstgl-1.5-0.dll bin/
# cp --preserve=timestamps $PREF/bin/libgstmpegts-1.5-0.dll bin/
cp --preserve=timestamps $PREF/bin/libgstnet-1.5-0.dll bin/
cp --preserve=timestamps $PREF/bin/libgstpbutils-1.5-0.dll bin/
# cp --preserve=timestamps $PREF/bin/libgstphotography-1.5-0.dll bin/
cp --preserve=timestamps $PREF/bin/libgstreamer-1.5-0.dll bin/
cp --preserve=timestamps $PREF/bin/libgstriff-1.5-0.dll bin/
cp --preserve=timestamps $PREF/bin/libgstrtp-1.5-0.dll bin/
cp --preserve=timestamps $PREF/bin/libgstrtsp-1.5-0.dll bin/
cp --preserve=timestamps $PREF/bin/libgstsctp-1.5.dll bin/
cp --preserve=timestamps $PREF/bin/libgstsdp-1.5-0.dll bin/
cp --preserve=timestamps $PREF/bin/libgsttag-1.5-0.dll bin/
cp --preserve=timestamps $PREF/bin/libgsturidownloader-1.5-0.dll bin/ # adaptivedemux need this
cp --preserve=timestamps $PREF/bin/libgstvideo-1.5-0.dll bin/
# cp --preserve=timestamps $PREF/bin/libgtk-3-0.dll bin/
# cp --preserve=timestamps $PREF/bin/libHalf-12.dll bin/
cp --preserve=timestamps $PREF/bin/libIex-2_2-12.dll bin/
# cp --preserve=timestamps $PREF/bin/libIlmImf-2_2-22.dll bin/
# cp --preserve=timestamps $PREF/bin/libIlmThread-2_2-12.dll bin/
cp --preserve=timestamps $PREF/bin/libintl-8.dll bin/
# cp --preserve=timestamps $PREF/bin/libjasper-1.dll bin/
# cp --preserve=timestamps $PREF/bin/libjpeg-62.dll bin/
cp --preserve=timestamps $PREF/bin/libjsonrpc.dll bin/
cp --preserve=timestamps $PREF/bin/libkmscoreimpl.dll bin/
cp --preserve=timestamps $PREF/bin/libkmselementsimpl.dll bin/
cp --preserve=timestamps $PREF/bin/libkmsfiltersimpl.dll bin/
cp --preserve=timestamps $PREF/bin/libkmsgstcommons.dll bin/
cp --preserve=timestamps $PREF/bin/libkmsjsoncpp.dll bin/
#cp --preserve=timestamps $PREF/bin/libkmsrtpsync.dll bin/
cp --preserve=timestamps $PREF/bin/libkmssdpagent.dll bin/
cp --preserve=timestamps $PREF/bin/libkmswebrtcendpointlib.dll bin/
#if [ -f $PREF/bin/libnettle-6-2.dll ]; then
#	cp --preserve=timestamps $PREF/bin/libnettle-6-2.dll bin/
#else
#	cp --preserve=timestamps $PREF/bin/libnettle-6.dll bin/
#fi
cp --preserve=timestamps $PREF/bin/libnice-10.dll bin/
# cp --preserve=timestamps $PREF/bin/libogg-0.dll bin/
# cp --preserve=timestamps $PREF/bin/libopencv_core2413.dll bin/
# cp --preserve=timestamps $PREF/bin/libopencv_highgui2413.dll bin/
# cp --preserve=timestamps $PREF/bin/libopencv_imgproc2413.dll bin/
# cp --preserve=timestamps $PREF/bin/libopencv_objdetect2413.dll bin/
cp --preserve=timestamps $PREF/bin/libopus-0.dll bin/
cp --preserve=timestamps $PREF/bin/liborc-0.4-0.dll bin/
cp --preserve=timestamps $PREF/bin/liborc-test-0.4-0.dll bin/
# cp --preserve=timestamps $PREF/bin/libpango-1.0-0.dll bin/
# cp --preserve=timestamps $PREF/bin/libpangocairo-1.0-0.dll bin/
# cp --preserve=timestamps $PREF/bin/libpangowin32-1.0-0.dll bin/
# cp --preserve=timestamps $PREF/bin/libpixman-1-0.dll bin/
# cp --preserve=timestamps $PREF/bin/libpng16-16.dll bin/
cp --preserve=timestamps $PREF/bin/libsigc-2.0-0.dll bin/
cp --preserve=timestamps $PREF/bin/libsoup-2.4-1.dll bin/
cp --preserve=timestamps $PREF/bin/libspeex-1.dll bin/
cp --preserve=timestamps $PREF/bin/libsqlite3-0.dll bin/
cp --preserve=timestamps $PREF/bin/libssl-10.dll bin/
cp --preserve=timestamps $PREF/bin/libstdc++-6.dll bin/
# cp --preserve=timestamps $PREF/bin/libtiff-5.dll bin/
# cp --preserve=timestamps $PREF/bin/libvorbis-0.dll bin/
# cp --preserve=timestamps $PREF/bin/libvorbisenc-2.dll bin/
# cp --preserve=timestamps $PREF/bin/libwavpack-1.dll bin/
cp --preserve=timestamps $PREF/bin/libwebrtcdataproto.dll bin/
cp --preserve=timestamps $PREF/bin/libwinpthread-1.dll bin/
cp --preserve=timestamps $PREF/bin/libxml2-2.dll bin/
cp --preserve=timestamps $PREF/bin/zlib1.dll bin/

#used for gnutls in libnice - mingw32-gnutls
cp --preserve=timestamps $PREF/bin/libgmp-10.dll bin/
cp --preserve=timestamps $PREF/bin/libgnutls-30.dll bin/
cp --preserve=timestamps $PREF/bin/libhogweed-4.dll bin/
cp --preserve=timestamps $PREF/bin/libnettle-6.dll bin/
cp --preserve=timestamps $PREF/bin/libp11-kit-0.dll bin/
cp --preserve=timestamps $PREF/bin/libtasn1-6.dll bin/
#used for gnutls in libnice - mingw32-libidn2
cp --preserve=timestamps $PREF/bin/libidn2-0.dll bin/

# cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libfacedetector.dll lib/gstreamer-1.5/
# cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libfaceoverlay.dll lib/gstreamer-1.5/
# cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstaccurip.dll lib/gstreamer-1.5/
# cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstadder.dll lib/gstreamer-1.5/
# cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstadpcmdec.dll lib/gstreamer-1.5/
# cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstadpcmenc.dll lib/gstreamer-1.5/
# cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstaiff.dll lib/gstreamer-1.5/
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstalaw.dll lib/gstreamer-1.5/
# cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstalpha.dll lib/gstreamer-1.5/
# cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstalphacolor.dll lib/gstreamer-1.5/
# cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstapetag.dll lib/gstreamer-1.5/
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstapp.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstasf.dll lib/gstreamer-1.5/
# cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstasfmux.dll lib/gstreamer-1.5/
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstaudioconvert.dll lib/gstreamer-1.5/
# cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstaudiofx.dll lib/gstreamer-1.5/
# cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstaudiofxbad.dll lib/gstreamer-1.5/
# cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstaudiomixer.dll lib/gstreamer-1.5/
# cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstaudioparsers.dll lib/gstreamer-1.5/
# cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstaudiorate.dll lib/gstreamer-1.5/
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstaudioresample.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstaudiotestsrc.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstaudiovisualizers.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstauparse.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstautoconvert.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstautodetect.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstavi.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstbayer.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstbz2.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstcairo.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstcamerabin2.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstcoloreffects.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstcompositor.dll lib/gstreamer-1.5/
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstcoreelements.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstcoretracers.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstcutter.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstd3dvideosink.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstdashdemux.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstdataurisrc.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstdebug.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstdebugutilsbad.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstdeinterlace.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstdirectsoundsink.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstdirectsoundsrc.dll lib/gstreamer-1.5/
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstdtls.dll lib/gstreamer-1.5/
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstdtmf.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstdvbsuboverlay.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstdvdlpcmdec.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstdvdspu.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstdvdsub.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgsteffectv.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstencodebin.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstequalizer.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstfestival.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstfieldanalysis.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstflv.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstflxdec.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstfreeverb.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstfrei0r.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstgaudieffects.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstgdkpixbuf.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstgdp.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstgeometrictransform.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstgio.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstgoom.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstgoom2k1.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstgsm.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstgtksink.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgsthls.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgsticydemux.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstid3demux.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstid3tag.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstimagefreeze.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstinter.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstinterlace.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstinterleave.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstisomp4.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstivfparse.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstivtc.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstjp2kdecimator.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstjpeg.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstjpegformat.dll lib/gstreamer-1.5/
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstlevel.dll lib/gstreamer-1.5/
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstmatroska.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstmidi.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstmpegpsdemux.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstmpegpsmux.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstmpegtsdemux.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstmpegtsmux.dll lib/gstreamer-1.5/
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstmulaw.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstmultifile.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstmultipart.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstmxf.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstnavigationtest.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstnetsim.dll lib/gstreamer-1.5/
#compatible to estos6.2
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstnice15.dll lib/gstreamer-1.5/libgstnice15.dll
#for estos6.3
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstnice15.dll lib/gstreamer-1.5/libgstnice.dll
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstogg.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstopenexr.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstopengl.dll lib/gstreamer-1.5/
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstopus.dll lib/gstreamer-1.5/
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstopusparse.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstpango.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstpcapparse.dll lib/gstreamer-1.5/
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstplayback.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstpng.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstpnm.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstrawparse.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstremovesilence.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstreplaygain.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstrfbsrc.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstrmdemux.dll lib/gstreamer-1.5/
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstrtp.dll lib/gstreamer-1.5/
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstrtpmanager.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstrtponvif.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstrtsp.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstsdpelem.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstsegmentclip.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstshapewipe.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstsiren.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstsmooth.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstsmoothstreaming.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstsmpte.dll lib/gstreamer-1.5/
#compatible to estos6.2 -> dont copy for 6.3 else we get an error in at startup
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstsouphttpsrc.dll lib/gstreamer-1.5/libgstsouphttpsrc.dll
#for estos6.3
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstsouphttpsrc.dll lib/gstreamer-1.5/libgstsoup.dll
#for 64bit???
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstsoup.dll lib/gstreamer-1.5/libgstsoup.dll
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstspectrum.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstspeed.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstspeex.dll lib/gstreamer-1.5/
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstsrtp.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgststereo.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstsubenc.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstsubparse.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgsttcp.dll lib/gstreamer-1.5/
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgsttypefindfunctions.dll lib/gstreamer-1.5/
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstudp.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstvideobox.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstvideoconvert.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstvideocrop.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstvideofilter.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstvideofiltersbad.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstvideoframe_audiolevel.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstvideomixer.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstvideoparsersbad.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstvideorate.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstvideorepair.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstvideoscale.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstvideosignal.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstvideotestsrc.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstvmnc.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstvolume.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstvorbis.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstwasapi.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstwaveformsink.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstwavenc.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstwavpack.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstwavparse.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstwinscreencap.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstxingmux.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgsty4mdec.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgsty4menc.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libgstyadif.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libimageoverlay.dll lib/gstreamer-1.5/
#compatible to estos6.2
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libkmscoreplugins.dll lib/gstreamer-1.5/libkmscoreplugins.dll
#for estos6.3
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libkmscoreplugins.dll lib/gstreamer-1.5/libkmscore.dll
#compatible to estos6.2
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libkmselementsplugins.dll lib/gstreamer-1.5/libkmselementsplugins.dll
#for estos6.3
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libkmselementsplugins.dll lib/gstreamer-1.5/libkmselements.dll
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/liblogooverlay.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libmovementdetector.dll lib/gstreamer-1.5/
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libopencvfilter.dll lib/gstreamer-1.5/
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/librtcpdemux.dll lib/gstreamer-1.5/
#compatible to estos6.2
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/librtpendpoint.dll lib/gstreamer-1.5/librtpendpoint.dll
#for estos6.3
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/librtpendpoint.dll lib/gstreamer-1.5/libkmsrtpendpoint.dll
#cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libvp8parse.dll lib/gstreamer-1.5/
#compatible to estos6.2
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libwebrtcendpoint.dll lib/gstreamer-1.5/libwebrtcendpoint.dll
#for estos6.3
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/libwebrtcendpoint.dll lib/gstreamer-1.5/libkmswebrtcendpoint.dll
#compatible to estos6.2
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/librecorderendpoint.dll lib/gstreamer-1.5/librecorderendpoint.dll
#for estos6.3
cp --preserve=timestamps $PREF/lib/gstreamer-1.5/librecorderendpoint.dll lib/gstreamer-1.5/libkmsrecorderendpoint.dll
cp --preserve=timestamps $PREF/lib/kurento/modules/libkmscoremodule.dll lib/kurento/modules/
cp --preserve=timestamps $PREF/lib/kurento/modules/libkmselementsmodule.dll lib/kurento/modules/
cp --preserve=timestamps $PREF/lib/kurento/modules/libkmsfiltersmodule.dll lib/kurento/modules/
cp --preserve=timestamps $PREF/etc/kurento/kurento.conf.json etc/kurento/
#sed -i 's/\/\/.*//' etc/kurento/kurento.conf.json
#sed -i 's/"resources": {/"resources": {\n"exceptionLimit": 0.99,/' etc/kurento/kurento.conf.json
sed -i 's/"\/\/exceptionLimit": "0.8"/"exceptionLimit": "0.99"/' etc/kurento/kurento.conf.json
#switch tls on
cp --preserve=timestamps ../etc/defaultCertificate.pem etc/kurento/
sed -i 's/"\/\/secure": {/"secure": {/' etc/kurento/kurento.conf.json
sed -i 's/"\/\/port": 8433/"port": 8433/' etc/kurento/kurento.conf.json
sed -i 's/"\/\/certificate": "defaultCertificate.pem"/"certificate": "defaultCertificate.pem"/' etc/kurento/kurento.conf.json
sed -i 's/"\/\/password": ""/"password": ""/' etc/kurento/kurento.conf.json

cp --preserve=timestamps $PREF/etc/kurento/modules/kurento/*.* etc/kurento/modules/kurento/

# replace configs and pack some additional files into the zip file
cp --preserve=timestamps ../etc/SdpEndpoint.conf.json etc/kurento/modules/kurento/
cp --preserve=timestamps ../etc/README.md .
cp --preserve=timestamps ../etc/LICENSE-2.0.txt .
cp --preserve=timestamps -R ../etc/liblicenses .
cp --preserve=timestamps ../$actualcommitlogs .


# safe build timestamp into zip-file
rm emswindows64*
touch emswindows64_$actualbuilddate

# zip filename
zipfilename=emswindows64_$actualbuilddate.zip

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



