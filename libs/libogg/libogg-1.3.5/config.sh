#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libogg 1.3.5
# Library release date: 2021/06/04

export FM_LIBOGG_NAME="libogg"
export FM_LIBOGG_VERSION="1.3.5"
export FM_LIBOGG_FULL_NAME="${FM_LIBOGG_NAME}-${FM_LIBOGG_VERSION}"
export FM_LIBOGG_TARBALL_NAME="${FM_LIBOGG_FULL_NAME}.tar.xz"
export FM_LIBOGG_TARBALL_DOWNLOAD_URL="https://ftp.osuosl.org/pub/xiph/releases/ogg/${FM_LIBOGG_TARBALL_NAME}"
export FM_LIBOGG_INSTALL_CHECK="include/ogg/ogg.h"
export FM_LIBOGG_HASH="c4d91be36fc8e54deae7575241e03f4211eb102afb3fc0775fbbc1b740016705"
export FM_LIBOGG_HASH_TYPE="SHA-256"
