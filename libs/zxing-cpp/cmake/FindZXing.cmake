#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_path(ZXING_INCLUDE_DIR NAMES ZXing/ZXVersion.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(ZXING_LIBRARY NAMES ZXing PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(ZXING_INCLUDE_DIR ZXING_LIBRARY)

if(ZXING_INCLUDE_DIR AND EXISTS "${ZXING_INCLUDE_DIR}/ZXing/ZXVersion.h")
    file(STRINGS "${ZXING_INCLUDE_DIR}/ZXing/ZXVersion.h" MAJOR_VERSION_LINE REGEX "^#define ZXING_VERSION_MAJOR.*$")
    file(STRINGS "${ZXING_INCLUDE_DIR}/ZXing/ZXVersion.h" MINOR_VERSION_LINE REGEX "^#define ZXING_VERSION_MINOR.*$")
    file(STRINGS "${ZXING_INCLUDE_DIR}/ZXing/ZXVersion.h" RELEASE_VERSION_LINE REGEX "^#define ZXING_VERSION_PATCH.*$")
    string(REGEX REPLACE "^.*ZXING_VERSION_MAJOR +([0-9]+).*$" "\\1" MAJOR_VERSION_NUMBER "${MAJOR_VERSION_LINE}")
    string(REGEX REPLACE "^.*ZXING_VERSION_MINOR +([0-9]+).*$" "\\1" MINOR_VERSION_NUMBER "${MINOR_VERSION_LINE}")
    string(REGEX REPLACE "^.*ZXING_VERSION_PATCH +([0-9]+).*$" "\\1" RELEASE_VERSION_NUMBER "${RELEASE_VERSION_LINE}")
    set(ZXING_VERSION_STRING "${MAJOR_VERSION_NUMBER}.${MINOR_VERSION_NUMBER}.${RELEASE_VERSION_NUMBER}")
endif()

debugMessage("ZXING_INCLUDE_DIR: ${ZXING_INCLUDE_DIR}")
debugMessage("ZXING_LIBRARY: ${ZXING_LIBRARY}")
debugMessage("ZXING_VERSION_STRING: ${ZXING_VERSION_STRING}")

find_package_handle_standard_args(ZXing
    REQUIRED_VARS   ZXING_LIBRARY ZXING_INCLUDE_DIR
    VERSION_VAR     ZXING_VERSION_STRING)

if(ZXING_FOUND)
    set(ZXING_INCLUDE_DIRS ${ZXING_INCLUDE_DIR})
    set(ZXING_LIBRARIES ${ZXING_LIBRARY})
    
    if(NOT TARGET ZXing::ZXing)
        add_library(ZXing::ZXing UNKNOWN IMPORTED)
        
        set_target_properties(ZXing::ZXing PROPERTIES
            IMPORTED_LOCATION             "${ZXING_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${ZXING_INCLUDE_DIR}")
    endif()
endif()
