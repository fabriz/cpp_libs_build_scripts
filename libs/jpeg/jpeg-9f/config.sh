#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for jpeg 9f
# Library release date: 2024/01/14

export FM_JPEG_NAME="jpegsrc"
export FM_JPEG_VERSION="9f"
export FM_JPEG_FULL_NAME="${FM_JPEG_NAME}.v${FM_JPEG_VERSION}"
export FM_JPEG_TARBALL_NAME="${FM_JPEG_FULL_NAME}.tar.gz"
export FM_JPEG_TARBALL_DOWNLOAD_URL="http://www.ijg.org/files/${FM_JPEG_TARBALL_NAME}"
export FM_JPEG_UNTAR_DIR="jpeg-${FM_JPEG_VERSION}"
export FM_JPEG_INSTALL_CHECK="include/jpeglib.h"
export FM_JPEG_HASH="04705c110cb2469caa79fb71fba3d7bf834914706e9641a4589485c1f832565b"
export FM_JPEG_HASH_TYPE="SHA-256"
