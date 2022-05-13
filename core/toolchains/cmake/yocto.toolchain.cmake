#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# CMake toolchain configuration file for Yocto

set(CMAKE_SYSTEM_NAME Linux)

set(CMAKE_CPP_FLAGS "$ENV{CPPFLAGS}" CACHE STRING "Preprocessor flags" FORCE)
set(CMAKE_C_FLAGS "$ENV{CFLAGS}" CACHE STRING "C compiler flags" FORCE)
set(CMAKE_CXX_FLAGS "$ENV{CXXFLAGS}"  CACHE STRING "C++ compiler flags" FORCE)
set(CMAKE_C_LINK_FLAGS "$ENV{LDFLAGS}" CACHE STRING "C linker flags" FORCE)
set(CMAKE_CXX_LINK_FLAGS "$ENV{LDFLAGS}" CACHE STRING "C++ linker flags" FORCE)
set(CMAKE_ASM_FLAGS "$ENV{CFLAGS}" CACHE STRING "Assembler flags" FORCE)

set(CMAKE_FIND_ROOT_PATH "$ENV{FM_LIBS_INSTALL_PREFIX}" "$ENV{OECORE_TARGET_SYSROOT}" "$ENV{OECORE_NATIVE_SYSROOT}")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
