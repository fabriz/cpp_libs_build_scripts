#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for botan2 2.13.0
# Library release date: 2020/01/06

export FM_BOTAN2_NAME="Botan"
export FM_BOTAN2_VERSION="2.13.0"
export FM_BOTAN2_FULL_NAME="${FM_BOTAN2_NAME}-${FM_BOTAN2_VERSION}"
export FM_BOTAN2_TARBALL_NAME="${FM_BOTAN2_FULL_NAME}.tar.xz"
export FM_BOTAN2_TARBALL_DOWNLOAD_URL="https://botan.randombit.net/releases/${FM_BOTAN2_TARBALL_NAME}"
export FM_BOTAN2_UNTAR_FLAGS="--exclude=*/.lgtm.yml --exclude=*/.travis.yml"
export FM_BOTAN2_INSTALL_CHECK="include/botan-2/botan/botan.h"
export FM_BOTAN2_HASH="f57ae42a41e1091bca58f44f41addebd9a390b651603952c881ec89d50187e90"
export FM_BOTAN2_HASH_TYPE="SHA-256"
