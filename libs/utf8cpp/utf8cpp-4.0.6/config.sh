#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2025 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for utf8cpp 4.0.6
# Library release date: 2024/11/03

export FM_UTF8CPP_NAME="utfcpp"
export FM_UTF8CPP_VERSION="4.0.6"
export FM_UTF8CPP_FULL_NAME="${FM_UTF8CPP_NAME}-${FM_UTF8CPP_VERSION}"
export FM_UTF8CPP_TARBALL_NAME="${FM_UTF8CPP_FULL_NAME}.tar.gz"
export FM_UTF8CPP_TARBALL_DOWNLOAD_URL="https://github.com/nemtrif/utfcpp/archive/v${FM_UTF8CPP_VERSION}.tar.gz"
export FM_UTF8CPP_INSTALL_CHECK="include/utf8cpp/utf8.h"
export FM_UTF8CPP_HASH="6920a6a5d6a04b9a89b2a89af7132f8acefd46e0c2a7b190350539e9213816c0"
export FM_UTF8CPP_HASH_TYPE="SHA-256"
