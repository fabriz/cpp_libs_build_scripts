#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for sqlite 3.39.3
# Library release date: 2022/09/05

export FM_SQLITE_NAME="sqlite-autoconf"
export FM_SQLITE_VERSION="3390300"
export FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
export FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
export FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2022/${FM_SQLITE_TARBALL_NAME}"
export FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
export FM_SQLITE_HASH="7868fb3082be3f2cf4491c6fba6de2bddcbc293a35fefb0624ee3c13f01422b9"
export FM_SQLITE_HASH_TYPE="SHA-256"

# SHA3-256: dfa055c70724cd63f0b7da6e9f53530d8da51fe021e3f864d58c7c847d590e1d
