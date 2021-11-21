#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for sqlite 3.34.0
# Library release date: 2020/12/01

export FM_SQLITE_NAME="sqlite-autoconf"
export FM_SQLITE_VERSION="3340000"
export FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
export FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
export FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2020/${FM_SQLITE_TARBALL_NAME}"
export FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
export FM_SQLITE_HASH="bf6db7fae37d51754737747aaaf413b4d6b3b5fbacd52bdb2d0d6e5b2edd9aee"
export FM_SQLITE_HASH_TYPE="SHA-256"

# SHA3-256: b7479a5b163f1ba0dd5208e247c1ea677373a2b6bf9ef8ed87c8414f58c61de3
