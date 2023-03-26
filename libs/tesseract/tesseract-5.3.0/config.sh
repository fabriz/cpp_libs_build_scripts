#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for tesseract 5.3.0
# Library release date: 2022/12/20

export FM_TESSERACT_NAME="tesseract"
export FM_TESSERACT_VERSION="5.3.0"
export FM_TESSERACT_FULL_NAME="${FM_TESSERACT_NAME}-${FM_TESSERACT_VERSION}"
export FM_TESSERACT_TARBALL_NAME="${FM_TESSERACT_FULL_NAME}.tar.gz"
export FM_TESSERACT_TARBALL_DOWNLOAD_URL="https://github.com/tesseract-ocr/tesseract/archive/refs/tags/${FM_TESSERACT_VERSION}.tar.gz"
export FM_TESSERACT_INSTALL_CHECK="include/tesseract/version.h"
export FM_TESSERACT_HASH="7e70870f8341e5ea228af2836ce79a36eefa11b01b56177b4a8997f330c014b8"
export FM_TESSERACT_HASH_TYPE="SHA-256"
