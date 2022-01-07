#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_path(ZLIB_INCLUDE_DIR NAMES zlib.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(ZLIB_LIBRARY NAMES z zlib PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(ZLIB_INCLUDE_DIR ZLIB_LIBRARY)

if(ZLIB_INCLUDE_DIR AND EXISTS "${ZLIB_INCLUDE_DIR}/zlib.h")
    file(STRINGS "${ZLIB_INCLUDE_DIR}/zlib.h" VERSION_LINE REGEX "^#define ZLIB_VERSION \"[^\"]*\"$")
    string(REGEX REPLACE "^.*ZLIB_VERSION \"([0-9.]+).*$" "\\1" ZLIB_VERSION_STRING "${VERSION_LINE}")
endif()

debugMessage("ZLIB_INCLUDE_DIR: ${ZLIB_INCLUDE_DIR}")
debugMessage("ZLIB_LIBRARY: ${ZLIB_LIBRARY}")
debugMessage("ZLIB_VERSION_STRING: ${ZLIB_VERSION_STRING}")

find_package_handle_standard_args(ZLIB
    REQUIRED_VARS   ZLIB_LIBRARY ZLIB_INCLUDE_DIR
    VERSION_VAR     ZLIB_VERSION_STRING)

if(ZLIB_FOUND)
    set(ZLIB_INCLUDE_DIRS ${ZLIB_INCLUDE_DIR})
    set(ZLIB_LIBRARIES ${ZLIB_LIBRARY})
    
    if(NOT TARGET ZLIB::ZLIB)
        add_library(ZLIB::ZLIB UNKNOWN IMPORTED)
        
        set_target_properties(ZLIB::ZLIB PROPERTIES
            IMPORTED_LOCATION             "${ZLIB_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${ZLIB_INCLUDE_DIR}")
    endif()
endif()
