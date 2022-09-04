#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for argon2 2019.07.02
# Library release date: 2019/07/02

export FM_ARGON2_NAME="argon2"
export FM_ARGON2_VERSION="20190702"
export FM_ARGON2_FULL_NAME="${FM_ARGON2_NAME}-${FM_ARGON2_VERSION}"
export FM_ARGON2_TARBALL_NAME="${FM_ARGON2_FULL_NAME}.tar.gz"
export FM_ARGON2_TARBALL_DOWNLOAD_URL="https://github.com/P-H-C/phc-winner-argon2/archive/refs/tags/${FM_ARGON2_VERSION}.tar.gz"
export FM_ARGON2_UNTAR_DIR="phc-winner-argon2-${FM_ARGON2_VERSION}"
export FM_ARGON2_INSTALL_CHECK="include/argon2.h"
export FM_ARGON2_HASH="daf972a89577f8772602bf2eb38b6a3dd3d922bf5724d45e7f9589b5e830442c"
export FM_ARGON2_HASH_TYPE="SHA-256"
