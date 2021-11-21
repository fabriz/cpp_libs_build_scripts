#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

function(debugMessage _message)
    get_filename_component(LOCAL_FILE_NAME "${CMAKE_PARENT_LIST_FILE}" NAME_WE)
    string(REGEX REPLACE "^Find(.+)$" "\\1" LOCAL_MODULE_NAME "${LOCAL_FILE_NAME}")
    if (NOT ${LOCAL_MODULE_NAME}_FIND_QUIETLY)
        message(DEBUG "[CPPLIBS] ${LOCAL_FILE_NAME}: ${_message}")
    endif ()
endfunction()


debugMessage("Source: ${CMAKE_PARENT_LIST_FILE}")

if(DEFINED CPPLIBS_VARIANT_ROOT)
    debugMessage("CPPLIBS_VARIANT_ROOT: (specified) ${CPPLIBS_VARIANT_ROOT}")
else()
    get_filename_component(CPPLIBS_VARIANT_ROOT "${CMAKE_CURRENT_LIST_DIR}/.." ABSOLUTE)
    debugMessage("CPPLIBS_VARIANT_ROOT: (detected) ${CPPLIBS_VARIANT_ROOT}")
endif()

include(FindPackageHandleStandardArgs)
