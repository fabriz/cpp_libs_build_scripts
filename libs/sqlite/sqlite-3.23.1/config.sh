#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for sqlite 3.23.1
# Library release date: 2018/04/10

export FM_SQLITE_NAME="sqlite-autoconf"
export FM_SQLITE_VERSION="3230100"
export FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
export FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
export FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2018/${FM_SQLITE_TARBALL_NAME}"
export FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
export FM_SQLITE_HASH="0edbfd75ececb95e8e6448d6ff33df82774c9646"
export FM_SQLITE_HASH_TYPE="SHA-1"
