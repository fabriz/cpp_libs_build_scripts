#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_path(BZIP2_INCLUDE_DIR NAMES bzlib.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BZIP2_LIBRARY NAMES bz2 libbz2 PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(BZIP2_INCLUDE_DIR BZIP2_LIBRARY)

if(BZIP2_INCLUDE_DIR AND EXISTS "${BZIP2_INCLUDE_DIR}/bzlib.h")
    file(STRINGS "${BZIP2_INCLUDE_DIR}/bzlib.h" VERSION_LINE REGEX "bzip2/libbzip2 version [0-9.]+ of")
    string(REGEX REPLACE "^.*bzip2/libbzip2 version ([0-9.]+) of.*$" "\\1" BZIP2_VERSION_STRING "${VERSION_LINE}")
endif()

debugMessage("BZIP2_INCLUDE_DIR: ${BZIP2_INCLUDE_DIR}")
debugMessage("BZIP2_LIBRARY: ${BZIP2_LIBRARY}")
debugMessage("BZIP2_VERSION_STRING: ${BZIP2_VERSION_STRING}")

find_package_handle_standard_args(BZip2
    REQUIRED_VARS   BZIP2_LIBRARY BZIP2_INCLUDE_DIR
    VERSION_VAR     BZIP2_VERSION_STRING)

if(BZIP2_FOUND)
    set(BZIP2_INCLUDE_DIRS ${BZIP2_INCLUDE_DIR})
    set(BZIP2_LIBRARIES ${BZIP2_LIBRARY})
    
    if(NOT TARGET BZip2::BZip2)
        add_library(BZip2::BZip2 UNKNOWN IMPORTED)
        
        set_target_properties(BZip2::BZip2 PROPERTIES
            IMPORTED_LOCATION             "${BZIP2_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BZIP2_INCLUDE_DIR}")
    endif()
endif()
