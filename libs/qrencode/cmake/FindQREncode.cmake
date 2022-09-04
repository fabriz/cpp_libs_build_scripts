#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_path(QRENCODE_INCLUDE_DIR NAMES qrencode.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(QRENCODE_LIBRARY NAMES qrencode PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(QRENCODE_INCLUDE_DIR QRENCODE_LIBRARY)

set(QRENCODE_VERSION_STRING ${CPPLIBS_LIBRARY_KNOWN_VERSION})

debugMessage("QRENCODE_INCLUDE_DIR: ${QRENCODE_INCLUDE_DIR}")
debugMessage("QRENCODE_LIBRARY: ${QRENCODE_LIBRARY}")
debugMessage("QRENCODE_VERSION_STRING: ${QRENCODE_VERSION_STRING}")

find_package_handle_standard_args(QREncode
    REQUIRED_VARS   QRENCODE_LIBRARY QRENCODE_INCLUDE_DIR
    VERSION_VAR     QRENCODE_VERSION_STRING)

if(QRENCODE_FOUND)
    set(QRENCODE_INCLUDE_DIRS ${QRENCODE_INCLUDE_DIR})
    set(QRENCODE_LIBRARIES ${QRENCODE_LIBRARY})
    
    if(NOT TARGET QREncode::QREncode)
        add_library(QREncode::QREncode UNKNOWN IMPORTED)
        
        set_target_properties(QREncode::QREncode PROPERTIES
            IMPORTED_LOCATION             "${QRENCODE_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${QRENCODE_INCLUDE_DIR}")
    endif()
endif()
