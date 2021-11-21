#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for utf8cpp 3.1.2
# Library release date: 2020/09/27

export FM_UTF8CPP_NAME="utfcpp"
export FM_UTF8CPP_VERSION="3.1.2"
export FM_UTF8CPP_FULL_NAME="${FM_UTF8CPP_NAME}-${FM_UTF8CPP_VERSION}"
export FM_UTF8CPP_TARBALL_NAME="${FM_UTF8CPP_FULL_NAME}.tar.gz"
export FM_UTF8CPP_TARBALL_DOWNLOAD_URL="https://github.com/nemtrif/utfcpp/archive/v${FM_UTF8CPP_VERSION}.tar.gz"
export FM_UTF8CPP_INSTALL_CHECK="include/utf8cpp/utf8.h"
export FM_UTF8CPP_HASH="fea3bfa39fb8bd7368077ea5e1e0db9a8951f7e6fb6d9400b00ab3d92b807c6d"
export FM_UTF8CPP_HASH_TYPE="SHA-256"
