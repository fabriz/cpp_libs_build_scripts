#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libiconv 1.17
# Library release date: 2022/05/15

export FM_LIBICONV_NAME="libiconv"
export FM_LIBICONV_VERSION="1.17"
export FM_LIBICONV_FULL_NAME="${FM_LIBICONV_NAME}-${FM_LIBICONV_VERSION}"
export FM_LIBICONV_TARBALL_NAME="${FM_LIBICONV_FULL_NAME}.tar.gz"
export FM_LIBICONV_TARBALL_DOWNLOAD_URL="https://ftp.gnu.org/pub/gnu/libiconv/${FM_LIBICONV_TARBALL_NAME}"
export FM_LIBICONV_INSTALL_CHECK="include/iconv.h"
export FM_LIBICONV_HASH="8f74213b56238c85a50a5329f77e06198771e70dd9a739779f4c02f65d971313"
export FM_LIBICONV_HASH_TYPE="SHA-256"
