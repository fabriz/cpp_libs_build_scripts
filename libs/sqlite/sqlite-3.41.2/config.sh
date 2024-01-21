#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for sqlite 3.41.2
# Library release date: 2023/03/22

export FM_SQLITE_NAME="sqlite-autoconf"
export FM_SQLITE_VERSION="3410200"
export FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
export FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
export FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2023/${FM_SQLITE_TARBALL_NAME}"
export FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
export FM_SQLITE_HASH="e98c100dd1da4e30fa460761dab7c0b91a50b785e167f8c57acc46514fae9499"
export FM_SQLITE_HASH_TYPE="SHA-256"

# SHA3-256: 1ebb5539dd6fde9a0f89e8ab765af0b9f02010fc6baf6985b54781a38c00020a
