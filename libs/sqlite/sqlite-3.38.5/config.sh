#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for sqlite 3.38.5
# Library release date: 2022/05/06

export FM_SQLITE_NAME="sqlite-autoconf"
export FM_SQLITE_VERSION="3380500"
export FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
export FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
export FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2022/${FM_SQLITE_TARBALL_NAME}"
export FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
export FM_SQLITE_HASH="5af07de982ba658fd91a03170c945f99c971f6955bc79df3266544373e39869c"
export FM_SQLITE_HASH_TYPE="SHA-256"

# SHA3-256: ab649fea76f49a6ec7f907f001d87b8bd76dec0679c783e3992284c5a882a98c
