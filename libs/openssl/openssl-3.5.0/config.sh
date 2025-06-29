#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2025 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for openssl 3.5.0
# Library release date: 2025/04/08

export FM_OPENSSL_NAME="openssl"
export FM_OPENSSL_VERSION="3.5.0"
export FM_OPENSSL_FULL_NAME="${FM_OPENSSL_NAME}-${FM_OPENSSL_VERSION}"
export FM_OPENSSL_TARBALL_NAME="${FM_OPENSSL_FULL_NAME}.tar.gz"
export FM_OPENSSL_TARBALL_DOWNLOAD_URL="https://www.openssl.org/source/${FM_OPENSSL_TARBALL_NAME}"
export FM_OPENSSL_INSTALL_CHECK="include/openssl/opensslconf.h"
export FM_OPENSSL_HASH="344d0a79f1a9b08029b0744e2cc401a43f9c90acd1044d09a530b4885a8e9fc0"
export FM_OPENSSL_HASH_TYPE="SHA-256"
