#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Build script for zxing-cpp 2.2.1
# Library release date: 2023/12/11

export FM_ZXINGCPP_NAME="zxing-cpp"
export FM_ZXINGCPP_VERSION="2.2.1"
export FM_ZXINGCPP_FULL_NAME="${FM_ZXINGCPP_NAME}-${FM_ZXINGCPP_VERSION}"
export FM_ZXINGCPP_TARBALL_NAME="${FM_ZXINGCPP_FULL_NAME}.tar.gz"
export FM_ZXINGCPP_TARBALL_DOWNLOAD_URL="https://github.com/nu-book/zxing-cpp/archive/refs/tags/v${FM_ZXINGCPP_VERSION}.tar.gz"
export FM_ZXINGCPP_INSTALL_CHECK="include/ZXing/ZXVersion.h"
export FM_ZXINGCPP_HASH="02078ae15f19f9d423a441f205b1d1bee32349ddda7467e2c84e8f08876f8635"
export FM_ZXINGCPP_HASH_TYPE="SHA-256"
