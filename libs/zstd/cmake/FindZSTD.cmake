#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_path(ZSTD_INCLUDE_DIR NAMES zstd.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(ZSTD_LIBRARY NAMES zstd zstd_static PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(ZSTD_INCLUDE_DIR ZSTD_LIBRARY)

if(ZSTD_INCLUDE_DIR AND EXISTS "${ZSTD_INCLUDE_DIR}/zstd.h")
    file(STRINGS "${ZSTD_INCLUDE_DIR}/zstd.h" MAJOR_VERSION_LINE REGEX "^#define ZSTD_VERSION_MAJOR.*$")
    file(STRINGS "${ZSTD_INCLUDE_DIR}/zstd.h" MINOR_VERSION_LINE REGEX "^#define ZSTD_VERSION_MINOR.*$")
    file(STRINGS "${ZSTD_INCLUDE_DIR}/zstd.h" RELEASE_VERSION_LINE REGEX "^#define ZSTD_VERSION_RELEASE.*$")
    string(REGEX REPLACE "^.*ZSTD_VERSION_MAJOR +([0-9]+).*$" "\\1" MAJOR_VERSION_NUMBER "${MAJOR_VERSION_LINE}")
    string(REGEX REPLACE "^.*ZSTD_VERSION_MINOR +([0-9]+).*$" "\\1" MINOR_VERSION_NUMBER "${MINOR_VERSION_LINE}")
    string(REGEX REPLACE "^.*ZSTD_VERSION_RELEASE +([0-9]+).*$" "\\1" RELEASE_VERSION_NUMBER "${RELEASE_VERSION_LINE}")
    set(ZSTD_VERSION_STRING "${MAJOR_VERSION_NUMBER}.${MINOR_VERSION_NUMBER}.${RELEASE_VERSION_NUMBER}")
endif()

debugMessage("ZSTD_INCLUDE_DIR: ${ZSTD_INCLUDE_DIR}")
debugMessage("ZSTD_LIBRARY: ${ZSTD_LIBRARY}")
debugMessage("ZSTD_VERSION_STRING: ${ZSTD_VERSION_STRING}")

find_package_handle_standard_args(ZSTD
    REQUIRED_VARS   ZSTD_LIBRARY ZSTD_INCLUDE_DIR
    VERSION_VAR     ZSTD_VERSION_STRING)

if(ZSTD_FOUND)
    set(ZSTD_INCLUDE_DIRS ${ZSTD_INCLUDE_DIR})
    set(ZSTD_LIBRARIES ${ZSTD_LIBRARY})
    
    if(NOT TARGET ZSTD::ZSTD)
        add_library(ZSTD::ZSTD UNKNOWN IMPORTED)
        
        set_target_properties(ZSTD::ZSTD PROPERTIES
            IMPORTED_LOCATION             "${ZSTD_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${ZSTD_INCLUDE_DIR}")
    endif()
endif()
