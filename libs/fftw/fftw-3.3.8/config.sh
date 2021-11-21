#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for fftw 3.3.8
# Library release date: 2018/05/24

export FM_FFTW_NAME="fftw"
export FM_FFTW_VERSION="3.3.8"
export FM_FFTW_FULL_NAME="${FM_FFTW_NAME}-${FM_FFTW_VERSION}"
export FM_FFTW_TARBALL_NAME="${FM_FFTW_FULL_NAME}.tar.gz"
export FM_FFTW_TARBALL_DOWNLOAD_URL="http://www.fftw.org/${FM_FFTW_TARBALL_NAME}"
export FM_FFTW_INSTALL_CHECK="include/fftw3.h"
export FM_FFTW_HASH="6113262f6e92c5bd474f2875fa1b01054c4ad5040f6b0da7c03c98821d9ae303"
export FM_FFTW_HASH_TYPE="SHA-256"
