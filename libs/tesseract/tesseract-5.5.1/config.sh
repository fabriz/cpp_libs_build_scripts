#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2025 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for tesseract 5.5.1
# Library release date: 2025/05/25

export FM_TESSERACT_NAME="tesseract"
export FM_TESSERACT_VERSION="5.5.1"
export FM_TESSERACT_FULL_NAME="${FM_TESSERACT_NAME}-${FM_TESSERACT_VERSION}"
export FM_TESSERACT_TARBALL_NAME="${FM_TESSERACT_FULL_NAME}.tar.gz"
export FM_TESSERACT_TARBALL_DOWNLOAD_URL="https://github.com/tesseract-ocr/tesseract/archive/refs/tags/${FM_TESSERACT_VERSION}.tar.gz"
export FM_TESSERACT_INSTALL_CHECK="include/tesseract/version.h"
export FM_TESSERACT_HASH="a7a3f2a7420cb6a6a94d80c24163e183cf1d2f1bed2df3bbc397c81808a57237"
export FM_TESSERACT_HASH_TYPE="SHA-256"
