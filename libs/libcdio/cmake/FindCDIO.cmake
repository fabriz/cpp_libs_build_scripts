#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_path(CDIO_INCLUDE_DIR NAMES cdio/cdio.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(CDIO_CDIO_LIBRARY NAMES cdio PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(CDIO_CDIOXX_LIBRARY NAMES cdio++ PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(CDIO_ISO9660_LIBRARY NAMES iso9660 PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(CDIO_ISO9660XX_LIBRARY NAMES iso9660++ PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(CDIO_UDF_LIBRARY NAMES udf PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(CDIO_CDDA_LIBRARY NAMES cdio_cdda PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(CDIO_PARANOIA_LIBRARY NAMES cdio_paranoia PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(CDIO_INCLUDE_DIR CDIO_CDIO_LIBRARY CDIO_CDIOXX_LIBRARY CDIO_ISO9660_LIBRARY CDIO_ISO9660XX_LIBRARY CDIO_UDF_LIBRARY CDIO_CDDA_LIBRARY CDIO_PARANOIA_LIBRARY)

if(CDIO_INCLUDE_DIR AND EXISTS "${CDIO_INCLUDE_DIR}/cdio/version.h")
    file(STRINGS "${CDIO_INCLUDE_DIR}/cdio/version.h" VERSION_LINE REGEX "^#define CDIO_VERSION \"[^\"]*\"$")
    string(REGEX REPLACE "^.*CDIO_VERSION \"([0-9.]+).*$" "\\1" CDIO_VERSION_STRING "${VERSION_LINE}")
endif()

debugMessage("CDIO_INCLUDE_DIR: ${CDIO_INCLUDE_DIR}")
debugMessage("CDIO_CDIO_LIBRARY: ${CDIO_CDIO_LIBRARY}")
debugMessage("CDIO_CDIOXX_LIBRARY: ${CDIO_CDIOXX_LIBRARY}")
debugMessage("CDIO_ISO9660_LIBRARY: ${CDIO_ISO9660_LIBRARY}")
debugMessage("CDIO_ISO9660XX_LIBRARY: ${CDIO_ISO9660XX_LIBRARY}")
debugMessage("CDIO_UDF_LIBRARY: ${CDIO_UDF_LIBRARY}")
debugMessage("CDIO_CDDA_LIBRARY: ${CDIO_CDDA_LIBRARY}")
debugMessage("CDIO_PARANOIA_LIBRARY: ${CDIO_PARANOIA_LIBRARY}")
debugMessage("CDIO_VERSION_STRING: ${CDIO_VERSION_STRING}")

set(CDIO_COMPONENTS
    CDIO
    CDIOXX
    ISO9660
    ISO9660XX
    UDF
    CDDA
    PARANOIA)

validate_package_components(CDIO_COMPONENTS CDIO_FIND_COMPONENTS)
check_package_component_items(CDIO REQUIRED_ITEMS CDIO_INCLUDE_DIR CDIO_CDIO_LIBRARY)
check_package_component_items(CDIOXX REQUIRED_ITEMS CDIO_INCLUDE_DIR CDIO_CDIOXX_LIBRARY)
check_package_component_items(ISO9660 REQUIRED_ITEMS CDIO_INCLUDE_DIR CDIO_ISO9660_LIBRARY)
check_package_component_items(ISO9660XX REQUIRED_ITEMS CDIO_INCLUDE_DIR CDIO_ISO9660XX_LIBRARY)
check_package_component_items(UDF REQUIRED_ITEMS CDIO_INCLUDE_DIR CDIO_UDF_LIBRARY)
check_package_component_items(CDDA REQUIRED_ITEMS CDIO_INCLUDE_DIR CDIO_CDDA_LIBRARY)
check_package_component_items(PARANOIA REQUIRED_ITEMS CDIO_INCLUDE_DIR CDIO_PARANOIA_LIBRARY)

find_package_handle_standard_args(CDIO
    REQUIRED_VARS       CDIO_INCLUDE_DIR
    VERSION_VAR         CDIO_VERSION_STRING
    HANDLE_COMPONENTS)

