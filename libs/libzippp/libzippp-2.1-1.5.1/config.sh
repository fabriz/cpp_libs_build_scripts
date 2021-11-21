#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libzippp 2.1-1.5.1
# Library release date: 2018/05/01

export FM_LIBZIPPP_NAME="libzippp"
export FM_LIBZIPPP_VERSION="2.1-1.5.1"
export FM_LIBZIPPP_FULL_NAME="${FM_LIBZIPPP_NAME}-${FM_LIBZIPPP_VERSION}"
export FM_LIBZIPPP_TARBALL_NAME="${FM_LIBZIPPP_FULL_NAME}.tar.gz"
export FM_LIBZIPPP_TARBALL_DOWNLOAD_URL="https://github.com/ctabin/libzippp/tarball/${FM_LIBZIPPP_NAME}-v${FM_LIBZIPPP_VERSION}"
export FM_LIBZIPPP_UNTAR_DIR="ctabin-libzippp-*"
export FM_LIBZIPPP_INSTALL_CHECK="include/libzippp.h"
export FM_LIBZIPPP_HASH="a027d7d6ad7bc6a8c0225a6112b3ad3b2d5ab777"
export FM_LIBZIPPP_HASH_TYPE="SHA-1"
