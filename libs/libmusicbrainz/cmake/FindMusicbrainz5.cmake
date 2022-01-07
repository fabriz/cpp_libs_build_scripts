#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_package(Neon QUIET)

find_package(LibXml2 QUIET)
if(NOT LIBXML2_FOUND)
    requiredDependencyMissing("LibXml2" Musicbrainz5_FIND_REQUIRED)
    find_package_handle_standard_args(Musicbrainz5 REQUIRED_VARS LIBXML2_LIBRARY_MISSING)
    return()
endif()

find_path(MUSICBRAINZ5_INCLUDE_DIR NAMES musicbrainz5/Query.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(MUSICBRAINZ5_LIBRARY NAMES musicbrainz5 PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(MUSICBRAINZ5_INCLUDE_DIR MUSICBRAINZ5_LIBRARY)

set(MUSICBRAINZ5_VERSION_STRING ${CPPLIBS_LIBRARY_KNOWN_VERSION})

debugMessage("MUSICBRAINZ5_INCLUDE_DIR: ${MUSICBRAINZ5_INCLUDE_DIR}")
debugMessage("MUSICBRAINZ5_LIBRARY: ${MUSICBRAINZ5_LIBRARY}")
debugMessage("MUSICBRAINZ5_VERSION_STRING: ${MUSICBRAINZ5_VERSION_STRING}")

find_package_handle_standard_args(Musicbrainz5
    REQUIRED_VARS   MUSICBRAINZ5_LIBRARY MUSICBRAINZ5_INCLUDE_DIR
    VERSION_VAR     MUSICBRAINZ5_VERSION_STRING)

if(MUSICBRAINZ5_FOUND)
    set(MUSICBRAINZ5_INCLUDE_DIRS ${MUSICBRAINZ5_INCLUDE_DIR})
    set(MUSICBRAINZ5_LIBRARIES ${MUSICBRAINZ5_LIBRARY})
    
    if(NOT TARGET Musicbrainz5::Musicbrainz5)
        add_library(Musicbrainz5::Musicbrainz5 UNKNOWN IMPORTED)
        
        set_target_properties(Musicbrainz5::Musicbrainz5 PROPERTIES
            IMPORTED_LOCATION             "${MUSICBRAINZ5_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${MUSICBRAINZ5_INCLUDE_DIR}")
        
        if(NEON_FOUND)
            target_link_libraries(Musicbrainz5::Musicbrainz5 INTERFACE Neon::Neon)
        endif()
        
        target_link_libraries(Musicbrainz5::Musicbrainz5 INTERFACE LibXml2::LibXml2)
    endif()
endif()
