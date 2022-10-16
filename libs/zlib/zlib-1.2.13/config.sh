#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for zlib 1.2.13
# Library release date: 2022/10/13

export FM_ZLIB_NAME="zlib"
export FM_ZLIB_VERSION="1.2.13"
export FM_ZLIB_FULL_NAME="${FM_ZLIB_NAME}-${FM_ZLIB_VERSION}"
export FM_ZLIB_TARBALL_NAME="${FM_ZLIB_FULL_NAME}.tar.xz"
export FM_ZLIB_TARBALL_DOWNLOAD_URL="https://zlib.net/${FM_ZLIB_TARBALL_NAME}"
export FM_ZLIB_INSTALL_CHECK="include/zlib.h"
export FM_ZLIB_HASH="d14c38e313afc35a9a8760dadf26042f51ea0f5d154b0630a31da0540107fb98"
export FM_ZLIB_HASH_TYPE="SHA-256"
