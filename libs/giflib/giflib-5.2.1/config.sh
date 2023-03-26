#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for giflib 5.2.1
# Library release date: 2019/06/24

export FM_GIFLIB_NAME="giflib"
export FM_GIFLIB_VERSION="5.2.1"
export FM_GIFLIB_FULL_NAME="${FM_GIFLIB_NAME}-${FM_GIFLIB_VERSION}"
export FM_GIFLIB_TARBALL_NAME="${FM_GIFLIB_FULL_NAME}.tar.gz"
export FM_GIFLIB_TARBALL_DOWNLOAD_URL="https://download.sourceforge.net/giflib/${FM_GIFLIB_TARBALL_NAME}"
export FM_GIFLIB_INSTALL_CHECK="include/gif_lib.h"
export FM_GIFLIB_HASH="c3f774dcbdf26afded7788979c8081d33c6426dc"
export FM_GIFLIB_HASH_TYPE="SHA-1"
