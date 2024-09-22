#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for graphicsmagick 1.3.45
# Library release date: 2024/08/27

export FM_GRAPHICSMAGICK_NAME="GraphicsMagick"
export FM_GRAPHICSMAGICK_VERSION="1.3.45"
export FM_GRAPHICSMAGICK_FULL_NAME="${FM_GRAPHICSMAGICK_NAME}-${FM_GRAPHICSMAGICK_VERSION}"
export FM_GRAPHICSMAGICK_TARBALL_NAME="${FM_GRAPHICSMAGICK_FULL_NAME}.tar.xz"
export FM_GRAPHICSMAGICK_TARBALL_DOWNLOAD_URL="https://downloads.sourceforge.net/project/graphicsmagick/graphicsmagick/${FM_GRAPHICSMAGICK_VERSION}/${FM_GRAPHICSMAGICK_TARBALL_NAME}"
export FM_GRAPHICSMAGICK_INSTALL_CHECK="include/GraphicsMagick/Magick++.h"
export FM_GRAPHICSMAGICK_HASH="dcea5167414f7c805557de2d7a47a9b3147bcbf617b91f5f0f4afe5e6543026b"
export FM_GRAPHICSMAGICK_HASH_TYPE="SHA-256"
