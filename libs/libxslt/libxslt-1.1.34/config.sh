#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libxslt 1.1.34
# Library release date: 2019/10/30

export FM_LIBXSLT_NAME="libxslt"
export FM_LIBXSLT_VERSION="1.1.34"
export FM_LIBXSLT_FULL_NAME="${FM_LIBXSLT_NAME}-${FM_LIBXSLT_VERSION}"
export FM_LIBXSLT_TARBALL_NAME="${FM_LIBXSLT_FULL_NAME}.tar.gz"
export FM_LIBXSLT_TARBALL_DOWNLOAD_URL="ftp://xmlsoft.org/libxslt/${FM_LIBXSLT_TARBALL_NAME}"
export FM_LIBXSLT_INSTALL_CHECK="include/libxslt/xslt.h"
export FM_LIBXSLT_HASH="98b1bd46d6792925ad2dfe9a87452ea2adebf69dcb9919ffd55bf926a7f93f7f"
export FM_LIBXSLT_HASH_TYPE="SHA-256"
