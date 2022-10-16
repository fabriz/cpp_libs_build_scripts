@echo off

set FM_PATH_ENVIRONMENT_INIT_SCRIPT_DIRECTORY=%~dp0

call "%FM_PATH_ENVIRONMENT_INIT_SCRIPT_DIRECTORY%\vars.bat"

set PATH=%FM_CONFIG_MSYS64_INSTALL_PATH%\usr\local\bin;^
%FM_CONFIG_MSYS64_INSTALL_PATH%\usr\bin;^
%FM_CONFIG_MSYS64_INSTALL_PATH%\bin;^
%FM_CONFIG_MSYS64_INSTALL_PATH%\opt\bin;^
%PATH%

set FM_TARGET_OS_TYPE=windows
set FM_TARGET_COMPILER=msvc
set FM_TARGET_COMPILER_VERSION=14.1
set FM_TARGET_TOOLCHAIN=windows_msvc
set FM_TARGET_PLATFORM=windows_msvc2017
set FM_TARGET_HAS_PKGCONFIG=false
set FM_TARGET_ALL_ARCHITECTURES=x86
set FM_TARGET_ALL_BUILD_VARIANTS=debug,release,profile

if /i "%FM_CONFIG_USE_JOM%"=="true" (
    echo Using jom instead of nmake
    set FM_CONFIG_NMAKE_COMMAND=jom.exe
    set FM_TARGET_CMAKE_GENERATOR=NMake Makefiles JOM
    set "PATH=%FM_CONFIG_JOM_INSTALL_PATH%;%PATH%"
) else (
    set FM_CONFIG_NMAKE_COMMAND=nmake
    set FM_TARGET_CMAKE_GENERATOR=NMake Makefiles
)

call "%FM_CONFIG_MSVC2017_INSTALL_PATH%\VC\Auxiliary\Build\vcvars32.bat"

call "%FM_PATH_ENVIRONMENT_INIT_SCRIPT_DIRECTORY%\start_bash.bat"
