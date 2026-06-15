@echo off
rem x:\dev\tools\mingw\msys64\usr\bin\bash.exe -lc "/x/dev/estos-kurento-scripts/kurentoall/1-buildmain.sh build_kurento"
set BASH=x:\dev\tools\mingw\msys64\usr\bin\bash.exe
set CHERE_INVOKING=1
set MSYSTEM=MINGW64
set SCRIPTPATH=/x/dev/estos-kurento-scripts/kurentoall

if "%~1"=="" (
    echo Usage:
    echo   4-run.cmd ^<script.sh^> [param1]
rem    echo.
    echo Example:
    echo   start.cmd build.sh release
    exit /b 1
)

set SCRIPT=%1
shift

rem %BASH% -lc "%SCRIPTPATH%/%SCRIPT% %*"
%BASH% -lc "%SCRIPTPATH%/%SCRIPT% %1"
rem pause
