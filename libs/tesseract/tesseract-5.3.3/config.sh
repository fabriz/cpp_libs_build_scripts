#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for tesseract 5.3.3
# Library release date: 2023/10/05

export FM_TESSERACT_NAME="tesseract"
export FM_TESSERACT_VERSION="5.3.3"
export FM_TESSERACT_FULL_NAME="${FM_TESSERACT_NAME}-${FM_TESSERACT_VERSION}"
export FM_TESSERACT_TARBALL_NAME="${FM_TESSERACT_FULL_NAME}.tar.gz"
export FM_TESSERACT_TARBALL_DOWNLOAD_URL="https://github.com/tesseract-ocr/tesseract/archive/refs/tags/${FM_TESSERACT_VERSION}.tar.gz"
export FM_TESSERACT_INSTALL_CHECK="include/tesseract/version.h"
export FM_TESSERACT_HASH="dc4329f85f41191b2d813b71b528ba6047745813474e583ccce8795ff2ff5681"
export FM_TESSERACT_HASH_TYPE="SHA-256"
