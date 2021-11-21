#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for fftw 3.3.9
# Library release date: 2020/12/13

export FM_FFTW_NAME="fftw"
export FM_FFTW_VERSION="3.3.9"
export FM_FFTW_FULL_NAME="${FM_FFTW_NAME}-${FM_FFTW_VERSION}"
export FM_FFTW_TARBALL_NAME="${FM_FFTW_FULL_NAME}.tar.gz"
export FM_FFTW_TARBALL_DOWNLOAD_URL="http://www.fftw.org/${FM_FFTW_TARBALL_NAME}"
export FM_FFTW_INSTALL_CHECK="include/fftw3.h"
export FM_FFTW_HASH="bf2c7ce40b04ae811af714deb512510cc2c17b9ab9d6ddcf49fe4487eea7af3d"
export FM_FFTW_HASH_TYPE="SHA-256"
