#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for graphicsmagick 1.3.38
# Library release date: 2022/03/26

export FM_GRAPHICSMAGICK_NAME="GraphicsMagick"
export FM_GRAPHICSMAGICK_VERSION="1.3.38"
export FM_GRAPHICSMAGICK_FULL_NAME="${FM_GRAPHICSMAGICK_NAME}-${FM_GRAPHICSMAGICK_VERSION}"
export FM_GRAPHICSMAGICK_TARBALL_NAME="${FM_GRAPHICSMAGICK_FULL_NAME}.tar.xz"
export FM_GRAPHICSMAGICK_TARBALL_DOWNLOAD_URL="https://downloads.sourceforge.net/project/graphicsmagick/graphicsmagick/${FM_GRAPHICSMAGICK_VERSION}/${FM_GRAPHICSMAGICK_TARBALL_NAME}"
export FM_GRAPHICSMAGICK_INSTALL_CHECK="include/GraphicsMagick/Magick++.h"
export FM_GRAPHICSMAGICK_HASH="d60cd9db59351d2b9cb19beb443170acaa28f073d13d258f67b3627635e32675"
export FM_GRAPHICSMAGICK_HASH_TYPE="SHA-256"
