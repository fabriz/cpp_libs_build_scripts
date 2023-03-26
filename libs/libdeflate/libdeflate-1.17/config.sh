#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libdeflate 1.17
# Library release date: 2023/01/15

export FM_LIBDEFLATE_NAME="libdeflate"
export FM_LIBDEFLATE_VERSION="1.17"
export FM_LIBDEFLATE_FULL_NAME="${FM_LIBDEFLATE_NAME}-${FM_LIBDEFLATE_VERSION}"
export FM_LIBDEFLATE_TARBALL_NAME="${FM_LIBDEFLATE_FULL_NAME}.tar.gz"
export FM_LIBDEFLATE_TARBALL_DOWNLOAD_URL="https://github.com/ebiggers/libdeflate/archive/refs/tags/v${FM_LIBDEFLATE_VERSION}.tar.gz"
export FM_LIBDEFLATE_INSTALL_CHECK="include/libdeflate.h"
export FM_LIBDEFLATE_HASH="fa4615af671513fa2a53dc2e7a89ff502792e2bdfc046869ef35160fcc373763"
export FM_LIBDEFLATE_HASH_TYPE="SHA-256"



