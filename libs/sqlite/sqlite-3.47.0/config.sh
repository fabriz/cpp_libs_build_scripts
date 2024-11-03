#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for sqlite 3.47.0
# Library release date: 2024/10/21

export FM_SQLITE_NAME="sqlite-autoconf"
export FM_SQLITE_VERSION="3470000"
export FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
export FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
export FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2024/${FM_SQLITE_TARBALL_NAME}"
export FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
export FM_SQLITE_HASH="83eb21a6f6a649f506df8bd3aab85a08f7556ceed5dbd8dea743ea003fc3a957"
export FM_SQLITE_HASH_TYPE="SHA-256"

# SHA3-256: a9166e017ef8bc33379b1c2eed346bf43cded6d40df0feb984a33fba1a828ba9
