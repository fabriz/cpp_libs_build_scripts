#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for zlib 1.2.11
# Library release date: 2017/01/15

export FM_ZLIB_NAME="zlib"
export FM_ZLIB_VERSION="1.2.11"
export FM_ZLIB_FULL_NAME="${FM_ZLIB_NAME}-${FM_ZLIB_VERSION}"
export FM_ZLIB_TARBALL_NAME="${FM_ZLIB_FULL_NAME}.tar.gz"
export FM_ZLIB_TARBALL_DOWNLOAD_URL="https://zlib.net/${FM_ZLIB_TARBALL_NAME}"
export FM_ZLIB_INSTALL_CHECK="include/zlib.h"
export FM_ZLIB_HASH="c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1"
export FM_ZLIB_HASH_TYPE="SHA-256"
