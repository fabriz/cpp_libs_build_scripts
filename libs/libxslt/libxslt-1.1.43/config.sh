#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2025 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libxslt 1.1.43
# Library release date: 2025/03/12

export FM_LIBXSLT_NAME="libxslt"
export FM_LIBXSLT_VERSION="1.1.43"
export FM_LIBXSLT_FULL_NAME="${FM_LIBXSLT_NAME}-${FM_LIBXSLT_VERSION}"
export FM_LIBXSLT_TARBALL_NAME="${FM_LIBXSLT_FULL_NAME}.tar.xz"
export FM_LIBXSLT_TARBALL_DOWNLOAD_URL="https://download.gnome.org/sources/libxslt/1.1/${FM_LIBXSLT_TARBALL_NAME}"
export FM_LIBXSLT_INSTALL_CHECK="include/libxslt/xslt.h"
export FM_LIBXSLT_HASH="5a3d6b383ca5afc235b171118e90f5ff6aa27e9fea3303065231a6d403f0183a"
export FM_LIBXSLT_HASH_TYPE="SHA-256"


