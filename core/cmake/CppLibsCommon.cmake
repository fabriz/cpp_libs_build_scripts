#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

function(debugMessage _message)
    get_filename_component(CALLER_FILE_NAME "${CMAKE_PARENT_LIST_FILE}" NAME_WE)
    string(REGEX REPLACE "^Find(.+)$" "\\1" CALLER_PACKAGE_NAME "${CALLER_FILE_NAME}")
    if (NOT ${CALLER_PACKAGE_NAME}_FIND_QUIETLY)
        message(DEBUG "[CPPLIBS] ${CALLER_FILE_NAME}: ${_message}")
    endif ()
endfunction()

function(warningMessage _message)
    get_filename_component(CALLER_FILE_NAME "${CMAKE_PARENT_LIST_FILE}" NAME_WE)
    string(REGEX REPLACE "^Find(.+)$" "\\1" CALLER_PACKAGE_NAME "${CALLER_FILE_NAME}")
    if (NOT ${CALLER_PACKAGE_NAME}_FIND_QUIETLY)
        message(WARNING "[CPPLIBS] ${CALLER_FILE_NAME}: ${_message}")
    endif ()
endfunction()

function(fatalError _message)
    get_filename_component(CALLER_FILE_NAME "${CMAKE_PARENT_LIST_FILE}" NAME_WE)
    message(FATAL_ERROR "[CPPLIBS] ${CALLER_FILE_NAME}: ${_message}")
endfunction()

macro(requiredDependencyMissing _dependency _isFatalError)
    if (DEFINED ${_isFatalError})
        fatalError("Required dependency ${_dependency} not found")
    else()
        debugMessage("Required dependency ${_dependency} not found")
    endif()
endmacro()

function(validate_package_components PACKAGE_COMPONENTS FIND_COMPONENTS)
    cmake_policy(PUSH)
    cmake_policy(SET CMP0057 NEW)
    get_filename_component(CALLER_FILE_NAME "${CMAKE_PARENT_LIST_FILE}" NAME_WE)
    string(REGEX REPLACE "^Find(.+)$" "\\1" CALLER_PACKAGE_NAME "${CALLER_FILE_NAME}")
    foreach(COMPONENT_NAME IN LISTS ${FIND_COMPONENTS})
        if (NOT COMPONENT_NAME IN_LIST ${PACKAGE_COMPONENTS})
            set(${CALLER_PACKAGE_NAME}_${COMPONENT_NAME}_FOUND FALSE PARENT_SCOPE)
            warningMessage("Unknown ${CALLER_PACKAGE_NAME} component: ${COMPONENT_NAME}")
        endif()
    endforeach()
    cmake_policy(POP)
endfunction()

function(check_package_component_items COMPONENT_NAME)
    get_filename_component(CALLER_FILE_NAME "${CMAKE_PARENT_LIST_FILE}" NAME_WE)
    string(REGEX REPLACE "^Find(.+)$" "\\1" CALLER_PACKAGE_NAME "${CALLER_FILE_NAME}")
    cmake_parse_arguments(PARSE_ARGV 1 CPC "" "" "REQUIRED_ITEMS")
    set(CPC_ALL_REQUIRED_ITEMS_FOUND TRUE)
    foreach(REQUIRED_ITEM IN LISTS CPC_REQUIRED_ITEMS)
        if(NOT EXISTS "${${REQUIRED_ITEM}}")
            set(CPC_ALL_REQUIRED_ITEMS_FOUND FALSE)
        endif()
    endforeach()
    string(TOUPPER ${CALLER_PACKAGE_NAME} UPPER_CALLER_PACKAGE_NAME)
    string(TOUPPER ${COMPONENT_NAME} UPPER_COMPONENT_NAME)
    set(${CALLER_PACKAGE_NAME}_${COMPONENT_NAME}_FOUND ${CPC_ALL_REQUIRED_ITEMS_FOUND} PARENT_SCOPE)
    set(${UPPER_CALLER_PACKAGE_NAME}_${UPPER_COMPONENT_NAME}_FOUND ${CPC_ALL_REQUIRED_ITEMS_FOUND} PARENT_SCOPE)
endfunction()


if(ANDROID)
    debugMessage("Target platform: Android")
elseif(IOS)
    debugMessage("Target platform: iOS")
elseif(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    set(MACOS TRUE)
    debugMessage("Target platform: macOS")
elseif(MINGW)
    debugMessage("Target platform: Windows/MinGW")
elseif(UNIX)
    set(LINUX TRUE)
    debugMessage("Target platform: Linux")
elseif(MSVC)
    debugMessage("Target platform: Windows/MSVC")
else()
    message(FATAL_ERROR "Target platform not detected.")
endif()


debugMessage("Source: ${CMAKE_PARENT_LIST_FILE}")

if(DEFINED CPPLIBS_VARIANT_ROOT)
    debugMessage("CPPLIBS_VARIANT_ROOT: (specified) ${CPPLIBS_VARIANT_ROOT}")
else()
    get_filename_component(CPPLIBS_VARIANT_ROOT "${CMAKE_CURRENT_LIST_DIR}/.." ABSOLUTE)
    debugMessage("CPPLIBS_VARIANT_ROOT: (detected) ${CPPLIBS_VARIANT_ROOT}")
endif()

include(FindPackageHandleStandardArgs)
