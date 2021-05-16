#!/bin/bash

FM_LIBSET_LIBS=(
    zlib/1.2.11
    bzip2/1.0.8
    xz/5.2.5
    zstd/1.4.8
    fftw/3.3.9
    sqlite/3.34.1
    openssl/1.1.1j
    libzip/1.7.3
    libzippp/4.0-1.7.3
    utf8cpp/3.1.2
    icu4c/68.2
    libxml2/2.9.10
    libxslt/1.1.34
    tinyxml2/8.0.0
    jansson/2.13.1
    neon/0.31.2
    curl/7.75.0
    libogg/1.3.4
    flac/1.3.3
    libcdio/2.1.0
    libcdio-paranoia/10.2+2.0.1
    libmusicbrainz/5.1.0
    libpng/1.6.37
    jpeg/9d
    libwebp/1.2.0
    libtiff/4.2.0
    graphicsmagick/1.3.36
    boost/1.75.0
    botan/2.17.3
    libodb/2.4.0
    libodb-sqlite/2.4.0
    libodb-boost/2.4.0
    thrift/0.14.0
    wt/4.5.0
    libical/3.0.9
)

# wt/4.5.0 fails to build with windows_mingw
if [ ${FM_TARGET_TOOLCHAIN} = "windows_mingw" ]; then
    FM_LIBSET_LIBS=("${FM_LIBSET_LIBS[@]/wt\/4.5.0/wt\/4.2.0}")
fi
