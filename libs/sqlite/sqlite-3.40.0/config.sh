#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for sqlite 3.40.0
# Library release date: 2022/11/16

export FM_SQLITE_NAME="sqlite-autoconf"
export FM_SQLITE_VERSION="3400000"
export FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
export FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
export FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2022/${FM_SQLITE_TARBALL_NAME}"
export FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
export FM_SQLITE_HASH="0333552076d2700c75352256e91c78bf5cd62491589ba0c69aed0a81868980e7"
export FM_SQLITE_HASH_TYPE="SHA-256"

# SHA3-256: 7ee8f02b21edb4489df5082b5cf5b7ef47bcebcdb0e209bf14240db69633c878
