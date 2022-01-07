#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for sqlite 3.37.0
# Library release date: 2021/11/27

export FM_SQLITE_NAME="sqlite-autoconf"
export FM_SQLITE_VERSION="3370000"
export FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
export FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
export FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2021/${FM_SQLITE_TARBALL_NAME}"
export FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
export FM_SQLITE_HASH="731a4651d4d4b36fc7d21db586b2de4dd00af31fd54fb5a9a4b7f492057479f7"
export FM_SQLITE_HASH_TYPE="SHA-256"

# SHA3-256: 237b3845c994ec0060e8b8dff1c7b352521336ce236b65d9defc305a2239cbe7
