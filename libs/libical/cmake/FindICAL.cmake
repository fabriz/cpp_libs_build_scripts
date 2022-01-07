#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_path(ICAL_INCLUDE_DIR NAMES libical/ical.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(ICAL_ICAL_LIBRARY NAMES ical libical PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(ICAL_ICALSS_LIBRARY NAMES icalss libicalss PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(ICAL_ICALVCAL_LIBRARY NAMES icalvcal libicalvcal PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(ICAL_ICALXX_LIBRARY NAMES ical_cxx libical_cxx PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(ICAL_ICALSSXX_LIBRARY NAMES icalss_cxx libicalss_cxx PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(ICAL_INCLUDE_DIR ICAL_ICAL_LIBRARY ICAL_ICALSS_LIBRARY ICAL_ICALVCAL_LIBRARY ICAL_ICALXX_LIBRARY ICAL_ICALSSXX_LIBRARY)

if(ICAL_INCLUDE_DIR AND EXISTS "${ICAL_INCLUDE_DIR}/libical/ical.h")
    file(STRINGS "${ICAL_INCLUDE_DIR}/libical/ical.h" MAJOR_VERSION_LINE REGEX "^#define ICAL_MAJOR_VERSION.*$")
    file(STRINGS "${ICAL_INCLUDE_DIR}/libical/ical.h" MINOR_VERSION_LINE REGEX "^#define ICAL_MINOR_VERSION.*$")
    file(STRINGS "${ICAL_INCLUDE_DIR}/libical/ical.h" PATCH_VERSION_LINE REGEX "^#define ICAL_PATCH_VERSION.*$")
    string(REGEX REPLACE "^.*ICAL_MAJOR_VERSION +\\(([0-9]+).*$" "\\1" MAJOR_VERSION_NUMBER "${MAJOR_VERSION_LINE}")
    string(REGEX REPLACE "^.*ICAL_MINOR_VERSION +\\(([0-9]+).*$" "\\1" MINOR_VERSION_NUMBER "${MINOR_VERSION_LINE}")
    string(REGEX REPLACE "^.*ICAL_PATCH_VERSION +\\(([0-9]+).*$" "\\1" PATCH_VERSION_NUMBER "${PATCH_VERSION_LINE}")
    set(ICAL_VERSION_STRING "${MAJOR_VERSION_NUMBER}.${MINOR_VERSION_NUMBER}.${PATCH_VERSION_NUMBER}")
endif()

debugMessage("ICAL_INCLUDE_DIR: ${ICAL_INCLUDE_DIR}")
debugMessage("ICAL_ICAL_LIBRARY: ${ICAL_ICAL_LIBRARY}")
debugMessage("ICAL_ICALSS_LIBRARY: ${ICAL_ICALSS_LIBRARY}")
debugMessage("ICAL_ICALVCAL_LIBRARY: ${ICAL_ICALVCAL_LIBRARY}")
debugMessage("ICAL_ICALXX_LIBRARY: ${ICAL_ICALXX_LIBRARY}")
debugMessage("ICAL_ICALSSXX_LIBRARY: ${ICAL_ICALSSXX_LIBRARY}")
debugMessage("ICAL_VERSION_STRING: ${ICAL_VERSION_STRING}")

set(ICAL_COMPONENTS
    ICAL
    ICALSS
    ICALVCAL
    ICALXX
    ICALSSXX)

validate_package_components(ICAL_COMPONENTS ICAL_FIND_COMPONENTS)
check_package_component_items(ICAL REQUIRED_ITEMS ICAL_INCLUDE_DIR ICAL_ICAL_LIBRARY)
check_package_component_items(ICALSS REQUIRED_ITEMS ICAL_INCLUDE_DIR ICAL_ICALSS_LIBRARY)
check_package_component_items(ICALVCAL REQUIRED_ITEMS ICAL_INCLUDE_DIR ICAL_ICALVCAL_LIBRARY)
check_package_component_items(ICALXX REQUIRED_ITEMS ICAL_INCLUDE_DIR ICAL_ICALXX_LIBRARY)
check_package_component_items(ICALSSXX REQUIRED_ITEMS ICAL_INCLUDE_DIR ICAL_ICALSSXX_LIBRARY)

find_package_handle_standard_args(ICAL
    REQUIRED_VARS   ICAL_INCLUDE_DIR
    VERSION_VAR     ICAL_VERSION_STRING
    HANDLE_COMPONENTS)

if(ICAL_FOUND)
    set(ICAL_INCLUDE_DIRS ${ICAL_INCLUDE_DIR})
    set(ICAL_ICAL_LIBRARIES ${ICAL_ICAL_LIBRARY})
    set(ICAL_ICALSS_LIBRARIES ${ICAL_ICALSS_LIBRARY})
    set(ICAL_ICALVCAL_LIBRARIES ${ICAL_ICALVCAL_LIBRARY})
    set(ICAL_ICALXX_LIBRARIES ${ICAL_ICALXX_LIBRARY})
    set(ICAL_ICALSSXX_LIBRARIES ${ICAL_ICALSSXX_LIBRARY})

    if(ICAL_ICAL_FOUND AND NOT TARGET ICAL::ICAL)
        add_library(ICAL::ICAL UNKNOWN IMPORTED)
        
        set_target_properties(ICAL::ICAL PROPERTIES
            IMPORTED_LOCATION             "${ICAL_ICAL_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${ICAL_INCLUDE_DIR}"
            INTERFACE_COMPILE_DEFINITIONS "LIBICAL_ICAL_STATIC_DEFINE")
    endif()
    
    if(ICAL_ICALSS_FOUND AND NOT TARGET ICAL::ICALSS)
        add_library(ICAL::ICALSS UNKNOWN IMPORTED)
        
        set_target_properties(ICAL::ICALSS PROPERTIES
            IMPORTED_LOCATION             "${ICAL_ICALSS_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${ICAL_INCLUDE_DIR}"
            INTERFACE_COMPILE_DEFINITIONS "LIBICAL_ICALSS_STATIC_DEFINE")
        
            target_link_libraries(ICAL::ICALSS INTERFACE ICAL::ICAL)
    endif()
    
    if(ICAL_ICALVCAL_FOUND AND NOT TARGET ICAL::ICALVCAL)
        add_library(ICAL::ICALVCAL UNKNOWN IMPORTED)
        
        set_target_properties(ICAL::ICALVCAL PROPERTIES
            IMPORTED_LOCATION             "${ICAL_ICALVCAL_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${ICAL_INCLUDE_DIR}"
            INTERFACE_COMPILE_DEFINITIONS "LIBICAL_VCAL_STATIC_DEFINE")
    endif()
    
    if(ICAL_ICALXX_FOUND AND NOT TARGET ICAL::ICALXX)
        add_library(ICAL::ICALXX UNKNOWN IMPORTED)
        
        set_target_properties(ICAL::ICALXX PROPERTIES
            IMPORTED_LOCATION             "${ICAL_ICALXX_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${ICAL_INCLUDE_DIR}")
        
        target_link_libraries(ICAL::ICALXX INTERFACE ICAL::ICAL)
    endif()
    
    if(ICAL_ICALSSXX_FOUND AND NOT TARGET ICAL::ICALSSXX)
        add_library(ICAL::ICALSSXX UNKNOWN IMPORTED)
        
        set_target_properties(ICAL::ICALSSXX PROPERTIES
            IMPORTED_LOCATION             "${ICAL_ICALSSXX_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${ICAL_INCLUDE_DIR}")
        
        target_link_libraries(ICAL::ICALSSXX INTERFACE ICAL::ICALSS ICAL::ICALXX)
    endif()
endif()
