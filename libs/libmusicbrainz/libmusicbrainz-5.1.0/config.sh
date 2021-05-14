#!/bin/bash
# Configuration script for libmusicbrainz 5.1.0
# Library release date: 2014/11/13

export FM_MUSICBRAINZ_NAME="libmusicbrainz"
export FM_MUSICBRAINZ_VERSION="5.1.0"
export FM_MUSICBRAINZ_FULL_NAME="${FM_MUSICBRAINZ_NAME}-${FM_MUSICBRAINZ_VERSION}"
export FM_MUSICBRAINZ_TARBALL_NAME="${FM_MUSICBRAINZ_FULL_NAME}.tar.gz"
export FM_MUSICBRAINZ_TARBALL_DOWNLOAD_URL="https://github.com/metabrainz/libmusicbrainz/releases/download/release-${FM_MUSICBRAINZ_VERSION}/${FM_MUSICBRAINZ_TARBALL_NAME}"
export FM_MUSICBRAINZ_INSTALL_CHECK="include/musicbrainz5/defines.h"
export FM_MUSICBRAINZ_HASH="6749259e89bbb273f3f5ad7acdffb7c47a2cf8fcaeab4c4695484cef5f4c6b46"
export FM_MUSICBRAINZ_HASH_TYPE="SHA-256"

# MD5: 4cc5556aa40ff7ab8f8cb83965535bc3
