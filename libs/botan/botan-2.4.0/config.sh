#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for botan 2.4.0
# Library release date: 2018/01/08

export FM_BOTAN_NAME="Botan"
export FM_BOTAN_VERSION="2.4.0"
export FM_BOTAN_FULL_NAME="${FM_BOTAN_NAME}-${FM_BOTAN_VERSION}"
export FM_BOTAN_TARBALL_NAME="${FM_BOTAN_FULL_NAME}.tgz"
export FM_BOTAN_TARBALL_DOWNLOAD_URL="https://botan.randombit.net/releases/${FM_BOTAN_TARBALL_NAME}"
export FM_BOTAN_UNTAR_FLAGS="--exclude=*/.travis.yml"
export FM_BOTAN_INSTALL_CHECK="include/botan-2/botan/botan.h"
export FM_BOTAN_HASH="ed9464e2a5cfee4cd3d9bd7a8f80673b45c8a0718db2181a73f5465a606608a5"
export FM_BOTAN_HASH_TYPE="SHA-256"
