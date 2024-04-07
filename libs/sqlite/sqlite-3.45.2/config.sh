#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for sqlite 3.45.2
# Library release date: 2024/03/12

export FM_SQLITE_NAME="sqlite-autoconf"
export FM_SQLITE_VERSION="3450200"
export FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
export FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
export FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2024/${FM_SQLITE_TARBALL_NAME}"
export FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
export FM_SQLITE_HASH="bc9067442eedf3dd39989b5c5cfbfff37ae66cc9c99274e0c3052dc4d4a8f6ae"
export FM_SQLITE_HASH_TYPE="SHA-256"

# SHA3-256: 1b02c58a711d15b50da8a1089e0f8807ebbdf3e674c714100eda9a03a69ac758
