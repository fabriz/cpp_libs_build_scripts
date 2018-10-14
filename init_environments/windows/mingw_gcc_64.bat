@echo off

set FM_SCRIPT_PATH=%~dp0

call "windows_vars.bat"

set FM_GLOBAL_HOST=windows
set FM_GLOBAL_COMPILER=mingw
set FM_GLOBAL_COMPILER_VERSION=%FM_GLOBAL_MINGW_64_VERSION%
set FM_GLOBAL_ARCHITECTURE=x64

set PATH=%FM_GLOBAL_MINGW_64_INSTALL_PATH%\bin;%FM_GLOBAL_CMAKE_INSTALL_PATH%\bin;%PATH%;%FM_GLOBAL_MSYS64_INSTALL_PATH%\usr\local\bin;%FM_GLOBAL_MSYS64_INSTALL_PATH%\usr\bin;%FM_GLOBAL_MSYS64_INSTALL_PATH%\bin;%FM_GLOBAL_MSYS64_INSTALL_PATH%\opt\bin

cd /D %FM_SCRIPT_PATH%\..\..

echo.
echo To build all libraries:
echo ./build_all.sh %FM_GLOBAL_HOST%_%FM_GLOBAL_COMPILER% %FM_GLOBAL_ARCHITECTURE% debug,release
echo.
echo To build a single library:
echo cd libs
echo ./nnnn_build_libname.sh %FM_GLOBAL_HOST%_%FM_GLOBAL_COMPILER% %FM_GLOBAL_ARCHITECTURE% debug,release
echo.

%FM_GLOBAL_MSYS64_INSTALL_PATH%\usr\bin\bash.exe
