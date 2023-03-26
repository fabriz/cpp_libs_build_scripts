#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_package(OGG QUIET)
if(NOT OGG_FOUND)
    requiredDependencyMissing("OGG" FLAC_FIND_REQUIRED)
    find_package_handle_standard_args(FLAC REQUIRED_VARS OGG_LIBRARY_MISSING)
    return()
endif()

find_path(FLAC_INCLUDE_DIR NAMES FLAC/all.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(FLAC_FLAC_LIBRARY NAMES FLAC libFLAC PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(FLAC_FLACXX_LIBRARY NAMES FLAC++ libFLAC++ PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(FLAC_INCLUDE_DIR FLAC_FLAC_LIBRARY FLAC_FLACXX_LIBRARY)

set(FLAC_VERSION_STRING ${CPPLIBS_LIBRARY_KNOWN_VERSION})

debugMessage("FLAC_INCLUDE_DIR: ${FLAC_INCLUDE_DIR}")
debugMessage("FLAC_FLAC_LIBRARY: ${FLAC_FLAC_LIBRARY}")
debugMessage("FLAC_FLACXX_LIBRARY: ${FLAC_FLACXX_LIBRARY}")
debugMessage("FLAC_VERSION_STRING: ${FLAC_VERSION_STRING}")
debugMessage("FLAC_DEPENDENCIES: OGG=${OGG_FOUND}")

set(FLAC_COMPONENTS
    FLAC
    FLACXX)

validate_package_components(FLAC_COMPONENTS FLAC_FIND_COMPONENTS)
check_package_component_items(FLAC REQUIRED_ITEMS FLAC_INCLUDE_DIR FLAC_FLAC_LIBRARY)
check_package_component_items(FLACXX REQUIRED_ITEMS FLAC_INCLUDE_DIR FLAC_FLACXX_LIBRARY)

find_package_handle_standard_args(FLAC
    REQUIRED_VARS   FLAC_INCLUDE_DIR
    VERSION_VAR     FLAC_VERSION_STRING
    HANDLE_COMPONENTS)

if(FLAC_FOUND)
    set(FLAC_INCLUDE_DIRS ${FLAC_INCLUDE_DIR})
    set(FLAC_FLAC_LIBRARIES ${FLAC_FLAC_LIBRARY})
    set(FLAC_FLACXX_LIBRARIES ${FLAC_FLACXX_LIBRARY})
    set(FLAC_DEFINITIONS "-DFLAC__NO_DLL")
    
    if(FLAC_FLAC_FOUND AND NOT TARGET FLAC::FLAC)
        add_library(FLAC::FLAC UNKNOWN IMPORTED)
        
        set_target_properties(FLAC::FLAC PROPERTIES
            IMPORTED_LOCATION             "${FLAC_FLAC_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${FLAC_INCLUDE_DIR}"
            INTERFACE_COMPILE_DEFINITIONS "FLAC__NO_DLL")
        
        target_link_libraries(FLAC::FLAC INTERFACE OGG::OGG)
        list(APPEND FLAC_INCLUDE_DIRS ${OGG_INCLUDE_DIRS})
        list(APPEND FLAC_FLAC_LIBRARIES ${OGG_LIBRARIES})
    endif()
    
    if(FLAC_FLACXX_FOUND AND NOT TARGET FLAC::FLACXX)
        add_library(FLAC::FLACXX UNKNOWN IMPORTED)
        
        set_target_properties(FLAC::FLACXX PROPERTIES
            IMPORTED_LOCATION             "${FLAC_FLACXX_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${FLAC_INCLUDE_DIR}"
            INTERFACE_COMPILE_DEFINITIONS "FLAC__NO_DLL")
        
        target_link_libraries(FLAC::FLACXX INTERFACE FLAC::FLAC)
        list(APPEND FLAC_FLACXX_LIBRARIES ${FLAC_FLAC_LIBRARIES})
    endif()
endif()
