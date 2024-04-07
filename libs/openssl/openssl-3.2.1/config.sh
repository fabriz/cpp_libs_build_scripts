#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for openssl 3.2.1
# Library release date: 2024/01/30

export FM_OPENSSL_NAME="openssl"
export FM_OPENSSL_VERSION="3.2.1"
export FM_OPENSSL_FULL_NAME="${FM_OPENSSL_NAME}-${FM_OPENSSL_VERSION}"
export FM_OPENSSL_TARBALL_NAME="${FM_OPENSSL_FULL_NAME}.tar.gz"
export FM_OPENSSL_TARBALL_DOWNLOAD_URL="https://www.openssl.org/source/${FM_OPENSSL_TARBALL_NAME}"
export FM_OPENSSL_INSTALL_CHECK="include/openssl/opensslconf.h"
export FM_OPENSSL_HASH="83c7329fe52c850677d75e5d0b0ca245309b97e8ecbcfdc1dfdc4ab9fac35b39"
export FM_OPENSSL_HASH_TYPE="SHA-256"
