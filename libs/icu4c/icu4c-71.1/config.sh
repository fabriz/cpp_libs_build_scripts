#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for icu4c 71.1
# Library release date: 2022/04/07

export FM_ICU4C_NAME="icu4c"
export FM_ICU4C_VERSION="71.1"
export FM_ICU4C_FULL_NAME="${FM_ICU4C_NAME}-${FM_ICU4C_VERSION//./_}"
export FM_ICU4C_TARBALL_NAME="${FM_ICU4C_FULL_NAME}-src.tgz"
export FM_ICU4C_TARBALL_DOWNLOAD_URL="https://github.com/unicode-org/icu/releases/download/release-${FM_ICU4C_VERSION//./-}/${FM_ICU4C_TARBALL_NAME}"
export FM_ICU4C_UNTAR_DIR="icu"
export FM_ICU4C_INSTALL_CHECK="include/unicode/icudataver.h"
export FM_ICU4C_HASH="67a7e6e51f61faf1306b6935333e13b2c48abd8da6d2f46ce6adca24b1e21ebf"
export FM_ICU4C_HASH_TYPE="SHA-256"

# MD5: e06ffc96f59762bd3c929b217445aaec
