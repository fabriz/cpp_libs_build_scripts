#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_path(OGG_INCLUDE_DIR NAMES ogg/ogg.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(OGG_LIBRARY NAMES ogg PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(OGG_INCLUDE_DIR OGG_LIBRARY)

set(OGG_VERSION_STRING ${CPPLIBS_LIBRARY_KNOWN_VERSION})

debugMessage("OGG_INCLUDE_DIR: ${OGG_INCLUDE_DIR}")
debugMessage("OGG_LIBRARY: ${OGG_LIBRARY}")
debugMessage("OGG_VERSION_STRING: ${OGG_VERSION_STRING}")

find_package_handle_standard_args(OGG
    REQUIRED_VARS   OGG_LIBRARY OGG_INCLUDE_DIR
    VERSION_VAR     OGG_VERSION_STRING)

if(OGG_FOUND)
    set(OGG_INCLUDE_DIRS ${OGG_INCLUDE_DIR})
    set(OGG_LIBRARIES ${OGG_LIBRARY})
    
    if(NOT TARGET OGG::OGG)
        add_library(OGG::OGG UNKNOWN IMPORTED)
        
        set_target_properties(OGG::OGG PROPERTIES
            IMPORTED_LOCATION             "${OGG_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${OGG_INCLUDE_DIR}")
    endif()
endif()
