#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Build script for zxing-cpp 1.3.0
# Library release date: 2022/05/03

export FM_ZXINGCPP_NAME="zxing-cpp"
export FM_ZXINGCPP_VERSION="1.3.0"
export FM_ZXINGCPP_FULL_NAME="${FM_ZXINGCPP_NAME}-${FM_ZXINGCPP_VERSION}"
export FM_ZXINGCPP_TARBALL_NAME="${FM_ZXINGCPP_FULL_NAME}.tar.gz"
export FM_ZXINGCPP_TARBALL_DOWNLOAD_URL="https://github.com/nu-book/zxing-cpp/archive/refs/tags/v${FM_ZXINGCPP_VERSION}.tar.gz"
export FM_ZXINGCPP_INSTALL_CHECK="include/ZXing/ZXVersion.h"
export FM_ZXINGCPP_HASH="bfd8fc706def30e34f96088b5a7afdbe0917831e57a774d34e3ee864b01c6891"
export FM_ZXINGCPP_HASH_TYPE="SHA-256"
