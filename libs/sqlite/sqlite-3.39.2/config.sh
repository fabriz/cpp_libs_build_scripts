#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for sqlite 3.39.2
# Library release date: 2022/07/21

export FM_SQLITE_NAME="sqlite-autoconf"
export FM_SQLITE_VERSION="3390200"
export FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
export FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
export FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2022/${FM_SQLITE_TARBALL_NAME}"
export FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
export FM_SQLITE_HASH="852be8a6183a17ba47cee0bbff7400b7aa5affd283bf3beefc34fcd088a239de"
export FM_SQLITE_HASH_TYPE="SHA-256"

# SHA3-256: b195891eb32305481e61c6718b8cc3b090685b613c4824a076c63166a46c5bee
