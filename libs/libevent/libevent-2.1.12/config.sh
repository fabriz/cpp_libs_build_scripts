#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libevent 2.1.12
# Library release date: 2020/07/05

export FM_LIBEVENT_NAME="libevent"
export FM_LIBEVENT_VERSION="2.1.12"
export FM_LIBEVENT_FULL_NAME="${FM_LIBEVENT_NAME}-${FM_LIBEVENT_VERSION}"
export FM_LIBEVENT_TARBALL_NAME="${FM_LIBEVENT_FULL_NAME}-stable.tar.gz"
export FM_LIBEVENT_TARBALL_DOWNLOAD_URL="https://github.com/libevent/libevent/releases/download/release-${FM_LIBEVENT_VERSION}-stable/${FM_LIBEVENT_TARBALL_NAME}"
export FM_LIBEVENT_UNTAR_DIR="${FM_LIBEVENT_FULL_NAME}-stable"
export FM_LIBEVENT_INSTALL_CHECK="include/event2/event.h"
export FM_LIBEVENT_HASH="92e6de1be9ec176428fd2367677e61ceffc2ee1cb119035037a27d346b0403bb"
export FM_LIBEVENT_HASH_TYPE="SHA-256"
