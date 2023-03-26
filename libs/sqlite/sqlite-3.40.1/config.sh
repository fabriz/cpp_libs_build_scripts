#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for sqlite 3.40.1
# Library release date: 2022/12/28

export FM_SQLITE_NAME="sqlite-autoconf"
export FM_SQLITE_VERSION="3400100"
export FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
export FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
export FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2022/${FM_SQLITE_TARBALL_NAME}"
export FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
export FM_SQLITE_HASH="2c5dea207fa508d765af1ef620b637dcb06572afa6f01f0815bd5bbf864b33d9"
export FM_SQLITE_HASH_TYPE="SHA-256"

# SHA3-256: 3136db4bcd9e9e1e485c291380a3d86f0f21cae0eff9f714c0ef4821e2e5cdf7
