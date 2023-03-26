#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_package(ZLIB QUIET)
find_package(OpenSSL QUIET)

find_path(THRIFT_INCLUDE_DIR NAMES thrift/Thrift.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(THRIFT_THRIFT_LIBRARY NAMES thrift thriftmd PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(THRIFT_THRIFTZ_LIBRARY NAMES thriftz thriftzmd PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(THRIFT_INCLUDE_DIR THRIFT_THRIFT_LIBRARY THRIFT_THRIFTZ_LIBRARY)

if(THRIFT_INCLUDE_DIR AND EXISTS "${THRIFT_INCLUDE_DIR}/thrift/config.h")
    file(STRINGS "${THRIFT_INCLUDE_DIR}/thrift/config.h" VERSION_LINE REGEX "^#define PACKAGE_VERSION +\"[^\"]*\"$")
    string(REGEX REPLACE "^.*PACKAGE_VERSION +\"([0-9.]+).*$" "\\1" THRIFT_VERSION_STRING "${VERSION_LINE}")
endif()

debugMessage("THRIFT_INCLUDE_DIR: ${THRIFT_INCLUDE_DIR}")
debugMessage("THRIFT_THRIFT_LIBRARY: ${THRIFT_THRIFT_LIBRARY}")
debugMessage("THRIFT_THRIFTZ_LIBRARY: ${THRIFT_THRIFTZ_LIBRARY}")
debugMessage("THRIFT_VERSION_STRING: ${THRIFT_VERSION_STRING}")
debugMessage("THRIFT_DEPENDENCIES: ZLIB=${ZLIB_FOUND}, OpenSSL=${OPENSSL_FOUND}")

set(Thrift_COMPONENTS
    Thrift
    Thriftz)

validate_package_components(Thrift_COMPONENTS Thrift_FIND_COMPONENTS)
check_package_component_items(Thrift REQUIRED_ITEMS THRIFT_INCLUDE_DIR THRIFT_THRIFT_LIBRARY)
check_package_component_items(Thriftz REQUIRED_ITEMS THRIFT_INCLUDE_DIR THRIFT_THRIFTZ_LIBRARY)

find_package_handle_standard_args(Thrift
    REQUIRED_VARS       THRIFT_INCLUDE_DIR
    VERSION_VAR         THRIFT_VERSION_STRING
    HANDLE_COMPONENTS)

if(THRIFT_FOUND)
    set(THRIFT_INCLUDE_DIRS ${THRIFT_INCLUDE_DIR})
    set(THRIFT_THRIFT_LIBRARIES ${THRIFT_THRIFT_LIBRARY})
    set(THRIFT_THRIFTZ_LIBRARIES ${THRIFT_THRIFTZ_LIBRARY})
    set(THRIFT_DEFINITIONS "-DTHRIFT_STATIC_DEFINE")

    if(THRIFT_THRIFT_FOUND AND NOT TARGET Thrift::Thrift)
        add_library(Thrift::Thrift UNKNOWN IMPORTED)
        
        set_target_properties(Thrift::Thrift PROPERTIES
            IMPORTED_LOCATION             "${THRIFT_THRIFT_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${THRIFT_INCLUDE_DIR}"
            INTERFACE_COMPILE_DEFINITIONS "THRIFT_STATIC_DEFINE")
        
        if(OPENSSL_SSL_FOUND)
            set(THRIFT_SSL_FOUND TRUE)
            target_link_libraries(Thrift::Thrift INTERFACE OpenSSL::SSL)
            list(APPEND THRIFT_INCLUDE_DIRS ${OPENSSL_INCLUDE_DIRS})
            list(APPEND THRIFT_THRIFT_LIBRARIES ${OPENSSL_SSL_LIBRARIES})
        endif()
    endif()

    if(THRIFT_THRIFTZ_FOUND AND NOT TARGET Thrift::Thriftz)
        add_library(Thrift::Thriftz UNKNOWN IMPORTED)
        
        set_target_properties(Thrift::Thriftz PROPERTIES
            IMPORTED_LOCATION             "${THRIFT_THRIFTZ_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${THRIFT_INCLUDE_DIR}")
        
        if(ZLIB_FOUND)
            target_link_libraries(Thrift::Thriftz INTERFACE ZLIB::ZLIB)
            list(APPEND THRIFT_INCLUDE_DIRS ${ZLIB_INCLUDE_DIRS})
            list(APPEND THRIFT_THRIFTZ_LIBRARIES ${ZLIB_LIBRARIES})
        endif()
        
        target_link_libraries(Thrift::Thriftz INTERFACE Thrift::Thrift)
        list(APPEND THRIFT_THRIFTZ_LIBRARIES ${THRIFT_THRIFT_LIBRARIES})
    endif()
endif()
