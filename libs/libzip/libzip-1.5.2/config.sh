#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libzip 1.5.2
# Library release date: 2019/03/12

export FM_LIBZIP_NAME="libzip"
export FM_LIBZIP_VERSION="1.5.2"
export FM_LIBZIP_FULL_NAME="${FM_LIBZIP_NAME}-${FM_LIBZIP_VERSION}"
export FM_LIBZIP_TARBALL_NAME="${FM_LIBZIP_FULL_NAME}.tar.gz"
export FM_LIBZIP_TARBALL_DOWNLOAD_URL="https://libzip.org/download/${FM_LIBZIP_TARBALL_NAME}"
export FM_LIBZIP_INSTALL_CHECK="include/zip.h"
export FM_LIBZIP_HASH="be694a4abb2ffe5ec02074146757c8b56084dbcebf329123c84b205417435e15"
export FM_LIBZIP_HASH_TYPE="SHA-256"
