# Variables documentation

### Mandatory library version variables


Name | Description
---- | -----------
FM_<LIBRARY>_NAME | Library name.
FM_<LIBRARY>_VERSION | Library version.
FM_<LIBRARY>_FULL_NAME | Full versioned name of the library.
FM_<LIBRARY>_TARBALL_NAME | Name of the tarball file.
FM_<LIBRARY>_TARBALL_DOWNLOAD_URL | Url from which the tarball file can be downloaded.
FM_<LIBRARY>_INSTALL_CHECK | Name of a representative header file of the library to check if the library is already built.
FM_<LIBRARY>_HASH | Hash of the library tarball.
FM_<LIBRARY>_HASH_TYPE | Type of hash function used. Supported hash functions are: MD5, SHA-1, SHA-256, SHA-512.

As a simplified example consider the following:

    FM_ZLIB_NAME="zlib"
    FM_ZLIB_VERSION="1.2.11"
    FM_ZLIB_FULL_NAME="zlib-1.2.11"
    FM_ZLIB_TARBALL_NAME="zlib-1.2.11.tar.gz"
    FM_ZLIB_TARBALL_DOWNLOAD_URL="https://zlib.net/zlib-1.2.11.tar.gz"
    FM_ZLIB_INSTALL_CHECK="include/zlib.h"
    FM_ZLIB_HASH="c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1"
    FM_ZLIB_HASH_TYPE="SHA-256"

Real configuration files reuse other variables as much as possible:

    export FM_ZLIB_NAME="zlib"
    export FM_ZLIB_VERSION="1.2.11"
    export FM_ZLIB_FULL_NAME="${FM_ZLIB_NAME}-${FM_ZLIB_VERSION}"
    export FM_ZLIB_TARBALL_NAME="${FM_ZLIB_FULL_NAME}.tar.gz"
    export FM_ZLIB_TARBALL_DOWNLOAD_URL="https://zlib.net/${FM_ZLIB_TARBALL_NAME}"
    export FM_ZLIB_INSTALL_CHECK="include/zlib.h"
    export FM_ZLIB_HASH="c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1"
    export FM_ZLIB_HASH_TYPE="SHA-256"


### Optional library version variables

Name | Description
---- | -----------
FM_<LIBRARY>_UNTAR_DIR | Name of the directory produced by decompressing the tarball. To be specified only if different from ${FM_<LIBRARY>_FULL_NAME}.
FM_<LIBRARY>_UNTAR_FLAGS | Additional flags to pass to the decompression command. Normallly used to exclude some files.


### Variables set during the build of a specific library

Name | Description
---- | -----------
FM_CURRENT_LIB_NAME | Library name.
FM_CURRENT_LIB_VERSION | Library version.
FM_CURRENT_LIB_FULL_NAME | Full versioned name of the library.
FM_CURRENT_LIB_TARBALL_NAME | Name of the tarball file.
FM_CURRENT_LIB_TARBALL_DOWNLOAD_URL | Url from which the tarball file can be downloaded.
FM_CURRENT_LIB_UNTAR_DIR | Name of the directory produced by decompressing the tarball. To be specified only if different from ${FM_<LIBRARY>_FULL_NAME}.
FM_CURRENT_LIB_UNTAR_FLAGS | Additional flags to pass to the decompression command. Normallly used to exclude some files.
FM_CURRENT_LIB_INSTALL_CHECK | Name of a representative header file of the library to check if the library is already built.
FM_CURRENT_LIB_TARBALL_HASH | Hash of the library tarball.
FM_CURRENT_LIB_TARBALL_HASH_TYPE | Type of hash function used. Supported hash functions are: MD5, SHA-1, SHA-256.

FM_CURRENT_LIB_PATCHES_DIR | Directory for optional patches for the library

FM_CURRENT_LIB_SOURCE_DIR | Directory in which the tarball of the library is decompressed during the build.



--------------------------------------------------------------------------------------

### Shared environment configuration parameters.

FM_CONFIG_*


Working directories

Name | Description
---- | -----------
FM_CONFIG_TARBALL_CACHE | Path of the cache of downloaded library source tarballs.
FM_CONFIG_BUILD_ROOT | Root path in which the libraries will be built.
FM_CONFIG_DEPLOY_ROOT | Root path in which the libraries will be installed.


Options

