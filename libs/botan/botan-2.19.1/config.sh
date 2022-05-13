#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for botan 2.19.1
# Library release date: 2022/01/21

export FM_BOTAN_NAME="Botan"
export FM_BOTAN_VERSION="2.19.1"
export FM_BOTAN_FULL_NAME="${FM_BOTAN_NAME}-${FM_BOTAN_VERSION}"
export FM_BOTAN_TARBALL_NAME="${FM_BOTAN_FULL_NAME}.tar.xz"
export FM_BOTAN_TARBALL_DOWNLOAD_URL="https://botan.randombit.net/releases/${FM_BOTAN_TARBALL_NAME}"
export FM_BOTAN_UNTAR_FLAGS="--exclude=*/.lgtm.yml"
export FM_BOTAN_INSTALL_CHECK="include/botan-2/botan/botan.h"
export FM_BOTAN_HASH="e26e00cfefda64082afdd540d3c537924f645d6a674afed2cd171005deff5560"
export FM_BOTAN_HASH_TYPE="SHA-256"