if(CDIO_FOUND)
    set(CDIO_INCLUDE_DIR ${CDIO_INCLUDE_DIR})
    set(CDIO_CDIO_LIBRARIES ${CDIO_CDIO_LIBRARY})
    set(CDIO_CDIOXX_LIBRARIES ${CDIO_CDIOXX_LIBRARY})
    set(CDIO_ISO9660_LIBRARIES ${CDIO_ISO9660_LIBRARY})
    set(CDIO_ISO9660XX_LIBRARIES ${CDIO_ISO9660XX_LIBRARY})
    set(CDIO_UDF_LIBRARIES ${CDIO_UDF_LIBRARY})
    set(CDIO_CDDA_LIBRARIES ${CDIO_CDDA_LIBRARY})
    set(CDIO_PARANOIA_LIBRARIES ${CDIO_PARANOIA_LIBRARY})
    
    if(CDIO_CDIO_FOUND AND NOT TARGET CDIO::CDIO)
        add_library(CDIO::CDIO UNKNOWN IMPORTED)
        
        set_target_properties(CDIO::CDIO PROPERTIES
            IMPORTED_LOCATION             "${CDIO_CDIO_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${CDIO_INCLUDE_DIR}")

        if(MACOS)
            target_link_libraries(CDIO::CDIO INTERFACE "-framework DiskArbitration" "-framework IOKit")
        elseif(MINGW)
            target_link_libraries(CDIO::CDIO INTERFACE winmm)
        endif()
    endif()
    
    if(CDIO_CDIOXX_FOUND AND NOT TARGET CDIO::CDIOXX)
        add_library(CDIO::CDIOXX UNKNOWN IMPORTED)
        
        set_target_properties(CDIO::CDIOXX PROPERTIES
            IMPORTED_LOCATION             "${CDIO_CDIOXX_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${CDIO_INCLUDE_DIR}")
        
        target_link_libraries(CDIO::CDIOXX INTERFACE CDIO::CDIO)
    endif()
    
    if(CDIO_ISO9660_FOUND AND NOT TARGET CDIO::ISO9660)
        add_library(CDIO::ISO9660 UNKNOWN IMPORTED)
        
        set_target_properties(CDIO::ISO9660 PROPERTIES
            IMPORTED_LOCATION             "${CDIO_ISO9660_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${CDIO_INCLUDE_DIR}")
        
        target_link_libraries(CDIO::ISO9660 INTERFACE CDIO::CDIO)
    endif()
    
    if(CDIO_ISO9660XX_FOUND AND NOT TARGET CDIO::ISO9660XX)
        add_library(CDIO::ISO9660XX UNKNOWN IMPORTED)
        
        set_target_properties(CDIO::ISO9660XX PROPERTIES
            IMPORTED_LOCATION             "${CDIO_ISO9660XX_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${CDIO_INCLUDE_DIR}")
        
        target_link_libraries(CDIO::ISO9660XX INTERFACE CDIO::ISO9660)
    endif()
    
    if(CDIO_UDF_FOUND AND NOT TARGET CDIO::UDF)
        add_library(CDIO::UDF UNKNOWN IMPORTED)
        
        set_target_properties(CDIO::UDF PROPERTIES
            IMPORTED_LOCATION             "${CDIO_UDF_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${CDIO_INCLUDE_DIR}")
        
        target_link_libraries(CDIO::UDF INTERFACE CDIO::CDIO)
    endif()
    
    if(CDIO_CDDA_FOUND AND NOT TARGET CDIO::CDDA)
        add_library(CDIO::CDDA UNKNOWN IMPORTED)
        
        set_target_properties(CDIO::CDDA PROPERTIES
            IMPORTED_LOCATION             "${CDIO_CDDA_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${CDIO_INCLUDE_DIR}")
        
        target_link_libraries(CDIO::CDDA INTERFACE CDIO::CDIO)
    endif()
    
    if(CDIO_PARANOIA_FOUND AND NOT TARGET CDIO::PARANOIA)
        add_library(CDIO::PARANOIA UNKNOWN IMPORTED)
        
        set_target_properties(CDIO::PARANOIA PROPERTIES
            IMPORTED_LOCATION             "${CDIO_PARANOIA_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${CDIO_INCLUDE_DIR}")
        
        target_link_libraries(CDIO::PARANOIA INTERFACE CDIO::CDDA)
    endif()
endif()
