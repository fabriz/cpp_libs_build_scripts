#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for icu4c 74.2
# Library release date: 2023/12/13

export FM_ICU4C_NAME="icu4c"
export FM_ICU4C_VERSION="74.2"
export FM_ICU4C_FULL_NAME="${FM_ICU4C_NAME}-${FM_ICU4C_VERSION//./_}"
export FM_ICU4C_TARBALL_NAME="${FM_ICU4C_FULL_NAME}-src.tgz"
export FM_ICU4C_TARBALL_DOWNLOAD_URL="https://github.com/unicode-org/icu/releases/download/release-${FM_ICU4C_VERSION//./-}/${FM_ICU4C_TARBALL_NAME}"
export FM_ICU4C_UNTAR_DIR="icu"
export FM_ICU4C_UNTAR_FLAGS="--exclude=*/LICENSE"    # Dangling symlink. Remove in next release if fixed.
export FM_ICU4C_INSTALL_CHECK="include/unicode/icudataver.h"
export FM_ICU4C_HASH="5e4fb11d6a3e6b85afb55de8da8a71538f1d8fd64fce893986b37d60e5bb0091"
export FM_ICU4C_HASH_TYPE="SHA-256"

# MD5: 342c8bebe704ec96df8bd6bd7040af1c
