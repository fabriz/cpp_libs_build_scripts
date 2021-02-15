#!/bin/bash
# Configuration script for libcdio-paranoia 10.2+2.0.1
# Library release date: 2019/12/03

export FM_LIBCDIOPARANOIA_NAME="libcdio-paranoia"
export FM_LIBCDIOPARANOIA_VERSION="10.2+2.0.1"
export FM_LIBCDIOPARANOIA_FULL_NAME="${FM_LIBCDIOPARANOIA_NAME}-${FM_LIBCDIOPARANOIA_VERSION}"
export FM_LIBCDIOPARANOIA_TARBALL_NAME="${FM_LIBCDIOPARANOIA_FULL_NAME}.tar.bz2"
export FM_LIBCDIOPARANOIA_TARBALL_DOWNLOAD_URL="https://ftp.gnu.org/gnu/libcdio/${FM_LIBCDIOPARANOIA_TARBALL_NAME}"
export FM_LIBCDIOPARANOIA_INSTALL_CHECK="include/cdio/paranoia/paranoia.h"
export FM_LIBCDIOPARANOIA_HASH="33b1cf305ccfbfd03b43936975615000ce538b119989c4bec469577570b60e8a"
export FM_LIBCDIOPARANOIA_HASH_TYPE="SHA-256"