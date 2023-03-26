#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for botan 2.19.3
# Library release date: 2022/11/16

export FM_BOTAN_NAME="Botan"
export FM_BOTAN_VERSION="2.19.3"
export FM_BOTAN_FULL_NAME="${FM_BOTAN_NAME}-${FM_BOTAN_VERSION}"
export FM_BOTAN_TARBALL_NAME="${FM_BOTAN_FULL_NAME}.tar.xz"
export FM_BOTAN_TARBALL_DOWNLOAD_URL="https://botan.randombit.net/releases/${FM_BOTAN_TARBALL_NAME}"
export FM_BOTAN_UNTAR_FLAGS="--exclude=*/.lgtm.yml"
export FM_BOTAN_INSTALL_CHECK="include/botan-2/botan/botan.h"
export FM_BOTAN_HASH="dae047f399c5a47f087db5d3d9d9e8f11ae4985d14c928d71da1aff801802d55"
export FM_BOTAN_HASH_TYPE="SHA-256"
