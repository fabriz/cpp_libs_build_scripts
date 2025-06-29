#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2025 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for mbedtls 3.6.3.1
# Library release date: 2025/05/13

export FM_MBEDTLS_NAME="mbedtls"
export FM_MBEDTLS_VERSION="3.6.3.1"
export FM_MBEDTLS_FULL_NAME="${FM_MBEDTLS_NAME}-${FM_MBEDTLS_VERSION}"
export FM_MBEDTLS_TARBALL_NAME="${FM_MBEDTLS_FULL_NAME}.tar.bz2"
export FM_MBEDTLS_TARBALL_DOWNLOAD_URL="https://github.com/Mbed-TLS/mbedtls/releases/download/v${FM_MBEDTLS_VERSION}/${FM_MBEDTLS_TARBALL_NAME}"
export FM_MBEDTLS_INSTALL_CHECK="include/mbedtls/mbedtls_config.h"
export FM_MBEDTLS_HASH="243ed496d5f88a5b3791021be2800aac821b9a4cc16e7134aa413c58b4c20e0c"
export FM_MBEDTLS_HASH_TYPE="SHA-256"
