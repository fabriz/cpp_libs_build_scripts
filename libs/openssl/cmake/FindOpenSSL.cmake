#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_package(Threads QUIET)

find_path(OPENSSL_INCLUDE_DIR NAMES openssl/opensslv.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(OPENSSL_CRYPTO_LIBRARY NAMES crypto libcrypto PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(OPENSSL_SSL_LIBRARY NAMES ssl libssl PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(OPENSSL_INCLUDE_DIR OPENSSL_CRYPTO_LIBRARY OPENSSL_SSL_LIBRARY)

if(OPENSSL_INCLUDE_DIR AND EXISTS "${OPENSSL_INCLUDE_DIR}/openssl/opensslv.h")
    file(STRINGS "${OPENSSL_INCLUDE_DIR}/openssl/opensslv.h" VERSION_LINE REGEX "^# define OPENSSL_VERSION_TEXT +\"OpenSSL [^\"]*\"$")
    string(REGEX REPLACE "^.*OPENSSL_VERSION_TEXT +\"OpenSSL ([^ ]+).*$" "\\1" OPENSSL_VERSION_STRING "${VERSION_LINE}")
endif()

debugMessage("OPENSSL_INCLUDE_DIR: ${OPENSSL_INCLUDE_DIR}")
debugMessage("OPENSSL_CRYPTO_LIBRARY: ${OPENSSL_CRYPTO_LIBRARY}")
debugMessage("OPENSSL_SSL_LIBRARY: ${OPENSSL_SSL_LIBRARY}")
debugMessage("OPENSSL_VERSION_STRING: ${OPENSSL_VERSION_STRING}")

set(OpenSSL_COMPONENTS
    Crypto
    SSL)

validate_package_components(OpenSSL_COMPONENTS OpenSSL_FIND_COMPONENTS)
check_package_component_items(Crypto REQUIRED_ITEMS OPENSSL_INCLUDE_DIR OPENSSL_CRYPTO_LIBRARY)
check_package_component_items(SSL REQUIRED_ITEMS OPENSSL_INCLUDE_DIR OPENSSL_SSL_LIBRARY)

find_package_handle_standard_args(OpenSSL
    REQUIRED_VARS       OPENSSL_INCLUDE_DIR
    VERSION_VAR         OPENSSL_VERSION_STRING
    HANDLE_COMPONENTS)

if(OPENSSL_FOUND)
    set(OPENSSL_INCLUDE_DIRS ${OPENSSL_INCLUDE_DIR})
    set(OPENSSL_CRYPTO_LIBRARIES ${OPENSSL_CRYPTO_LIBRARY})
    set(OPENSSL_SSL_LIBRARIES ${OPENSSL_SSL_LIBRARY})
    set(OPENSSL_LIBRARIES ${OPENSSL_SSL_LIBRARIES} ${OPENSSL_CRYPTO_LIBRARIES})
    set(OPENSSL_VERSION ${OPENSSL_VERSION_STRING})
    
    if(OPENSSL_CRYPTO_FOUND AND NOT TARGET OpenSSL::Crypto)
        add_library(OpenSSL::Crypto UNKNOWN IMPORTED)
        
        set_target_properties(OpenSSL::Crypto PROPERTIES
            IMPORTED_LOCATION             "${OPENSSL_CRYPTO_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${OPENSSL_INCLUDE_DIR}")
        
        if (MSVC)
            target_link_libraries(OpenSSL::Crypto INTERFACE crypt32 ws2_32)
            list(APPEND OPENSSL_CRYPTO_LIBRARIES crypt32 ws2_32)
        elseif(MINGW)
            target_link_libraries(OpenSSL::Crypto INTERFACE crypt32)
            list(APPEND OPENSSL_CRYPTO_LIBRARIES crypt32)
        endif()
        
        if(THREADS_FOUND)
            target_link_libraries(OpenSSL::Crypto INTERFACE Threads::Threads)
            list(APPEND OPENSSL_CRYPTO_LIBRARIES ${CMAKE_THREAD_LIBS_INIT})
        endif()

        if(CMAKE_DL_LIBS)
            target_link_libraries(OpenSSL::Crypto INTERFACE ${CMAKE_DL_LIBS})
            list(APPEND OPENSSL_CRYPTO_LIBRARIES ${CMAKE_DL_LIBS})
        endif()
    endif()
    
    if(OPENSSL_SSL_FOUND AND NOT TARGET OpenSSL::SSL)
        add_library(OpenSSL::SSL UNKNOWN IMPORTED)
        
        set_target_properties(OpenSSL::SSL PROPERTIES
            IMPORTED_LOCATION             "${OPENSSL_SSL_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${OPENSSL_INCLUDE_DIR}")
        
        target_link_libraries(OpenSSL::SSL INTERFACE OpenSSL::Crypto)
        set(OPENSSL_LIBRARIES ${OPENSSL_SSL_LIBRARIES} ${OPENSSL_CRYPTO_LIBRARIES})
    endif()
endif()
