#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_path(ICONV_INCLUDE_DIR NAMES iconv.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(ICONV_LIBRARY NAMES iconv libiconv PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(ICONV_INCLUDE_DIR ICONV_LIBRARY)

set(ICONV_VERSION_STRING ${CPPLIBS_LIBRARY_KNOWN_VERSION})

debugMessage("ICONV_INCLUDE_DIR: ${ICONV_INCLUDE_DIR}")
debugMessage("ICONV_LIBRARY: ${ICONV_LIBRARY}")
debugMessage("ICONV_VERSION_STRING: ${ICONV_VERSION_STRING}")

find_package_handle_standard_args(Iconv
    REQUIRED_VARS   ICONV_LIBRARY ICONV_INCLUDE_DIR
    VERSION_VAR     ICONV_VERSION_STRING)

if(ICONV_FOUND)
    set(ICONV_INCLUDE_DIRS ${ICONV_INCLUDE_DIR})
    set(ICONV_LIBRARIES ${ICONV_LIBRARY})
    
    if(NOT TARGET Iconv::Iconv)
        add_library(Iconv::Iconv UNKNOWN IMPORTED)
        
        set_target_properties(Iconv::Iconv PROPERTIES
            IMPORTED_LOCATION             "${ICONV_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${ICONV_INCLUDE_DIR}")
    endif()
endif()
