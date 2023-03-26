#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_package(ZLIB QUIET)
if(NOT ZLIB_FOUND)
    requiredDependencyMissing("ZLIB" PNG_FIND_REQUIRED)
    find_package_handle_standard_args(PNG REQUIRED_VARS ZLIB_LIBRARY_MISSING)
    return()
endif()

find_path(PNG_INCLUDE_DIR NAMES png.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(PNG_LIBRARY NAMES png libpng_static PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(PNG_INCLUDE_DIR PNG_LIBRARY)

if(PNG_INCLUDE_DIR AND EXISTS "${PNG_INCLUDE_DIR}/png.h")
    file(STRINGS "${PNG_INCLUDE_DIR}/png.h" VERSION_LINE REGEX "^#define PNG_LIBPNG_VER_STRING \"[^\"]*\"$")
    string(REGEX REPLACE "^.*PNG_LIBPNG_VER_STRING \"([0-9.]+).*$" "\\1" PNG_VERSION_STRING "${VERSION_LINE}")
endif()

debugMessage("PNG_INCLUDE_DIR: ${PNG_INCLUDE_DIR}")
debugMessage("PNG_LIBRARY: ${PNG_LIBRARY}")
debugMessage("PNG_VERSION_STRING: ${PNG_VERSION_STRING}")
debugMessage("PNG_DEPENDENCIES: ZLIB=${ZLIB_FOUND}")

find_package_handle_standard_args(PNG
    REQUIRED_VARS   PNG_LIBRARY PNG_INCLUDE_DIR
    VERSION_VAR     PNG_VERSION_STRING)

if(PNG_FOUND)
    set(PNG_INCLUDE_DIRS ${PNG_INCLUDE_DIR})
    set(PNG_LIBRARIES ${PNG_LIBRARY} ${ZLIB_LIBRARY})
    set(PNG_DEFINITIONS "")
    
    if(NOT TARGET PNG::PNG)
        add_library(PNG::PNG UNKNOWN IMPORTED)
        
        set_target_properties(PNG::PNG PROPERTIES
            IMPORTED_LOCATION             "${PNG_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${PNG_INCLUDE_DIR}")
        
        target_link_libraries(PNG::PNG INTERFACE ZLIB::ZLIB)
        list(APPEND PNG_INCLUDE_DIRS ${ZLIB_INCLUDE_DIRS})
        list(APPEND PNG_LIBRARIES ${ZLIB_LIBRARIES})
    endif()
endif()
