#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for sqlite 3.38.2
# Library release date: 2022/03/26

export FM_SQLITE_NAME="sqlite-autoconf"
export FM_SQLITE_VERSION="3380200"
export FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
export FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
export FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2022/${FM_SQLITE_TARBALL_NAME}"
export FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
export FM_SQLITE_HASH="e7974aa1430bad690a5e9f79a6ee5c8492ada8269dc675875ad0fb747d7cada4"
export FM_SQLITE_HASH_TYPE="SHA-256"

# SHA3-256: efb103ff4406a2217fa6147e8b88ba54f6c5582e83ef4ff2840be2b306d8172b
