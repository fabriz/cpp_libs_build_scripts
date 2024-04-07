#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for giflib 5.2.2
# Library release date: 2024/02/19

export FM_GIFLIB_NAME="giflib"
export FM_GIFLIB_VERSION="5.2.2"
export FM_GIFLIB_FULL_NAME="${FM_GIFLIB_NAME}-${FM_GIFLIB_VERSION}"
export FM_GIFLIB_TARBALL_NAME="${FM_GIFLIB_FULL_NAME}.tar.gz"
export FM_GIFLIB_TARBALL_DOWNLOAD_URL="https://download.sourceforge.net/giflib/${FM_GIFLIB_TARBALL_NAME}"
export FM_GIFLIB_INSTALL_CHECK="include/gif_lib.h"
export FM_GIFLIB_HASH="be7ffbd057cadebe2aa144542fd90c6838c6a083b5e8a9048b8ee3b66b29d5fb"
export FM_GIFLIB_HASH_TYPE="SHA-256"
