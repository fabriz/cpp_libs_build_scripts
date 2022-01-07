#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_path(FFTW3_INCLUDE_DIR NAMES fftw3.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(FFTW3_LIBRARY NAMES fftw3 PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(FFTW3_INCLUDE_DIR FFTW3_LIBRARY)

set(FFTW3_VERSION_STRING ${CPPLIBS_LIBRARY_KNOWN_VERSION})

debugMessage("FFTW3_INCLUDE_DIR: ${FFTW3_INCLUDE_DIR}")
debugMessage("FFTW3_LIBRARY: ${FFTW3_LIBRARY}")
debugMessage("FFTW3_VERSION_STRING: ${FFTW3_VERSION_STRING}")

find_package_handle_standard_args(FFTW3
    REQUIRED_VARS   FFTW3_LIBRARY FFTW3_INCLUDE_DIR
    VERSION_VAR     FFTW3_VERSION_STRING)

if(FFTW3_FOUND)
    set(FFTW3_INCLUDE_DIRS ${FFTW3_INCLUDE_DIR})
    set(FFTW3_LIBRARIES ${FFTW3_LIBRARY})
    
    if(NOT TARGET FFTW3::FFTW3)
        add_library(FFTW3::FFTW3 UNKNOWN IMPORTED)
        
        set_target_properties(FFTW3::FFTW3 PROPERTIES
            IMPORTED_LOCATION             "${FFTW3_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${FFTW3_INCLUDE_DIR}")
    endif()
endif()
