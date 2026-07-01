rem @echo off
@echo 
rem git archive --remote="ssh://git@gitlab.estos.de/estos/windows-global/tools.git" --format=zip feature/PROCALL-3103-msys-build mingw/msys64.zip > msys64.zip
rem get it from remote with a tag or branch
rem git archive --remote="ssh://git@gitlab.estos.de/estos/windows-global/tools.git" --format=tar a7bc6893 mingw/msys64.zip | tar -xO > msys64.zip
rem get it from local with a hash
git -C x:\dev\tools show a7bc6893:mingw/msys64.zip > msys64.zip
unzip msys64.zip
rem x:\dev\tools\mingw\msys64\usr\bin\bash.exe -lc "/x/dev/estos-kurento-scripts/kurentoall/1-buildmain.sh build_kurento"
rem set BASH=x:\dev\tools\mingw\msys64\usr\bin\bash.exe
set BASH=x:\dev\estos-kurento-scripts\kurentoall\mingw\msys64\usr\bin\bash.exe
set CHERE_INVOKING=1
set MSYSTEM=MINGW64
set SCRIPTPATH=/x/dev/estos-kurento-scripts/kurentoall

%BASH% -lc "%SCRIPTPATH%/1-buildmain.sh buildalllog"
%BASH% -lc "%SCRIPTPATH%/2.0-buildcopykmswindows.sh"
%BASH% -lc "%SCRIPTPATH%/2.1-builddist.sh"

