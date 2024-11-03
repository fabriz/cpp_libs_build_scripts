#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for brotli 1.1.0
# Library release date: 2023/08/31

export FM_BROTLI_NAME="brotli"
export FM_BROTLI_VERSION="1.1.0"
export FM_BROTLI_FULL_NAME="${FM_BROTLI_NAME}-${FM_BROTLI_VERSION}"
export FM_BROTLI_TARBALL_NAME="${FM_BROTLI_FULL_NAME}.tar.gz"
export FM_BROTLI_TARBALL_DOWNLOAD_URL="https://github.com/google/brotli/archive/refs/tags/v${FM_BROTLI_VERSION}.tar.gz"
export FM_BROTLI_INSTALL_CHECK="include/brotli/port.h"
export FM_BROTLI_HASH="e720a6ca29428b803f4ad165371771f5398faba397edf6778837a18599ea13ff"
export FM_BROTLI_HASH_TYPE="SHA-256"


