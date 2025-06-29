#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2025 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libzip 1.11.4
# Library release date: 2025/05/23

export FM_LIBZIP_NAME="libzip"
export FM_LIBZIP_VERSION="1.11.4"
export FM_LIBZIP_FULL_NAME="${FM_LIBZIP_NAME}-${FM_LIBZIP_VERSION}"
export FM_LIBZIP_TARBALL_NAME="${FM_LIBZIP_FULL_NAME}.tar.xz"
export FM_LIBZIP_TARBALL_DOWNLOAD_URL="https://libzip.org/download/${FM_LIBZIP_TARBALL_NAME}"
export FM_LIBZIP_INSTALL_CHECK="include/zip.h"
export FM_LIBZIP_HASH="8a247f57d1e3e6f6d11413b12a6f28a9d388de110adc0ec608d893180ed7097b"
export FM_LIBZIP_HASH_TYPE="SHA-256"
