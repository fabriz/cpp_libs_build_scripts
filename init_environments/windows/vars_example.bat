REM Number of parallel jobs for make
set FM_CONFIG_NUM_PROCESSES=%NUMBER_OF_PROCESSORS%

REM C++ standard version (14|17)
set FM_CONFIG_CXX_STANDARD=17

REM Path of local tools
set FM_CONFIG_CMAKE_COMMAND=C:\Program Files\CMake\bin\cmake.exe
set FM_CONFIG_CURL_COMMAND=/usr/bin/curl
set FM_CONFIG_PERL_COMMAND=/usr/bin/perl
set FM_CONFIG_PERL_WINDOWS_COMMAND=C:\Strawberry\perl\bin\perl.exe
set FM_CONFIG_PYTHON_COMMAND=/usr/bin/python
set FM_CONFIG_PYTHON_WINDOWS_COMMAND=C:\Program Files\Python39\python.exe
set FM_CONFIG_TAR_COMMAND=/usr/bin/tar
set FM_CONFIG_PATCH_COMMAND=/usr/bin/patch

REM MSYS environment installation path
set FM_CONFIG_MSYS64_INSTALL_PATH=C:\msys64

REM MinGW toolchains installation paths
REM set FM_CONFIG_MINGW_32_INSTALL_PATH=C:\msys64\mingw32
REM set FM_CONFIG_MINGW_64_INSTALL_PATH=C:\msys64\mingw64
REM set FM_CONFIG_MINGW_32_INSTALL_PATH=C:\Qt\Tools\mingw810_32
REM set FM_CONFIG_MINGW_64_INSTALL_PATH=C:\Qt\Tools\mingw810_64

REM Visual Studio toolchains installation paths
REM set FM_CONFIG_MSVC2015_INSTALL_PATH=C:\Program Files (x86)\Microsoft Visual Studio 14.0
REM set FM_CONFIG_MSVC2017_INSTALL_PATH=C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional
REM set FM_CONFIG_MSVC2017_INSTALL_PATH=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community
REM set FM_CONFIG_MSVC2019_INSTALL_PATH=C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional
REM set FM_CONFIG_MSVC2019_INSTALL_PATH=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community

REM Use jom instead on nmake for Visual Studio builds
REM set FM_CONFIG_USE_JOM=true
REM set FM_CONFIG_JOM_INSTALL_PATH=C:\Qt\Tools\QtCreator\bin\jom

REM LAN cache configuration
REM set FM_CONFIG_LAN_TARBALL_CACHE_USE=(NO|YES|ONLY)
REM set FM_CONFIG_LAN_TARBALL_CACHE_GET_CMD=curl -u : -o "${DESTINATION_PATH}" "smb://SERVER/libs_cache/${TARBALL_NAME}"
REM set FM_CONFIG_LAN_TARBALL_CACHE_GET_CMD=smbclient '"'"'\\SERVER\libs_cache'"'"' --no-pass -c "get \\${FM_SOURCE_TARBALL_NAME} ${FM_TARGET_TARBALL_PATH}"

REM Working directories
set FM_CONFIG_TARBALL_CACHE=/c/libs_build/cache
set FM_CONFIG_BUILD_ROOT=/c/libs_build/build
set FM_CONFIG_DEPLOY_ROOT=/c/libs

REM Optional commands to execute when the build completes
REM set FM_CONFIG_ON_BUILD_SUCCESS=
REM set FM_CONFIG_ON_BUILD_ERROR=

REM Uncomment to increase the log verbosity
REM set FM_CONFIG_VERBOSE_LOGS=true

REM Uncomment to deploy the provided cmake find modules
REM set FM_CONFIG_DEPLOY_CMAKE_FIND_MODULES=true

REM Uncomment to disable certificate validation
REM set FM_CONFIG_DISABLE_SSL_CERTIFICATE_VALIDATION=true
