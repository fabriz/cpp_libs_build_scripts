#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for botan2 2.19.4
# Library release date: 2024/02/20

export FM_BOTAN2_NAME="Botan"
export FM_BOTAN2_VERSION="2.19.4"
export FM_BOTAN2_FULL_NAME="${FM_BOTAN2_NAME}-${FM_BOTAN2_VERSION}"
export FM_BOTAN2_TARBALL_NAME="${FM_BOTAN2_FULL_NAME}.tar.xz"
export FM_BOTAN2_TARBALL_DOWNLOAD_URL="https://botan.randombit.net/releases/${FM_BOTAN2_TARBALL_NAME}"
export FM_BOTAN2_UNTAR_FLAGS="--exclude=*/.lgtm.yml"
export FM_BOTAN2_INSTALL_CHECK="include/botan-2/botan/botan.h"
export FM_BOTAN2_HASH="5a3a88ef6433e97bcab0efa1ed60c6197e4ada9d9d30bc1c47437bf89b97f276"
export FM_BOTAN2_HASH_TYPE="SHA-256"
