#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# CMake toolchain configuration file for iOS

set(CMAKE_SYSTEM_NAME iOS)
set(CMAKE_SYSTEM_VERSION $ENV{FM_TARGET_IOS_VERSION})
set(CMAKE_OSX_DEPLOYMENT_TARGET $ENV{FM_TARGET_IOS_VERSION})
set(CMAKE_OSX_SYSROOT $ENV{FM_TARGET_IOS_SYS_ROOT})
set(CMAKE_SYSTEM_PROCESSOR $ENV{FM_TARGET_IOS_PROCESSOR})

set(CMAKE_CPP_FLAGS "$ENV{CPPFLAGS}" CACHE STRING "Preprocessor flags" FORCE)
set(CMAKE_C_FLAGS "$ENV{CFLAGS}" CACHE STRING "C compiler flags" FORCE)
set(CMAKE_CXX_FLAGS "$ENV{CXXFLAGS}"  CACHE STRING "C++ compiler flags" FORCE)
set(CMAKE_C_LINK_FLAGS "$ENV{LDFLAGS}" CACHE STRING "C linker flags" FORCE)
set(CMAKE_CXX_LINK_FLAGS "$ENV{LDFLAGS}" CACHE STRING "C++ linker flags" FORCE)
set(CMAKE_ASM_FLAGS "$ENV{ASMFLAGS}" CACHE STRING "Assembler flags" FORCE)

set(CMAKE_AR "$ENV{AR}" CACHE STRING "Archiver" FORCE)
set(CMAKE_C_COMPILER "$ENV{CC}" CACHE STRING "C compiler" FORCE)
set(CMAKE_CXX_COMPILER "$ENV{CXX}" CACHE STRING "C++ compiler" FORCE)
set(CMAKE_NM "$ENV{NM}" CACHE STRING "Name mangling tool" FORCE)
set(CMAKE_RANLIB "$ENV{RANLIB}" CACHE STRING "Archive indexer" FORCE)

set(CMAKE_FIND_ROOT_PATH "$ENV{FM_LIBS_INSTALL_PREFIX}" "$ENV{FM_TARGET_IOS_SYS_ROOT}")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
