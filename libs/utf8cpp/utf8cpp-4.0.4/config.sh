#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for utf8cpp 4.0.4
# Library release date: 2023/12/10

export FM_UTF8CPP_NAME="utfcpp"
export FM_UTF8CPP_VERSION="4.0.4"
export FM_UTF8CPP_FULL_NAME="${FM_UTF8CPP_NAME}-${FM_UTF8CPP_VERSION}"
export FM_UTF8CPP_TARBALL_NAME="${FM_UTF8CPP_FULL_NAME}.tar.gz"
export FM_UTF8CPP_TARBALL_DOWNLOAD_URL="https://github.com/nemtrif/utfcpp/archive/v${FM_UTF8CPP_VERSION}.tar.gz"
export FM_UTF8CPP_INSTALL_CHECK="include/utf8cpp/utf8.h"
export FM_UTF8CPP_HASH="7c8a403d0c575d52473c8644cd9eb46c6ba028d2549bc3e0cdc2d45f5cfd78a0"
export FM_UTF8CPP_HASH_TYPE="SHA-256"
