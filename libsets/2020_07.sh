#!/bin/bash

FM_LIBSET_LIBS=(
    zlib/1.2.11
    bzip2/1.0.8
    xz/5.2.5
    zstd/1.4.5
    fftw/3.3.8
    sqlite/3.32.3
    openssl/1.1.1g
    libzip/1.6.1
    libzippp/3.1-1.6.1
    tinyxml2/8.0.0
    utf8cpp/3.1.1
    icu4c/67.1
    libogg/1.3.4
    flac/1.3.3
    libcdio/2.1.0
    libcdio-paranoia/10.2+2.0.1
    libpng/1.6.37
    jpeg/9d
    libwebp/1.1.0
    graphicsmagick/1.3.35
    boost/1.73.0
    botan/2.15.0
    libodb/2.4.0
    libodb-sqlite/2.4.0
    libodb-boost/2.4.0
    thrift/0.13.0
    wt/4.3.1
    libical/3.0.8
)

# wt/4.3.1 fails to build with windows_mingw
if [ ${FM_TARGET_TOOLCHAIN} = "windows_mingw" ]; then
    FM_LIBSET_LIBS=("${FM_LIBSET_LIBS[@]/wt\/4.3.1/wt\/4.2.0}")
fi

