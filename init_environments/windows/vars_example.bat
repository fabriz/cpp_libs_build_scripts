REM Number of parallel jobs for make
set FM_GLOBAL_NUM_PROCESSES=%NUMBER_OF_PROCESSORS%

REM Path of local tools
set FM_GLOBAL_CMAKE_INSTALL_PATH=C:\Program Files\CMake
set FM_GLOBAL_MINGW_32_INSTALL_PATH=C:\Qt\Tools\mingw730_32
set FM_GLOBAL_MINGW_64_INSTALL_PATH=C:\Qt\Tools\mingw730_64
set FM_GLOBAL_MSYS64_INSTALL_PATH=C:\msys64
set FM_GLOBAL_PERL_INSTALL_PATH=C:\Strawberry\perl
set FM_GLOBAL_MSVC2015_INSTALL_PATH=C:\Program Files (x86)\Microsoft Visual Studio 14.0
set FM_GLOBAL_MSVC2017_INSTALL_PATH=C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional
set FM_GLOBAL_MSVC2019_INSTALL_PATH=C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional

REM LAN cache configuration
REM set FM_GLOBAL_LAN_TARBALL_CACHE_USE=(NO|YES|ONLY)
REM set FM_GLOBAL_LAN_TARBALL_CACHE_GET_CMD=curl -u : -o "${DESTINATION_PATH}" "smb://SERVER/libs_cache/${TARBALL_NAME}"
REM set FM_GLOBAL_LAN_TARBALL_CACHE_GET_CMD=smbclient '"'"'\\SERVER\libs_cache'"'"' --no-pass -c "get \\${FM_SOURCE_TARBALL_NAME} ${FM_TARGET_TARBALL_PATH}"

set FM_GLOBAL_TARBALL_CACHE=/c/libs_build/cache
set FM_GLOBAL_BUILD_ROOT=/c/libs_build/build
set FM_GLOBAL_DEPLOY_ROOT=/c/libs

REM Optional commands to execute when the build completes
REM set FM_GLOBAL_ON_BUILD_SUCCESS=
REM set FM_GLOBAL_ON_BUILD_ERROR=

REM To disable certificate validation:
REM set FM_GLOBAL_OPTION_DISABLE_SSL_CERTIFICATE_VALIDATION=true
