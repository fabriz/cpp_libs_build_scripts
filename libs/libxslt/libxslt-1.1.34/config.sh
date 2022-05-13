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
export FM_LIBXSLT_TARBALL_NAME="${FM_LIBXSLT_FULL_NAME}.tar.xz"
export FM_LIBXSLT_TARBALL_DOWNLOAD_URL="https://download.gnome.org/sources/libxslt/1.1/${FM_LIBXSLT_TARBALL_NAME}"
export FM_LIBXSLT_INSTALL_CHECK="include/libxslt/xslt.h"
export FM_LIBXSLT_HASH="28c47db33ab4daefa6232f31ccb3c65260c825151ec86ec461355247f3f56824"
export FM_LIBXSLT_HASH_TYPE="SHA-256"
