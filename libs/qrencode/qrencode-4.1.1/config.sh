#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for qrencode 4.1.1
# Library release date: 2020/09/28

export FM_QRENCODE_NAME="qrencode"
export FM_QRENCODE_VERSION="4.1.1"
export FM_QRENCODE_FULL_NAME="${FM_QRENCODE_NAME}-${FM_QRENCODE_VERSION}"
export FM_QRENCODE_TARBALL_NAME="${FM_QRENCODE_FULL_NAME}.tar.bz2"
export FM_QRENCODE_TARBALL_DOWNLOAD_URL="https://fukuchi.org/works/qrencode/${FM_QRENCODE_TARBALL_NAME}"
export FM_QRENCODE_INSTALL_CHECK="include/qrencode.h"
export FM_QRENCODE_HASH="981b3242c213e1b40ac88711912dd8c27ea11f3437d1a04b6b226499a6e991a8f0b3b10f818bcc104812192a1dac4ce05f16ecd847a50cb03d4859b84bad89b8"
export FM_QRENCODE_HASH_TYPE="SHA-512"
