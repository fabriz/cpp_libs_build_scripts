#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for openssl 3.4.0
# Library release date: 2024/10/22

export FM_OPENSSL_NAME="openssl"
export FM_OPENSSL_VERSION="3.4.0"
export FM_OPENSSL_FULL_NAME="${FM_OPENSSL_NAME}-${FM_OPENSSL_VERSION}"
export FM_OPENSSL_TARBALL_NAME="${FM_OPENSSL_FULL_NAME}.tar.gz"
export FM_OPENSSL_TARBALL_DOWNLOAD_URL="https://www.openssl.org/source/${FM_OPENSSL_TARBALL_NAME}"
export FM_OPENSSL_INSTALL_CHECK="include/openssl/opensslconf.h"
export FM_OPENSSL_HASH="e15dda82fe2fe8139dc2ac21a36d4ca01d5313c75f99f46c4e8a27709b7294bf"
export FM_OPENSSL_HASH_TYPE="SHA-256"
