rem @echo off
call :main > build-release.log 2>&1
goto :eof

:main
echo %DATE% %TIME%
rem git archive --remote="ssh://git@gitlab.estos.de/estos/windows-global/tools.git" --format=zip feature/PROCALL-3103-msys-build mingw/msys64.zip > msys64.zip
rem get it from remote with a tag or branch
rem git archive --remote="ssh://git@gitlab.estos.de/estos/windows-global/tools.git" --format=tar ee8c3ae4 mingw/msys64.zip | tar -xO > msys64.zip
rem get it from local with a hash
git -C x:\dev\tools show ee8c3ae442a7e38b73246d71f0893b525e8d9967:mingw/msys64-clang.zip > msys64-clang.zip
if exist msys64 rmdir /s /q msys64
unzip msys64-clang.zip
rem x:\dev\tools\mingw\msys64\usr\bin\bash.exe -lc "/x/dev/estos-kurento-scripts/kurentoall/1-buildmain.sh build_kurento"
rem set BASH=x:\dev\tools\mingw\msys64\usr\bin\bash.exe
set BASH=x:\dev\estos-kurento-scripts\kurentoall\msys64\usr\bin\bash.exe
set CHERE_INVOKING=1
set MSYSTEM=CLANG64
set SCRIPTPATH=/x/dev/estos-kurento-scripts/kurentoall

rem %BASH% -lc "ls -la"
%BASH% -lc "%SCRIPTPATH%/1-buildmain-clang.sh buildalllog"
%BASH% -lc "%SCRIPTPATH%/2.0-buildcopykmswindows-clang.sh minimal"
%BASH% -lc "%SCRIPTPATH%/2.1-builddist.sh"

echo %DATE% %TIME%
