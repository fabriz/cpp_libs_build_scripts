#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libxml2 2.9.13
# Library release date: 2022/02/19

export FM_LIBXML2_NAME="libxml2"
export FM_LIBXML2_VERSION="2.9.13"
export FM_LIBXML2_FULL_NAME="${FM_LIBXML2_NAME}-${FM_LIBXML2_VERSION}"
export FM_LIBXML2_TARBALL_NAME="${FM_LIBXML2_FULL_NAME}.tar.xz"
export FM_LIBXML2_TARBALL_DOWNLOAD_URL="https://download.gnome.org/sources/libxml2/2.9/${FM_LIBXML2_TARBALL_NAME}"
export FM_LIBXML2_INSTALL_CHECK="include/libxml2/libxml/xmlversion.h"
export FM_LIBXML2_HASH="276130602d12fe484ecc03447ee5e759d0465558fbc9d6bd144e3745306ebf0e"
export FM_LIBXML2_HASH_TYPE="SHA-256"
