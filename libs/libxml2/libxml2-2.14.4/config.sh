#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2025 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libxml2 2.14.4
# Library release date: 2025/06/16

export FM_LIBXML2_NAME="libxml2"
export FM_LIBXML2_VERSION="2.14.4"
export FM_LIBXML2_FULL_NAME="${FM_LIBXML2_NAME}-${FM_LIBXML2_VERSION}"
export FM_LIBXML2_TARBALL_NAME="${FM_LIBXML2_FULL_NAME}.tar.xz"
export FM_LIBXML2_TARBALL_DOWNLOAD_URL="https://download.gnome.org/sources/libxml2/2.14/${FM_LIBXML2_TARBALL_NAME}"
export FM_LIBXML2_INSTALL_CHECK="include/libxml2/libxml/xmlversion.h"
export FM_LIBXML2_HASH="24175ec30a97cfa86bdf9befb7ccf4613f8f4b2713c5103e0dd0bc9c711a2773"
export FM_LIBXML2_HASH_TYPE="SHA-256"
