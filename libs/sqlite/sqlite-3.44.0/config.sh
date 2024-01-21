#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for sqlite 3.44.0
# Library release date: 2023/11/01

export FM_SQLITE_NAME="sqlite-autoconf"
export FM_SQLITE_VERSION="3440000"
export FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
export FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
export FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2023/${FM_SQLITE_TARBALL_NAME}"
export FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
export FM_SQLITE_HASH="b9cd386e7cd22af6e0d2a0f06d0404951e1bef109e42ea06cc0450e10cd15550"
export FM_SQLITE_HASH_TYPE="SHA-256"

# SHA3-256: 6869046465eae886f1a9f2c8debeeba44d34328693aa77a5bd4a3cfed93d6556
