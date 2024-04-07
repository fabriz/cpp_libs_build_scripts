#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libpng 1.6.43
# Library release date: 2024/02/23

export FM_LIBPNG_NAME="libpng"
export FM_LIBPNG_VERSION="1.6.43"
export FM_LIBPNG_FULL_NAME="${FM_LIBPNG_NAME}-${FM_LIBPNG_VERSION}"
export FM_LIBPNG_TARBALL_NAME="${FM_LIBPNG_FULL_NAME}.tar.xz"
export FM_LIBPNG_TARBALL_DOWNLOAD_URL="https://download.sourceforge.net/libpng/${FM_LIBPNG_TARBALL_NAME}"
export FM_LIBPNG_INSTALL_CHECK="include/png.h"
export FM_LIBPNG_HASH="6a5ca0652392a2d7c9db2ae5b40210843c0bbc081cbd410825ab00cc59f14a6c"
export FM_LIBPNG_HASH_TYPE="SHA-256"
