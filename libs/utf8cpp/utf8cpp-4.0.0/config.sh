#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for utf8cpp 4.0.0
# Library release date: 2023/10/22

export FM_UTF8CPP_NAME="utfcpp"
export FM_UTF8CPP_VERSION="4.0.0"
export FM_UTF8CPP_FULL_NAME="${FM_UTF8CPP_NAME}-${FM_UTF8CPP_VERSION}"
export FM_UTF8CPP_TARBALL_NAME="${FM_UTF8CPP_FULL_NAME}.tar.gz"
export FM_UTF8CPP_TARBALL_DOWNLOAD_URL="https://github.com/nemtrif/utfcpp/archive/v${FM_UTF8CPP_VERSION}.tar.gz"
export FM_UTF8CPP_INSTALL_CHECK="include/utf8.h"
export FM_UTF8CPP_HASH="ac44d9652aa2ee64d405c1705718f26b385337a9b8cf20bf2b2aac6435a16c1e"
export FM_UTF8CPP_HASH_TYPE="SHA-256"
