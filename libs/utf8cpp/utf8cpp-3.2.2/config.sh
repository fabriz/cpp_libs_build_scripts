#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for utf8cpp 3.2.2
# Library release date: 2022/11/06

export FM_UTF8CPP_NAME="utfcpp"
export FM_UTF8CPP_VERSION="3.2.2"
export FM_UTF8CPP_FULL_NAME="${FM_UTF8CPP_NAME}-${FM_UTF8CPP_VERSION}"
export FM_UTF8CPP_TARBALL_NAME="${FM_UTF8CPP_FULL_NAME}.tar.gz"
export FM_UTF8CPP_TARBALL_DOWNLOAD_URL="https://github.com/nemtrif/utfcpp/archive/v${FM_UTF8CPP_VERSION}.tar.gz"
export FM_UTF8CPP_INSTALL_CHECK="include/utf8cpp/utf8.h"
export FM_UTF8CPP_HASH="6f81e7cb2be2a6a9109a8a0cb7dc39ec947f1bcdb5dfa4a660e11a23face19f5"
export FM_UTF8CPP_HASH_TYPE="SHA-256"
