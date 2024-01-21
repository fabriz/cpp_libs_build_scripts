#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for openssl 1.1.1w
# Library release date: 2023/09/11

export FM_OPENSSL_NAME="openssl"
export FM_OPENSSL_VERSION="1.1.1w"
export FM_OPENSSL_FULL_NAME="${FM_OPENSSL_NAME}-${FM_OPENSSL_VERSION}"
export FM_OPENSSL_TARBALL_NAME="${FM_OPENSSL_FULL_NAME}.tar.gz"
export FM_OPENSSL_TARBALL_DOWNLOAD_URL="https://www.openssl.org/source/${FM_OPENSSL_TARBALL_NAME}"
export FM_OPENSSL_INSTALL_CHECK="include/openssl/opensslconf.h"
export FM_OPENSSL_HASH="cf3098950cb4d853ad95c0841f1f9c6d3dc102dccfcacd521d93925208b76ac8"
export FM_OPENSSL_HASH_TYPE="SHA-256"
