#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for sqlite 3.35.5
# Library release date: 2021/04/19

export FM_SQLITE_NAME="sqlite-autoconf"
export FM_SQLITE_VERSION="3350500"
export FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
export FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
export FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2021/${FM_SQLITE_TARBALL_NAME}"
export FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
export FM_SQLITE_HASH="f52b72a5c319c3e516ed7a92e123139a6e87af08a2dc43d7757724f6132e6db0"
export FM_SQLITE_HASH_TYPE="SHA-256"

# SHA3-256: c84854020531aae4f731b91b47133d3573d3c026975a36a077d6b60325513696
