#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for mbedtls 3.6.2
# Library release date: 2024/10/15

export FM_MBEDTLS_NAME="mbedtls"
export FM_MBEDTLS_VERSION="3.6.2"
export FM_MBEDTLS_FULL_NAME="${FM_MBEDTLS_NAME}-${FM_MBEDTLS_VERSION}"
export FM_MBEDTLS_TARBALL_NAME="${FM_MBEDTLS_FULL_NAME}.tar.bz2"
export FM_MBEDTLS_TARBALL_DOWNLOAD_URL="https://github.com/Mbed-TLS/mbedtls/releases/download/${FM_MBEDTLS_FULL_NAME}/${FM_MBEDTLS_TARBALL_NAME}"
export FM_MBEDTLS_INSTALL_CHECK="include/mbedtls/mbedtls_config.h"
export FM_MBEDTLS_HASH="8b54fb9bcf4d5a7078028e0520acddefb7900b3e66fec7f7175bb5b7d85ccdca"
export FM_MBEDTLS_HASH_TYPE="SHA-256"
