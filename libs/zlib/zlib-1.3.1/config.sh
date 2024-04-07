#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for zlib 1.3.1
# Library release date: 2024/01/22

export FM_ZLIB_NAME="zlib"
export FM_ZLIB_VERSION="1.3.1"
export FM_ZLIB_FULL_NAME="${FM_ZLIB_NAME}-${FM_ZLIB_VERSION}"
export FM_ZLIB_TARBALL_NAME="${FM_ZLIB_FULL_NAME}.tar.xz"
export FM_ZLIB_TARBALL_DOWNLOAD_URL="https://zlib.net/${FM_ZLIB_TARBALL_NAME}"
export FM_ZLIB_INSTALL_CHECK="include/zlib.h"
export FM_ZLIB_HASH="38ef96b8dfe510d42707d9c781877914792541133e1870841463bfa73f883e32"
export FM_ZLIB_HASH_TYPE="SHA-256"
