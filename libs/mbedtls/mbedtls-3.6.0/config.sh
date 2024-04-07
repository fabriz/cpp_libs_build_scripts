#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for mbedtls 3.6.0
# Library release date: 2024/03/28

export FM_MBEDTLS_NAME="mbedtls"
export FM_MBEDTLS_VERSION="3.6.0"
export FM_MBEDTLS_FULL_NAME="${FM_MBEDTLS_NAME}-${FM_MBEDTLS_VERSION}"
export FM_MBEDTLS_TARBALL_NAME="${FM_MBEDTLS_FULL_NAME}.tar.gz"
export FM_MBEDTLS_TARBALL_DOWNLOAD_URL="https://github.com/Mbed-TLS/mbedtls/archive/refs/tags/v${FM_MBEDTLS_VERSION}.tar.gz"
export FM_MBEDTLS_INSTALL_CHECK="include/mbedtls/mbedtls_config.h"
export FM_MBEDTLS_HASH="32c500e73ee878e193e7d66bf5e4c34fb42bb968a6c9f9488aa466b16f6f3bff"
export FM_MBEDTLS_HASH_TYPE="SHA-256"
