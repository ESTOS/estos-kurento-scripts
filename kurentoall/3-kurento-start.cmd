SETLOCAL
set KMS_DIRECTORY=x:\dev\estos-kurento-scripts\kurentoall\kmswindows
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\INetCache\gstreamer-1.0\registry.x86_64-mingw.bin
rem set NICE_DEBUG="stun,nice,pseudotcp,pseudotcp-verbose,nice-verbose"
rem set G_MESSAGES_DEBUG="libnice-stun,libnice,libnice-pseudotcp,libnice-pseudotcp-verbose,libnice-verbose,libnice-timer-verbose,udpsrcrxrtp,rtpsessiontxrtp"
rem set G_MESSAGES_DEBUG="rtpsessiontxrtp"

set GSTDEBUGLEVEL=3
set GSTDEBUG=kms*:6,Kurento*:5
rem set GSTDEBUG=kms*:6,Kurento*:5,GST_REGISTRY:7

%KMS_DIRECTORY%\bin\uc-media-server.exe -d %KMS_DIRECTORY%\log -s 500 -n 5 --gst-debug-level=%GSTDEBUGLEVEL% --gst-debug=donttouchenv:1,%GSTDEBUG% 2> %KMS_DIRECTORY%\log\log.txt

pause

ENDLOCAL

exit 0


