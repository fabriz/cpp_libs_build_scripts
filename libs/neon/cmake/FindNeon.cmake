#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_path(NEON_INCLUDE_DIR NAMES neon/ne_utils.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(NEON_LIBRARY NAMES neon libneon PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(NEON_INCLUDE_DIR NEON_LIBRARY)

set(NEON_VERSION_STRING ${CPPLIBS_LIBRARY_KNOWN_VERSION})

debugMessage("NEON_INCLUDE_DIR: ${NEON_INCLUDE_DIR}")
debugMessage("NEON_LIBRARY: ${NEON_LIBRARY}")
debugMessage("NEON_VERSION_STRING: ${NEON_VERSION_STRING}")

find_package_handle_standard_args(Neon
    REQUIRED_VARS   NEON_LIBRARY NEON_INCLUDE_DIR
    VERSION_VAR     NEON_VERSION_STRING)

if(NEON_FOUND)
    set(NEON_INCLUDE_DIRS ${NEON_INCLUDE_DIR})
    set(NEON_LIBRARIES ${NEON_LIBRARY})
    
    if(NOT TARGET Neon::Neon)
        add_library(Neon::Neon UNKNOWN IMPORTED)
        
        set_target_properties(Neon::Neon PROPERTIES
            IMPORTED_LOCATION             "${NEON_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${NEON_INCLUDE_DIR}")
    endif()
endif()
