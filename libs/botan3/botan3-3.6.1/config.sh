#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for botan3 3.6.1
# Library release date: 2024/10/26

export FM_BOTAN3_NAME="Botan"
export FM_BOTAN3_VERSION="3.6.1"
export FM_BOTAN3_FULL_NAME="${FM_BOTAN3_NAME}-${FM_BOTAN3_VERSION}"
export FM_BOTAN3_TARBALL_NAME="${FM_BOTAN3_FULL_NAME}.tar.xz"
export FM_BOTAN3_TARBALL_DOWNLOAD_URL="https://botan.randombit.net/releases/${FM_BOTAN3_TARBALL_NAME}"
export FM_BOTAN3_INSTALL_CHECK="include/botan-3/botan/build.h"
export FM_BOTAN3_HASH="7cb8575d88d232c77174769d7f9e24bb44444160585986eebd66e749cb9a9089"
export FM_BOTAN3_HASH_TYPE="SHA-256"
