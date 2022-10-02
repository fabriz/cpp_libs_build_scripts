#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for sqlite 3.39.4
# Library release date: 2022/09/29

export FM_SQLITE_NAME="sqlite-autoconf"
export FM_SQLITE_VERSION="3390400"
export FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
export FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
export FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2022/${FM_SQLITE_TARBALL_NAME}"
export FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
export FM_SQLITE_HASH="f31d445b48e67e284cf206717cc170ab63cbe4fd7f79a82793b772285e78fdbb"
export FM_SQLITE_HASH_TYPE="SHA-256"

# SHA3-256: 431328e30d12c551da9ba7ef2122b269076058512014afa799caaf62ca567090
