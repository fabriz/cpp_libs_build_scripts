#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for wt 4.10.4
# Library release date: 2024/03/06

export FM_WT_NAME="wt"
export FM_WT_VERSION="4.10.4"
export FM_WT_FULL_NAME="${FM_WT_NAME}-${FM_WT_VERSION}"
export FM_WT_TARBALL_NAME="${FM_WT_FULL_NAME}.tar.gz"
export FM_WT_TARBALL_DOWNLOAD_URL="https://github.com/emweb/wt/archive/${FM_WT_VERSION}.tar.gz"
export FM_WT_INSTALL_CHECK="include/Wt/WGlobal.h"
export FM_WT_HASH="dd6092abe599d9254242225e801da38085847b3147c1748e1212f274398a2e9a"
export FM_WT_HASH_TYPE="SHA-256"
