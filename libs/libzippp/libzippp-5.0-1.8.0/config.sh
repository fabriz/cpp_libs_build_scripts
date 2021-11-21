#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libzippp 5.0-1.8.0
# Library release date: 2021/08/03

export FM_LIBZIPPP_NAME="libzippp"
export FM_LIBZIPPP_VERSION="5.0-1.8.0"
export FM_LIBZIPPP_FULL_NAME="${FM_LIBZIPPP_NAME}-${FM_LIBZIPPP_VERSION}"
export FM_LIBZIPPP_TARBALL_NAME="${FM_LIBZIPPP_FULL_NAME}.tar.gz"
export FM_LIBZIPPP_TARBALL_DOWNLOAD_URL="https://github.com/ctabin/libzippp/tarball/${FM_LIBZIPPP_NAME}-v${FM_LIBZIPPP_VERSION}"
export FM_LIBZIPPP_UNTAR_DIR="ctabin-libzippp-*"
export FM_LIBZIPPP_INSTALL_CHECK="include/libzippp.h"
export FM_LIBZIPPP_HASH="b9b9af188256ecbde226e920fd41ef69504382630d0e0d5a993db7bb0b9cd9e7"
export FM_LIBZIPPP_HASH_TYPE="SHA-256"
