#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_path(JPEG_INCLUDE_DIR NAMES jpeglib.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(JPEG_LIBRARY NAMES jpeg PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(JPEG_INCLUDE_DIR JPEG_LIBRARY)

set(JPEG_VERSION_STRING ${CPPLIBS_LIBRARY_KNOWN_VERSION})

debugMessage("JPEG_INCLUDE_DIR: ${JPEG_INCLUDE_DIR}")
debugMessage("JPEG_LIBRARY: ${JPEG_LIBRARY}")
debugMessage("JPEG_VERSION_STRING: ${JPEG_VERSION_STRING}")

find_package_handle_standard_args(JPEG
    REQUIRED_VARS   JPEG_LIBRARY JPEG_INCLUDE_DIR
    VERSION_VAR     JPEG_VERSION_STRING)

if(JPEG_FOUND)
    set(JPEG_INCLUDE_DIRS ${JPEG_INCLUDE_DIR})
    set(JPEG_LIBRARIES ${JPEG_LIBRARY})
    
    if(NOT TARGET JPEG::JPEG)
        add_library(JPEG::JPEG UNKNOWN IMPORTED)
        
        set_target_properties(JPEG::JPEG PROPERTIES
            IMPORTED_LOCATION             "${JPEG_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${JPEG_INCLUDE_DIR}")
    endif()
endif()
