#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_path(DEFLATE_INCLUDE_DIR NAMES libdeflate.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(DEFLATE_LIBRARY NAMES deflate deflatestatic PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(DEFLATE_INCLUDE_DIR DEFLATE_LIBRARY)

if(DEFLATE_INCLUDE_DIR AND EXISTS "${DEFLATE_INCLUDE_DIR}/libdeflate.h")
    file(STRINGS "${DEFLATE_INCLUDE_DIR}/libdeflate.h" VERSION_LINE REGEX "^#define LIBDEFLATE_VERSION_STRING[^\"]+\"[^\"]*\"$")
    string(REGEX REPLACE "^.*LIBDEFLATE_VERSION_STRING[^\"]+\"([0-9.]+).*$" "\\1" DEFLATE_VERSION_STRING "${VERSION_LINE}")
endif()

debugMessage("DEFLATE_INCLUDE_DIR: ${DEFLATE_INCLUDE_DIR}")
debugMessage("DEFLATE_LIBRARY: ${DEFLATE_LIBRARY}")
debugMessage("DEFLATE_VERSION_STRING: ${DEFLATE_VERSION_STRING}")

find_package_handle_standard_args(Deflate
    REQUIRED_VARS   DEFLATE_LIBRARY DEFLATE_INCLUDE_DIR
    VERSION_VAR     DEFLATE_VERSION_STRING)

if(DEFLATE_FOUND)
    set(DEFLATE_INCLUDE_DIRS ${DEFLATE_INCLUDE_DIR})
    set(DEFLATE_LIBRARIES ${DEFLATE_LIBRARY})
    
    if(NOT TARGET Deflate::Deflate)
        add_library(Deflate::Deflate UNKNOWN IMPORTED)
        
        set_target_properties(Deflate::Deflate PROPERTIES
            IMPORTED_LOCATION             "${DEFLATE_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${DEFLATE_INCLUDE_DIR}")
    endif()
    
    set(Deflate_INCLUDE_DIRS ${DEFLATE_INCLUDE_DIRS})
    set(Deflate_LIBRARIES ${DEFLATE_LIBRARIES})
    set(Deflate_VERSION_STRING ${DEFLATE_VERSION_STRING})
endif()
