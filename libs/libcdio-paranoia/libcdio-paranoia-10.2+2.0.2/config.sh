#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libcdio-paranoia 10.2+2.0.2
# Library release date: 2024/07/20

export FM_LIBCDIOPARANOIA_NAME="libcdio-paranoia"
export FM_LIBCDIOPARANOIA_VERSION="10.2+2.0.2"
export FM_LIBCDIOPARANOIA_FULL_NAME="${FM_LIBCDIOPARANOIA_NAME}-${FM_LIBCDIOPARANOIA_VERSION}"
export FM_LIBCDIOPARANOIA_TARBALL_NAME="${FM_LIBCDIOPARANOIA_FULL_NAME}.tar.bz2"
export FM_LIBCDIOPARANOIA_TARBALL_DOWNLOAD_URL="https://ftp.gnu.org/gnu/libcdio/${FM_LIBCDIOPARANOIA_TARBALL_NAME}"
export FM_LIBCDIOPARANOIA_INSTALL_CHECK="include/cdio/paranoia/paranoia.h"
export FM_LIBCDIOPARANOIA_HASH="186892539dedd661276014d71318c8c8f97ecb1250a86625256abd4defbf0d0c"
export FM_LIBCDIOPARANOIA_HASH_TYPE="SHA-256"