Name | Description
---- | -----------
FM_CONFIG_NUM_PROCESSES | Number of parallel jobs to use during the build.
FM_CONFIG_CXX_STANDARD | C++ standard version. Possible values are 14, 17, 20 ...
FM_CONFIG_LAN_TARBALL_CACHE_USE | LAN cache configuration mode. Possible values are NO, YES, ONLY. Default: NO
FM_CONFIG_LAN_TARBALL_CACHE_GET_CMD | Command to use to download a tarball from the LAN cache. Example: 'curl -u : -o "${DESTINATION_PATH}" "smb://server/libs_cache/${TARBALL_NAME}"'.
FM_CONFIG_ON_BUILD_ERROR | Optional command to execute when the build completes with an error.
FM_CONFIG_ON_BUILD_SUCCESS | Optional command to execute when the build completes successfully.
FM_CONFIG_VERBOSE_LOGS | Set to true to increase the log verbosity
FM_CONFIG_DEPLOY_CMAKE_FIND_MODULES | Set to true to deploy the provided cmake find modules. Default: false
FM_CONFIG_DISABLE_SSL_CERTIFICATE_VALIDATION | Set to true to disable certificate validation during downloads. Obviously, better to avoid if possible. Default: false

Executables

Name | Description
---- | -----------
FM_CONFIG_CMAKE_COMMAND | Path of the cmake executable
FM_CONFIG_CURL_COMMAND | Path of the curl executable
FM_CONFIG_PERL_COMMAND | Path of the perl executable
FM_CONFIG_PERL_WINDOWS_COMMAND | Path of the Windows perl executable
FM_CONFIG_PYTHON_COMMAND | Path of the python executable
FM_CONFIG_PYTHON_WINDOWS_COMMAND | Path of the Windows python executable
FM_CONFIG_TAR_COMMAND | Path of the tar executable
FM_CONFIG_UNZIP_COMMAND | Path of the unzip executable
FM_CONFIG_PATCH_COMMAND | Path of the patch executable
FM_CONFIG_LIPO_COMMAND | Path of the lipo executable (for macOS)

Add also CMP (diffutils)



Android

Name | Description
---- | -----------
FM_CONFIG_ANDROID_API_LEVEL | Android API level.
FM_CONFIG_ANDROID_NDK_INSTALL_PATH | Android NDK installation path.



Windows variables - to be updated

set FM_CONFIG_MINGW_32_INSTALL_PATH=C:\Qt\Tools\mingw810_32
set FM_CONFIG_MINGW_64_INSTALL_PATH=C:\Qt\Tools\mingw810_64
set FM_CONFIG_MSYS64_INSTALL_PATH=C:\msys64
set FM_CONFIG_MSVC_VCVARSALL_BAT_PATH=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat
set FM_CONFIG_USE_JOM=true
set FM_CONFIG_JOM_INSTALL_PATH=C:\Qt\Tools\QtCreator\bin\jom


--------------------------------------------------------------------------------------

### Path variables

Name | Description
---- | -----------
FM_PATH_SCRIPTS_ROOT_DIRECTORY | Root of the c++ libraries build scripts
FM_PATH_CORE_SCRIPTS_DIRECTORY | Core scripts root directory
FM_PATH_ENVIRONMENT_INIT_SCRIPT_DIRECTORY | Directory of the environment initialization script
FM_PATH_CURRENT_BUILD_SCRIPT_DIRECTORY | Directory of the running build script



--------------------------------------------------------------------------------------

### Build host variables

Name | Description
---- | -----------
FM_HOST_OS_TYPE | Operating system of the build host.
FM_HOST_ARCHITECTURE | Architecture of the build host.
FM_HOST_ADDRESS_MODEL | Address model of the build host.



--------------------------------------------------------------------------------------

### Build target variables

