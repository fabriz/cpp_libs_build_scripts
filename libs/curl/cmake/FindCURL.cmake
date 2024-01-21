#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_package(ZLIB QUIET)
find_package(ZSTD QUIET)
find_package(OpenSSL QUIET)

find_path(CURL_INCLUDE_DIR NAMES curl/curl.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(CURL_LIBRARY NAMES curl libcurl libcurl_a PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(CURL_INCLUDE_DIR CURL_LIBRARY)

if(CURL_INCLUDE_DIR AND EXISTS "${CURL_INCLUDE_DIR}/curl/curlver.h")
    file(STRINGS "${CURL_INCLUDE_DIR}/curl/curlver.h" VERSION_LINE REGEX "^#define LIBCURL_VERSION \"[^\"]*\"$")
    string(REGEX REPLACE "^.*LIBCURL_VERSION \"([0-9.]+).*$" "\\1" CURL_VERSION_STRING "${VERSION_LINE}")
endif()

debugMessage("CURL_INCLUDE_DIR: ${CURL_INCLUDE_DIR}")
debugMessage("CURL_LIBRARY: ${CURL_LIBRARY}")
debugMessage("CURL_VERSION_STRING: ${CURL_VERSION_STRING}")
debugMessage("CURL_DEPENDENCIES: ZLIB=${ZLIB_FOUND}, ZSTD=${ZSTD_FOUND}, OpenSSL=${OPENSSL_FOUND}")

find_package_handle_standard_args(CURL
    REQUIRED_VARS   CURL_LIBRARY CURL_INCLUDE_DIR
    VERSION_VAR     CURL_VERSION_STRING)

if(CURL_FOUND)
    set(CURL_INCLUDE_DIRS ${CURL_INCLUDE_DIR})
    set(CURL_LIBRARIES ${CURL_LIBRARY})
    set(CURL_DEFINITIONS "-DCURL_STATICLIB")

    if(NOT TARGET CURL::libcurl)
        add_library(CURL::libcurl UNKNOWN IMPORTED)

        set_target_properties(CURL::libcurl PROPERTIES
            IMPORTED_LOCATION             "${CURL_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${CURL_INCLUDE_DIR}"
            INTERFACE_COMPILE_DEFINITIONS "CURL_STATICLIB")

        if(ZLIB_FOUND)
            target_link_libraries(CURL::libcurl INTERFACE ZLIB::ZLIB)
            list(APPEND CURL_INCLUDE_DIRS ${ZLIB_INCLUDE_DIRS})
            list(APPEND CURL_LIBRARIES ${ZLIB_LIBRARIES})
        endif()
        
        if(ZSTD_FOUND)
            target_link_libraries(CURL::libcurl INTERFACE ZSTD::ZSTD)
            list(APPEND CURL_INCLUDE_DIRS ${ZSTD_INCLUDE_DIRS})
            list(APPEND CURL_LIBRARIES ${ZSTD_LIBRARIES})
        endif()

        if(OPENSSL_FOUND)
            target_link_libraries(CURL::libcurl INTERFACE OpenSSL::Crypto OpenSSL::SSL)
            list(APPEND CURL_INCLUDE_DIRS ${OPENSSL_INCLUDE_DIRS})
            list(APPEND CURL_LIBRARIES ${OPENSSL_SSL_LIBRARIES} ${OPENSSL_CRYPTO_LIBRARIES})
        endif()

        if(MACOS)
            target_link_libraries(CURL::libcurl INTERFACE "-framework CoreFoundation" "-framework LDAP" "-framework SystemConfiguration")
        elseif(MINGW)
            target_link_libraries(CURL::libcurl INTERFACE bcrypt crypt32 ws2_32 wldap32)
            list(APPEND CURL_LIBRARIES bcrypt crypt32 ws2_32 wldap32)
        elseif(MSVC)
            target_link_libraries(CURL::libcurl INTERFACE wldap32 Normaliz)
            list(APPEND CURL_LIBRARIES wldap32 Normaliz)
        endif()

        if(CMAKE_DL_LIBS)
            target_link_libraries(CURL::libcurl INTERFACE ${CMAKE_DL_LIBS})
            list(APPEND CURL_LIBRARIES ${CMAKE_DL_LIBS})
        endif()

    endif()
endif()
