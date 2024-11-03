#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libzip 1.11.2
# Library release date: 2024/10/31

export FM_LIBZIP_NAME="libzip"
export FM_LIBZIP_VERSION="1.11.2"
export FM_LIBZIP_FULL_NAME="${FM_LIBZIP_NAME}-${FM_LIBZIP_VERSION}"
export FM_LIBZIP_TARBALL_NAME="${FM_LIBZIP_FULL_NAME}.tar.xz"
export FM_LIBZIP_TARBALL_DOWNLOAD_URL="https://libzip.org/download/${FM_LIBZIP_TARBALL_NAME}"
export FM_LIBZIP_INSTALL_CHECK="include/zip.h"
export FM_LIBZIP_HASH="5d471308cef4c4752bbcf973d9cd37ba4cb53739116c30349d4764ba1410dfc1"
export FM_LIBZIP_HASH_TYPE="SHA-256"
