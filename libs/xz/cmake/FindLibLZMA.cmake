#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_path(LIBLZMA_INCLUDE_DIR NAMES lzma.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(LIBLZMA_LIBRARY NAMES lzma liblzma PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(LIBLZMA_INCLUDE_DIR LIBLZMA_LIBRARY)

if(LIBLZMA_INCLUDE_DIR AND EXISTS "${LIBLZMA_INCLUDE_DIR}/lzma/version.h")
    file(STRINGS "${LIBLZMA_INCLUDE_DIR}/lzma/version.h" MAJOR_VERSION_LINE REGEX "^#define LZMA_VERSION_MAJOR.*$")
    file(STRINGS "${LIBLZMA_INCLUDE_DIR}/lzma/version.h" MINOR_VERSION_LINE REGEX "^#define LZMA_VERSION_MINOR.*$")
    file(STRINGS "${LIBLZMA_INCLUDE_DIR}/lzma/version.h" PATCH_VERSION_LINE REGEX "^#define LZMA_VERSION_PATCH.*$")
    string(REGEX REPLACE "^.*LZMA_VERSION_MAJOR +([0-9]+).*$" "\\1" MAJOR_VERSION_NUMBER "${MAJOR_VERSION_LINE}")
    string(REGEX REPLACE "^.*LZMA_VERSION_MINOR +([0-9]+).*$" "\\1" MINOR_VERSION_NUMBER "${MINOR_VERSION_LINE}")
    string(REGEX REPLACE "^.*LZMA_VERSION_PATCH +([0-9]+).*$" "\\1" PATCH_VERSION_NUMBER "${PATCH_VERSION_LINE}")
    set(LIBLZMA_VERSION_STRING "${MAJOR_VERSION_NUMBER}.${MINOR_VERSION_NUMBER}.${PATCH_VERSION_NUMBER}")
endif()

debugMessage("LIBLZMA_INCLUDE_DIR: ${LIBLZMA_INCLUDE_DIR}")
debugMessage("LIBLZMA_LIBRARY: ${LIBLZMA_LIBRARY}")
debugMessage("LIBLZMA_VERSION_STRING: ${LIBLZMA_VERSION_STRING}")

find_package_handle_standard_args(LibLZMA
    REQUIRED_VARS   LIBLZMA_LIBRARY LIBLZMA_INCLUDE_DIR
    VERSION_VAR     LIBLZMA_VERSION_STRING)

if(LIBLZMA_FOUND)
    set(LIBLZMA_INCLUDE_DIRS ${LIBLZMA_INCLUDE_DIR})
    set(LIBLZMA_LIBRARIES ${LIBLZMA_LIBRARY})
    
    if(NOT TARGET LibLZMA::LibLZMA)
        add_library(LibLZMA::LibLZMA UNKNOWN IMPORTED)
        
        set_target_properties(LibLZMA::LibLZMA PROPERTIES
            IMPORTED_LOCATION             "${LIBLZMA_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${LIBLZMA_INCLUDE_DIR}"
            INTERFACE_COMPILE_DEFINITIONS "LZMA_API_STATIC")
    endif()
endif()