Name | Description
---- | -----------
FM_TARGET_OS_TYPE | Operating system of the build target.
FM_TARGET_ARCHITECTURE | Architecture of the build target.
FM_TARGET_ADDRESS_MODEL | Address model of the build target.
FM_TARGET_COMPILER | Compiler for the build target.
FM_TARGET_COMPILER_VERSION | Version of the compiler for the build target.
FM_TARGET_TOOLCHAIN | Toolchain for the build target.
FM_TARGET_PLATFORM | Platform for the build target.
FM_TARGET_CMAKE_GENERATOR | CMake generator for the build target.
FM_TARGET_CMAKE_TOOLCHAIN_FILE | CMake cross compile toolchain definition file.
FM_TARGET_CMAKE_ARGUMENTS_GENERATE | Default arguments for CMake generate invocation for the build target.
FM_TARGET_CMAKE_ARGUMENTS_BUILD | Default arguments for CMake build invocation for the build target.
FM_TARGET_CMAKE_ARGUMENTS_INSTALL | Default arguments for CMake install invocation for the build target.
FM_TARGET_HAS_PKGCONFIG | Is support for pkgconfig available to the toolchain for the build target? Possible values are true, false. Default: false
FM_TARGET_CROSS_COMPILER_HOST | To enable cross compilation.
FM_TARGET_IS_CROSS_COMPILING | Is cross compilation active for the build target?
FM_TARGET_ALL_ARCHITECTURES | All supported architectures.
FM_TARGET_ALL_BUILD_VARIANTS | All supported build variants.
FM_TARGET_ANDROID_ABI | Android ABI (armeabi-v7a, arm64-v8a, x86, x86_64)
FM_TARGET_IOS_PLATFORM | iOS platform in use (iPhoneOS, iPhoneSimulator ...)
FM_TARGET_IOS_SDK | iOS SDK in use (iphoneos, iphonesimulator ...)
FM_TARGET_IOS_SDK_VERSION | Version of the iOS SDK.
FM_TARGET_IOS_SYS_ROOT | Sys root of the iOS SDK.
FM_TARGET_IOS_VERSION | iOS version in use (10.0, 13.0 ...)
FM_TARGET_IOS_PROCESSOR | iOS processor target
FM_TARGET_MACOS_PROCESSOR | macOS processor target


Name | Description
---- | -----------
FM_TARGET_BUILD_FLAGS_FOR_<LIBRARY> | Optional build flags for the library.


Name | Description
---- | -----------
FM_TARGET_TOOLCHAIN_AR | Name of the toolchain executable.
FM_TARGET_TOOLCHAIN_CC | Name of the toolchain executable.
FM_TARGET_TOOLCHAIN_CXX | Name of the toolchain executable.
FM_TARGET_TOOLCHAIN_NM | Name of the toolchain executable.
FM_TARGET_TOOLCHAIN_RANLIB | Name of the toolchain executable.



Name | Description
---- | -----------
FM_TARGET_TOOLCHAIN_COMMON_CPPFLAGS | Common toolchain executable flags.
FM_TARGET_TOOLCHAIN_COMMON_CFLAGS | Common toolchain executable flags.
FM_TARGET_TOOLCHAIN_COMMON_CXXFLAGS | Common toolchain executable flags.
FM_TARGET_TOOLCHAIN_COMMON_LDFLAGS | Common toolchain executable flags.

Name | Description
---- | -----------
FM_TARGET_TOOLCHAIN_ARCHITECTURE_CFLAGS_<ARCHITECTURE> | Toolchain executable flags for a specific architecture.
FM_TARGET_TOOLCHAIN_ARCHITECTURE_CXXFLAGS_<ARCHITECTURE> | Toolchain executable flags for a specific architecture.
FM_TARGET_TOOLCHAIN_ARCHITECTURE_LDFLAGS_<ARCHITECTURE> | Toolchain executable flags for a specific architecture.

Name | Description
---- | -----------
FM_TARGET_TOOLCHAIN_BUILD_VARIANT_CFLAGS_<VARIANT> | Toolchain executable flags for a specific build variant.
FM_TARGET_TOOLCHAIN_BUILD_VARIANT_CXXFLAGS_<VARIANT> | Toolchain executable flags for a specific build variant.
FM_TARGET_TOOLCHAIN_BUILD_VARIANT_LDFLAGS_<VARIANT> | Toolchain executable flags for a specific build variant.

Name | Description
---- | -----------
FM_TARGET_TOOLCHAIN_CPPFLAGS | Toolchain executable flags.
FM_TARGET_TOOLCHAIN_CFLAGS | Toolchain executable flags.
FM_TARGET_TOOLCHAIN_CXXFLAGS | Toolchain executable flags.
FM_TARGET_TOOLCHAIN_LDFLAGS | Toolchain executable flags.
FM_TARGET_TOOLCHAIN_ASMFLAGS | Toolchain executable flags.









