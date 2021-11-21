#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for bzip2 1.0.6
# Library release date: 2010/09/06

export FM_BZIP2_NAME="bzip2"
export FM_BZIP2_VERSION="1.0.6"
export FM_BZIP2_FULL_NAME="${FM_BZIP2_NAME}-${FM_BZIP2_VERSION}"
export FM_BZIP2_TARBALL_NAME="${FM_BZIP2_FULL_NAME}.tar.gz"
#export FM_BZIP2_TARBALL_DOWNLOAD_URL="http://www.bzip.org/${FM_BZIP2_VERSION}/${FM_BZIP2_TARBALL_NAME}"  # No more active
export FM_BZIP2_TARBALL_DOWNLOAD_URL="https://sourceware.org/pub/bzip2/${FM_BZIP2_TARBALL_NAME}"
export FM_BZIP2_INSTALL_CHECK="include/bzlib.h"
export FM_BZIP2_HASH="00b516f4704d4a7cb50a1d97e6e8e15b"
export FM_BZIP2_HASH_TYPE="MD5"
