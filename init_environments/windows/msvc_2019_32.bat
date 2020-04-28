@echo off

set FM_SCRIPT_PATH=%~dp0

call "vars.bat"

set FM_GLOBAL_HOST=windows
set FM_GLOBAL_COMPILER=msvc2019
set FM_GLOBAL_TOOLCHAIN=%FM_GLOBAL_HOST%_%FM_GLOBAL_COMPILER%
set FM_GLOBAL_ARCHITECTURE=i386

set PATH=%FM_GLOBAL_CMAKE_INSTALL_PATH%\bin;^
%FM_GLOBAL_MSYS64_INSTALL_PATH%\usr\local\bin;^
%FM_GLOBAL_MSYS64_INSTALL_PATH%\usr\bin;^
%FM_GLOBAL_MSYS64_INSTALL_PATH%\bin;^
%FM_GLOBAL_MSYS64_INSTALL_PATH%\opt\bin;^
%PATH%

call "%FM_GLOBAL_MSVC2019_INSTALL_PATH%\VC\Auxiliary\Build\vcvars32.bat"

cd /D %FM_SCRIPT_PATH%\..\..

echo.
echo To build all libraries:
echo ./build_libset.sh latest debug,release
echo.
echo To build a single library:
echo ./build_lib.sh "LIBNAME/LIBVERSION" debug,release
echo.

%FM_GLOBAL_MSYS64_INSTALL_PATH%\usr\bin\bash.exe