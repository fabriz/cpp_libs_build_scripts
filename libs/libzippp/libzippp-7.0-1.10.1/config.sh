#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libzippp 7.0-1.10.1
# Library release date: 2023/09/16

export FM_LIBZIPPP_NAME="libzippp"
export FM_LIBZIPPP_VERSION="7.0-1.10.1"
export FM_LIBZIPPP_FULL_NAME="${FM_LIBZIPPP_NAME}-${FM_LIBZIPPP_VERSION}"
export FM_LIBZIPPP_TARBALL_NAME="${FM_LIBZIPPP_FULL_NAME}.tar.gz"
export FM_LIBZIPPP_TARBALL_DOWNLOAD_URL="https://github.com/ctabin/libzippp/tarball/${FM_LIBZIPPP_NAME}-v${FM_LIBZIPPP_VERSION}"
export FM_LIBZIPPP_UNTAR_DIR="ctabin-libzippp-*"
export FM_LIBZIPPP_INSTALL_CHECK="include/libzippp/libzippp.h"
export FM_LIBZIPPP_HASH="8dff9b1a2491fa2a0af54868a1f568830483f55e0743df71677b83bc7caeeced"
export FM_LIBZIPPP_HASH_TYPE="SHA-256"
