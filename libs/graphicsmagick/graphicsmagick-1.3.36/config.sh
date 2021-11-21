#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for graphicsmagick 1.3.36
# Library release date: 2020/12/26

export FM_GRAPHICSMAGICK_NAME="GraphicsMagick"
export FM_GRAPHICSMAGICK_VERSION="1.3.36"
export FM_GRAPHICSMAGICK_FULL_NAME="${FM_GRAPHICSMAGICK_NAME}-${FM_GRAPHICSMAGICK_VERSION}"
export FM_GRAPHICSMAGICK_TARBALL_NAME="${FM_GRAPHICSMAGICK_FULL_NAME}.tar.xz"
export FM_GRAPHICSMAGICK_TARBALL_DOWNLOAD_URL="ftp://ftp.graphicsmagick.org/pub/GraphicsMagick/1.3/${FM_GRAPHICSMAGICK_TARBALL_NAME}"
export FM_GRAPHICSMAGICK_INSTALL_CHECK="include/GraphicsMagick/Magick++.h"
export FM_GRAPHICSMAGICK_HASH="5d5b3fde759cdfc307aaf21df9ebd8c752e3f088bb051dd5df8aac7ba7338f46"
export FM_GRAPHICSMAGICK_HASH_TYPE="SHA-256"
