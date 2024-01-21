#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for zlib 1.3
# Library release date: 2023/08/18

export FM_ZLIB_NAME="zlib"
export FM_ZLIB_VERSION="1.3"
export FM_ZLIB_FULL_NAME="${FM_ZLIB_NAME}-${FM_ZLIB_VERSION}"
export FM_ZLIB_TARBALL_NAME="${FM_ZLIB_FULL_NAME}.tar.xz"
export FM_ZLIB_TARBALL_DOWNLOAD_URL="https://zlib.net/${FM_ZLIB_TARBALL_NAME}"
export FM_ZLIB_INSTALL_CHECK="include/zlib.h"
export FM_ZLIB_HASH="8a9ba2898e1d0d774eca6ba5b4627a11e5588ba85c8851336eb38de4683050a7"
export FM_ZLIB_HASH_TYPE="SHA-256"
