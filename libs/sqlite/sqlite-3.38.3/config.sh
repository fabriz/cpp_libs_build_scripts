#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for sqlite 3.38.3
# Library release date: 2022/04/27

export FM_SQLITE_NAME="sqlite-autoconf"
export FM_SQLITE_VERSION="3380300"
export FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
export FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
export FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2022/${FM_SQLITE_TARBALL_NAME}"
export FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
export FM_SQLITE_HASH="61f2dd93a2e38c33468b7125967c3218bf9f4dd8365def6025e314f905dc942e"
export FM_SQLITE_HASH_TYPE="SHA-256"

# SHA3-256: 3ce7e5839d5512bc633877afd5ad4592cdc90a1ae2181c369488131b7411bf28