(FM_GLOBAL_* are deprecated)
FM_GLOBAL_ADDRESS_MODEL
FM_GLOBAL_ARCHITECTURE
FM_GLOBAL_CROSS_COMPILER_HOST
FM_GLOBAL_CROSS_COMPILER_ROOT_NAME
FM_GLOBAL_RASPBERRY_PI_CROSS_SYSROOT_PATH
FM_GLOBAL_RASPBERRY_PI_CROSS_TOOLCHAIN_PATH
FM_GLOBAL_SYSROOT
FM_GLOBAL_TARGET

FM_GLOBAL_CFLAGS
FM_GLOBAL_CXXFLAGS
FM_GLOBAL_LDFLAGS


--------------------------------------------------------------------------------------

FM_AVAILABLE_BUILD_ACTIONS

--------------------------------------------------------------------------------------


La macchina che esegue il cross-compilatore viene detta host.
La macchina sulla quale si eseguirà il binario ottenuto dal processo di cross-compilazione è detta target.


Autotools:
build: sistema su cui si sta configurando e compilando un pacchetto
host: sistema su cui il pacchetto compilato verrà eseguito. Di default è uguale a "build". Se diverso da "build", viene abilitata la cross-compilazione.
target: sistema per cui eventuali compilatori nel pacchetto producono codice. Di default è uguale a "host"

Autotools:
--build=the architecture of the build machine
--host=the architecture that you want the file to run on

--build=build-type
    the type of system on which the package is being configured and compiled. It defaults to the result of running config.guess.
--host=host-type
    the type of system on which the package runs. By default it is the same as the build machine. Specifying it enables the cross-compilation mode. 

Target triple: cpu-vendor-os



Arguments passed to a build script

FM_ARG_VERBOSE | Verbose mode on
FM_ARG_ACTION | Action to perform (build, install, buildInstall)
FM_ARG_LIB | Library to build.
FM_ARG_LIBSET
FM_ARG_LIBSET_LIBS | Libraries of the libset.
FM_ARG_NUM_PROCESSES
FM_ARG_TOOLCHAIN
FM_ARG_ARCHITECTURES
FM_ARG_ARCHITECTURE
FM_ARG_BUILD_VARIANTS
FM_ARG_BUILD_VARIANT
FM_ARG_TARBALL_CACHE
FM_ARG_BUILD_ROOT
FM_ARG_DEPLOY_ROOT




FM_LIBSET_LIBS | Libraries included in a libset.





FM_CURRENT_ARCHITECTURE_LIB_TAG
FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE
FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE
FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE
FM_CURRENT_ARCHITECTURE_SOURCE_DIR
FM_CURRENT_ARCHITECTURE_STAGE_DIR
FM_CURRENT_ARCHITECTURE_STAGE_DIR_WINDOWS









FM_LIBS_BUILD_FOLDER
FM_LIBS_BUILD_LOGS
FM_LIBS_BUILD_SOURCE
FM_LIBS_INSTALL_DLLS
FM_LIBS_INSTALL_INCLUDES
FM_LIBS_INSTALL_INCLUDES_WINDOWS
FM_LIBS_INSTALL_LIBS
FM_LIBS_INSTALL_LIBS_WINDOWS
FM_LIBS_INSTALL_PKGCONFIG
FM_LIBS_INSTALL_PREFIX

FM_SOURCE_TARBALL_NAME

FM_TARGET_ADDRESS_MODEL
FM_TARGET_ARCHITECTURE
FM_TARGET_BUILD_TAG
FM_TARGET_BUILD_VARIANT
FM_TARGET_MINGW_PLATFORM

FM_TARGET_TARBALL_PATH









--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------

FM_IOS_ALL_SDK_ARCHITECTURES
FM_IOS_BUILT_ARCHITECTURES
FM_IOS_BUILT_ARCHITECTURES+
FM_IOS_CROSS_SYS_ROOT
FM_IOS_CURRENT_ARCHITECTURE_NAME
FM_IOS_CURRENT_SDK_NAME
FM_IOS_IPHONEOS_SDK_ARCHITECTURES
FM_IOS_IPHONESIMULATOR_SDK_ARCHITECTURES
FM_IOS_SDK_ARCHITECTURE
FM_IOS_SDK_MIN_VERSION
FM_IOS_SDK_PLATFORM
FM_IOS_SDK_VERSION
FM_IOS_XCODE_ROOT

