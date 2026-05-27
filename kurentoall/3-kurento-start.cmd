SETLOCAL
set KMS_DIRECTORY=x:\dev\estos-kurento-scripts\kurentoall\kmswindows
rem MSYS2 mingw64 prefix (Python/GStreamer are linked against this tree)
rem set MSYS_MINGW64=x:\dev\tools\mingw\msys64\mingw64

del "%LOCALAPPDATA%\gstreamer-1.0\registry.x86_64-mingw.bin" 2>nul
rem set NICE_DEBUG="stun,nice,pseudotcp,pseudotcp-verbose,nice-verbose"
rem set G_MESSAGES_DEBUG="libnice-stun,libnice,libnice-pseudotcp,libnice-pseudotcp-verbose,libnice-verbose,libnice-timer-verbose,udpsrcrxrtp,rtpsessiontxrtp"
rem set G_MESSAGES_DEBUG="rtpsessiontxrtp"

rem Embedded Python in GStreamer/GES expects MSYS2 stdlib (encodings etc.).
rem Without PYTHONHOME it falls back to CI path D:\a\msys64\mingw64 from MSYS2 packages.
rem set PYTHONHOME=%MSYS_MINGW64%
set PATH=%KMS_DIRECTORY%\bin;%PATH%
rem Only GStreamer MODULE plugins — never bin\ (shared libs + false plugin scans)
set GST_PLUGIN_PATH=%KMS_DIRECTORY%\lib\gstreamer-1.0\kurento;%KMS_DIRECTORY%\lib\gstreamer-1.0

set GSTDEBUGLEVEL=3
set GSTDEBUG=kms*:6,Kurento*:5
rem set GSTDEBUG=kms*:6,Kurento*:5,GST_REGISTRY:7

if not exist "%KMS_DIRECTORY%\log" mkdir "%KMS_DIRECTORY%\log"
cd /d %KMS_DIRECTORY%\bin
%KMS_DIRECTORY%\bin\uc-media-server.exe -d %KMS_DIRECTORY%\log -s 500 -n 5 --gst-debug-level=%GSTDEBUGLEVEL% --gst-debug=donttouchenv:1,%GSTDEBUG% 2> %KMS_DIRECTORY%\log\log.txt

pause

ENDLOCAL

exit 0
