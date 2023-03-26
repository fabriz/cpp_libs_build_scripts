#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_path(ICU_INCLUDE_DIR NAMES unicode/uvernum.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(ICU_DATA_LIBRARY NAMES icudata icudt PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(ICU_UC_LIBRARY NAMES icuuc PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(ICU_I18N_LIBRARY NAMES icui18n icuin PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(ICU_IO_LIBRARY NAMES icuio PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(ICU_TU_LIBRARY NAMES icutu PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(ICU_TEST_LIBRARY NAMES icutest PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(ICU_INCLUDE_DIR ICU_DATA_LIBRARY ICU_UC_LIBRARY ICU_I18N_LIBRARY ICU_IO_LIBRARY ICU_TU_LIBRARY ICU_TEST_LIBRARY)

if(ICU_INCLUDE_DIR AND EXISTS "${ICU_INCLUDE_DIR}/unicode/uvernum.h")
    file(STRINGS "${ICU_INCLUDE_DIR}/unicode/uvernum.h" VERSION_LINE REGEX "^#define U_ICU_VERSION +\"[^\"]*\"$")
    string(REGEX REPLACE "^.*U_ICU_VERSION +\"([0-9.]+).*$" "\\1" ICU_VERSION_STRING "${VERSION_LINE}")
endif()

debugMessage("ICU_INCLUDE_DIR: ${ICU_INCLUDE_DIR}")
debugMessage("ICU_DATA_LIBRARY: ${ICU_DATA_LIBRARY}")
debugMessage("ICU_UC_LIBRARY: ${ICU_UC_LIBRARY}")
debugMessage("ICU_I18N_LIBRARY: ${ICU_I18N_LIBRARY}")
debugMessage("ICU_IO_LIBRARY: ${ICU_IO_LIBRARY}")
debugMessage("ICU_TU_LIBRARY: ${ICU_TU_LIBRARY}")
debugMessage("ICU_TEST_LIBRARY: ${ICU_TEST_LIBRARY}")
debugMessage("ICU_VERSION_STRING: ${ICU_VERSION_STRING}")

set(ICU_COMPONENTS
    data
    uc
    i18n
    io
    tu
    test)

validate_package_components(ICU_COMPONENTS ICU_FIND_COMPONENTS)
check_package_component_items(data REQUIRED_ITEMS ICU_INCLUDE_DIR ICU_DATA_LIBRARY)
check_package_component_items(uc REQUIRED_ITEMS ICU_INCLUDE_DIR ICU_UC_LIBRARY)
check_package_component_items(i18n REQUIRED_ITEMS ICU_INCLUDE_DIR ICU_I18N_LIBRARY)
check_package_component_items(io REQUIRED_ITEMS ICU_INCLUDE_DIR ICU_IO_LIBRARY)
check_package_component_items(tu REQUIRED_ITEMS ICU_INCLUDE_DIR ICU_TU_LIBRARY)
check_package_component_items(test REQUIRED_ITEMS ICU_INCLUDE_DIR ICU_TEST_LIBRARY)

find_package_handle_standard_args(ICU
    REQUIRED_VARS       ICU_INCLUDE_DIR
    VERSION_VAR         ICU_VERSION_STRING
    HANDLE_COMPONENTS)

if(ICU_FOUND)
    set(ICU_INCLUDE_DIRS ${ICU_INCLUDE_DIR})
    set(ICU_DATA_LIBRARIES ${ICU_DATA_LIBRARY})
    set(ICU_UC_LIBRARIES ${ICU_UC_LIBRARY})
    set(ICU_I18N_LIBRARIES ${ICU_I18N_LIBRARY})
    set(ICU_IO_LIBRARIES ${ICU_IO_LIBRARY})
    set(ICU_TU_LIBRARIES ${ICU_TU_LIBRARY})
    set(ICU_TEST_LIBRARIES ${ICU_TEST_LIBRARY})
    set(ICU_LIBRARIES ${ICU_TEST_LIBRARIES} ${ICU_TU_LIBRARIES} ${ICU_IO_LIBRARIES} ${ICU_I18N_LIBRARIES} ${ICU_UC_LIBRARIES} ${ICU_DATA_LIBRARIES})
    set(ICU_VERSION ${ICU_VERSION_STRING})
    set(ICU_DEFINITIONS "-DU_STATIC_IMPLEMENTATION")
    
    if(ICU_DATA_FOUND AND NOT TARGET ICU::data)
        add_library(ICU::data UNKNOWN IMPORTED)
        
        set_target_properties(ICU::data PROPERTIES
            IMPORTED_LOCATION             "${ICU_DATA_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${ICU_INCLUDE_DIR}"
            INTERFACE_COMPILE_DEFINITIONS "U_STATIC_IMPLEMENTATION")
    endif()

    if(ICU_UC_FOUND AND NOT TARGET ICU::uc)
        add_library(ICU::uc UNKNOWN IMPORTED)
        
        set_target_properties(ICU::uc PROPERTIES
            IMPORTED_LOCATION             "${ICU_UC_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${ICU_INCLUDE_DIR}")
        
        target_link_libraries(ICU::uc INTERFACE ICU::data)
        list(APPEND ICU_UC_LIBRARIES ${ICU_DATA_LIBRARIES})
    endif()
    
    if(ICU_I18N_FOUND AND NOT TARGET ICU::i18n)
        add_library(ICU::i18n UNKNOWN IMPORTED)
        
        set_target_properties(ICU::i18n PROPERTIES
            IMPORTED_LOCATION             "${ICU_I18N_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${ICU_INCLUDE_DIR}")
        
        target_link_libraries(ICU::i18n INTERFACE ICU::uc)
        list(APPEND ICU_I18N_LIBRARIES ${ICU_UC_LIBRARIES})
    endif()
    
    if(ICU_IO_FOUND AND NOT TARGET ICU::io)
        add_library(ICU::io UNKNOWN IMPORTED)
        
        set_target_properties(ICU::io PROPERTIES
            IMPORTED_LOCATION             "${ICU_IO_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${ICU_INCLUDE_DIR}")
        
        target_link_libraries(ICU::io INTERFACE ICU::i18n)
        list(APPEND ICU_IO_LIBRARIES ${ICU_I18N_LIBRARIES})
    endif()
    
    if(ICU_TU_FOUND AND NOT TARGET ICU::tu)
        add_library(ICU::tu UNKNOWN IMPORTED)
        
        set_target_properties(ICU::tu PROPERTIES
            IMPORTED_LOCATION             "${ICU_TU_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${ICU_INCLUDE_DIR}")
        
        target_link_libraries(ICU::tu INTERFACE ICU::i18n)
        list(APPEND ICU_TU_LIBRARIES ${ICU_I18N_LIBRARIES})
    endif()
    
    if(ICU_TEST_FOUND AND NOT TARGET ICU::test)
        add_library(ICU::test UNKNOWN IMPORTED)
        
        set_target_properties(ICU::test PROPERTIES
            IMPORTED_LOCATION             "${ICU_TEST_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${ICU_INCLUDE_DIR}")
        
        target_link_libraries(ICU::test INTERFACE ICU::uc)
        list(APPEND ICU_TEST_LIBRARIES ${ICU_UC_LIBRARIES})
    endif()
endif()
