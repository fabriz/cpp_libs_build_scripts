#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for botan3 3.5.0
# Library release date: 2024/07/08

export FM_BOTAN3_NAME="Botan"
export FM_BOTAN3_VERSION="3.5.0"
export FM_BOTAN3_FULL_NAME="${FM_BOTAN3_NAME}-${FM_BOTAN3_VERSION}"
export FM_BOTAN3_TARBALL_NAME="${FM_BOTAN3_FULL_NAME}.tar.xz"
export FM_BOTAN3_TARBALL_DOWNLOAD_URL="https://botan.randombit.net/releases/${FM_BOTAN3_TARBALL_NAME}"
export FM_BOTAN3_INSTALL_CHECK="include/botan-3/botan/build.h"
export FM_BOTAN3_HASH="67e8dae1ca2468d90de4e601c87d5f31ff492b38e8ab8bcbd02ddf7104ed8a9f"
export FM_BOTAN3_HASH_TYPE="SHA-256"
