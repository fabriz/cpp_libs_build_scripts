#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for sqlite 3.41.0
# Library release date: 2023/02/21

export FM_SQLITE_NAME="sqlite-autoconf"
export FM_SQLITE_VERSION="3410000"
export FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
export FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
export FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2023/${FM_SQLITE_TARBALL_NAME}"
export FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
export FM_SQLITE_HASH="49f77ac53fd9aa5d7395f2499cb816410e5621984a121b858ccca05310b05c70"
export FM_SQLITE_HASH_TYPE="SHA-256"

# SHA3-256: d783ab44a2b44394331d392b8b8d4d2ea4964cbb2befc7c6c649bcfbdb3c9ffe
