#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_package(Threads QUIET)

find_path(BOOST_INCLUDE_DIR NAMES boost/version.hpp PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_ATOMIC_LIBRARY NAMES boost_atomic libboost_atomic PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_CHRONO_LIBRARY NAMES boost_chrono libboost_chrono PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_CONTAINER_LIBRARY NAMES boost_container libboost_container PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_CONTEXT_LIBRARY NAMES boost_context libboost_context PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_CONTRACT_LIBRARY NAMES boost_contract libboost_contract PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_COROUTINE_LIBRARY NAMES boost_coroutine libboost_coroutine PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_DATE_TIME_LIBRARY NAMES boost_date_time libboost_date_time PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_EXCEPTION_LIBRARY NAMES boost_exception libboost_exception PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_FIBER_LIBRARY NAMES boost_fiber libboost_fiber PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_FILESYSTEM_LIBRARY NAMES boost_filesystem libboost_filesystem PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_GRAPH_LIBRARY NAMES boost_graph libboost_graph PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_IOSTREAMS_LIBRARY NAMES boost_iostreams libboost_iostreams PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_JSON_LIBRARY NAMES boost_json libboost_json PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_LOCALE_LIBRARY NAMES boost_locale libboost_locale PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_LOG_LIBRARY NAMES boost_log libboost_log PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_LOG_SETUP_LIBRARY NAMES boost_log_setup libboost_log_setup PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_NOWIDE_LIBRARY NAMES boost_nowide libboost_nowide PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_PRG_EXEC_MONITOR_LIBRARY NAMES boost_prg_exec_monitor libboost_prg_exec_monitor PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_PROGRAM_OPTIONS_LIBRARY NAMES boost_program_options libboost_program_options PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_RANDOM_LIBRARY NAMES boost_random libboost_random PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_REGEX_LIBRARY NAMES boost_regex libboost_regex PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_SERIALIZATION_LIBRARY NAMES boost_serialization libboost_serialization PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_SYSTEM_LIBRARY NAMES boost_system libboost_system PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_TEST_EXEC_MONITOR_LIBRARY NAMES boost_test_exec_monitor libboost_test_exec_monitor PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_THREAD_LIBRARY NAMES boost_thread libboost_thread PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_TIMER_LIBRARY NAMES boost_timer libboost_timer PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_TYPE_ERASURE_LIBRARY NAMES boost_type_erasure libboost_type_erasure PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_UNIT_TEST_FRAMEWORK_LIBRARY NAMES boost_unit_test_framework libboost_unit_test_framework PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_WAVE_LIBRARY NAMES boost_wave libboost_wave PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOOST_WSERIALIZATION_LIBRARY NAMES boost_wserialization libboost_wserialization PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)

mark_as_advanced(BOOST_INCLUDE_DIR BOOST_ATOMIC_LIBRARY BOOST_CHRONO_LIBRARY BOOST_CONTAINER_LIBRARY BOOST_CONTEXT_LIBRARY 
    BOOST_CONTRACT_LIBRARY BOOST_COROUTINE_LIBRARY BOOST_DATE_TIME_LIBRARY BOOST_EXCEPTION_LIBRARY BOOST_FIBER_LIBRARY
    BOOST_FILESYSTEM_LIBRARY BOOST_GRAPH_LIBRARY BOOST_IOSTREAMS_LIBRARY BOOST_JSON_LIBRARY BOOST_LOCALE_LIBRARY
    BOOST_LOG_LIBRARY BOOST_LOG_SETUP_LIBRARY BOOST_NOWIDE_LIBRARY BOOST_PRG_EXEC_MONITOR_LIBRARY BOOST_PROGRAM_OPTIONS_LIBRARY
    BOOST_RANDOM_LIBRARY BOOST_REGEX_LIBRARY BOOST_SERIALIZATION_LIBRARY BOOST_SYSTEM_LIBRARY BOOST_TEST_EXEC_MONITOR_LIBRARY
    BOOST_THREAD_LIBRARY BOOST_TIMER_LIBRARY BOOST_TYPE_ERASURE_LIBRARY BOOST_UNIT_TEST_FRAMEWORK_LIBRARY BOOST_WAVE_LIBRARY
    BOOST_WSERIALIZATION_LIBRARY)

if(BOOST_INCLUDE_DIR AND EXISTS "${BOOST_INCLUDE_DIR}/boost/version.hpp")
    file(STRINGS "${BOOST_INCLUDE_DIR}/boost/version.hpp" VERSION_LINE REGEX "^#define BOOST_VERSION *([0-9.]+).*$")
    string(REGEX REPLACE "^.*BOOST_VERSION *([0-9.]+).*$" "\\1" BOOST_VERSION_NUMBER "${VERSION_LINE}")
    math(EXPR MAJOR_VERSION_NUMBER "${BOOST_VERSION_NUMBER} / 100000")
    math(EXPR MINOR_VERSION_NUMBER "${BOOST_VERSION_NUMBER} / 100 % 1000")
    math(EXPR PATCH_VERSION_NUMBER "${BOOST_VERSION_NUMBER} % 100")
    set(BOOST_VERSION_STRING "${MAJOR_VERSION_NUMBER}.${MINOR_VERSION_NUMBER}.${PATCH_VERSION_NUMBER}")
endif()

debugMessage("BOOST_INCLUDE_DIR: ${BOOST_INCLUDE_DIR}")
debugMessage("BOOST_ATOMIC_LIBRARY: ${BOOST_ATOMIC_LIBRARY}")
debugMessage("BOOST_CHRONO_LIBRARY: ${BOOST_CHRONO_LIBRARY}")
debugMessage("BOOST_CONTAINER_LIBRARY: ${BOOST_CONTAINER_LIBRARY}")
debugMessage("BOOST_CONTEXT_LIBRARY: ${BOOST_CONTEXT_LIBRARY}")
debugMessage("BOOST_CONTRACT_LIBRARY: ${BOOST_CONTRACT_LIBRARY}")
debugMessage("BOOST_COROUTINE_LIBRARY: ${BOOST_COROUTINE_LIBRARY}")
debugMessage("BOOST_DATE_TIME_LIBRARY: ${BOOST_DATE_TIME_LIBRARY}")
debugMessage("BOOST_EXCEPTION_LIBRARY: ${BOOST_EXCEPTION_LIBRARY}")
debugMessage("BOOST_FIBER_LIBRARY: ${BOOST_FIBER_LIBRARY}")
debugMessage("BOOST_FILESYSTEM_LIBRARY: ${BOOST_FILESYSTEM_LIBRARY}")
debugMessage("BOOST_GRAPH_LIBRARY: ${BOOST_GRAPH_LIBRARY}")
debugMessage("BOOST_IOSTREAMS_LIBRARY: ${BOOST_IOSTREAMS_LIBRARY}")
debugMessage("BOOST_JSON_LIBRARY: ${BOOST_JSON_LIBRARY}")
debugMessage("BOOST_LOCALE_LIBRARY: ${BOOST_LOCALE_LIBRARY}")
debugMessage("BOOST_LOG_LIBRARY: ${BOOST_LOG_LIBRARY}")
debugMessage("BOOST_LOG_SETUP_LIBRARY: ${BOOST_LOG_SETUP_LIBRARY}")
debugMessage("BOOST_NOWIDE_LIBRARY: ${BOOST_NOWIDE_LIBRARY}")
debugMessage("BOOST_PRG_EXEC_MONITOR_LIBRARY: ${BOOST_PRG_EXEC_MONITOR_LIBRARY}")
debugMessage("BOOST_PROGRAM_OPTIONS_LIBRARY: ${BOOST_PROGRAM_OPTIONS_LIBRARY}")
debugMessage("BOOST_RANDOM_LIBRARY: ${BOOST_RANDOM_LIBRARY}")
debugMessage("BOOST_REGEX_LIBRARY: ${BOOST_REGEX_LIBRARY}")
debugMessage("BOOST_SERIALIZATION_LIBRARY: ${BOOST_SERIALIZATION_LIBRARY}")
debugMessage("BOOST_SYSTEM_LIBRARY: ${BOOST_SYSTEM_LIBRARY}")
debugMessage("BOOST_TEST_EXEC_MONITOR_LIBRARY: ${BOOST_TEST_EXEC_MONITOR_LIBRARY}")
debugMessage("BOOST_THREAD_LIBRARY: ${BOOST_THREAD_LIBRARY}")
debugMessage("BOOST_TIMER_LIBRARY: ${BOOST_TIMER_LIBRARY}")
debugMessage("BOOST_TYPE_ERASURE_LIBRARY: ${BOOST_TYPE_ERASURE_LIBRARY}")
debugMessage("BOOST_UNIT_TEST_FRAMEWORK_LIBRARY: ${BOOST_UNIT_TEST_FRAMEWORK_LIBRARY}")
debugMessage("BOOST_WAVE_LIBRARY: ${BOOST_WAVE_LIBRARY}")
debugMessage("BOOST_WSERIALIZATION_LIBRARY: ${BOOST_WSERIALIZATION_LIBRARY}")
debugMessage("BOOST_VERSION_STRING: ${BOOST_VERSION_STRING}")

set(Boost_COMPONENTS
    headers
    boost
    disable_autolinking
    atomic
    chrono
    container
    context
    contract
    coroutine
    date_time
    exception
    fiber
    filesystem
    graph
    iostreams
    json
    locale
    log
    log_setup
    nowide
    prg_exec_monitor
    program_options
    random
    regex
    serialization
    system
    test_exec_monitor
    thread
    timer
    type_erasure
    unit_test_framework
    wave
    wserialization)

validate_package_components(Boost_COMPONENTS Boost_FIND_COMPONENTS)
check_package_component_items(headers REQUIRED_ITEMS BOOST_INCLUDE_DIR)
check_package_component_items(boost REQUIRED_ITEMS BOOST_INCLUDE_DIR)
check_package_component_items(disable_autolinking REQUIRED_ITEMS BOOST_INCLUDE_DIR)
check_package_component_items(atomic REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_ATOMIC_LIBRARY)
check_package_component_items(chrono REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_CHRONO_LIBRARY)
check_package_component_items(container REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_CONTAINER_LIBRARY)
check_package_component_items(context REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_CONTEXT_LIBRARY)
check_package_component_items(contract REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_CONTRACT_LIBRARY)
check_package_component_items(coroutine REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_COROUTINE_LIBRARY)
check_package_component_items(date_time REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_DATE_TIME_LIBRARY)
check_package_component_items(exception REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_EXCEPTION_LIBRARY)
check_package_component_items(fiber REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_FIBER_LIBRARY)
check_package_component_items(filesystem REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_FILESYSTEM_LIBRARY)
check_package_component_items(graph REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_GRAPH_LIBRARY)
check_package_component_items(iostreams REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_IOSTREAMS_LIBRARY)
check_package_component_items(json REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_JSON_LIBRARY)
check_package_component_items(locale REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_LOCALE_LIBRARY)
check_package_component_items(log REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_LOG_LIBRARY)
check_package_component_items(log_setup REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_LOG_SETUP_LIBRARY)
check_package_component_items(nowide REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_NOWIDE_LIBRARY)
check_package_component_items(prg_exec_monitor REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_PRG_EXEC_MONITOR_LIBRARY)
check_package_component_items(program_options REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_PROGRAM_OPTIONS_LIBRARY)
check_package_component_items(random REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_RANDOM_LIBRARY)
check_package_component_items(regex REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_REGEX_LIBRARY)
check_package_component_items(serialization REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_SERIALIZATION_LIBRARY)
check_package_component_items(system REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_SYSTEM_LIBRARY)
check_package_component_items(test_exec_monitor REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_TEST_EXEC_MONITOR_LIBRARY)
check_package_component_items(thread REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_THREAD_LIBRARY)
check_package_component_items(timer REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_TIMER_LIBRARY)
check_package_component_items(type_erasure REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_TYPE_ERASURE_LIBRARY)
check_package_component_items(unit_test_framework REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_UNIT_TEST_FRAMEWORK_LIBRARY)
check_package_component_items(wave REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_WAVE_LIBRARY)
check_package_component_items(wserialization REQUIRED_ITEMS BOOST_INCLUDE_DIR BOOST_WSERIALIZATION_LIBRARY)

find_package_handle_standard_args(Boost
    REQUIRED_VARS   BOOST_INCLUDE_DIR
    VERSION_VAR     BOOST_VERSION_STRING
    HANDLE_COMPONENTS)

if(BOOST_FOUND)
    set(BOOST_INCLUDE_DIRS ${BOOST_INCLUDE_DIR})
    set(BOOST_ATOMIC_LIBRARIES ${BOOST_ATOMIC_LIBRARY})
    set(BOOST_CHRONO_LIBRARIES ${BOOST_CHRONO_LIBRARY})
    set(BOOST_CONTAINER_LIBRARIES ${BOOST_CONTAINER_LIBRARY})
    set(BOOST_CONTEXT_LIBRARIES ${BOOST_CONTEXT_LIBRARY})
    set(BOOST_CONTRACT_LIBRARIES ${BOOST_CONTRACT_LIBRARY})
    set(BOOST_COROUTINE_LIBRARIES ${BOOST_COROUTINE_LIBRARY})
    set(BOOST_DATE_TIME_LIBRARIES ${BOOST_DATE_TIME_LIBRARY})
    set(BOOST_EXCEPTION_LIBRARIES ${BOOST_EXCEPTION_LIBRARY})
    set(BOOST_FIBER_LIBRARIES ${BOOST_FIBER_LIBRARY})
    set(BOOST_FILESYSTEM_LIBRARIES ${BOOST_FILESYSTEM_LIBRARY})
    set(BOOST_GRAPH_LIBRARIES ${BOOST_GRAPH_LIBRARY})
    set(BOOST_IOSTREAMS_LIBRARIES ${BOOST_IOSTREAMS_LIBRARY})
    set(BOOST_JSON_LIBRARIES ${BOOST_JSON_LIBRARY})
    set(BOOST_LOCALE_LIBRARIES ${BOOST_LOCALE_LIBRARY})
    set(BOOST_LOG_LIBRARIES ${BOOST_LOG_LIBRARY})
    set(BOOST_LOG_SETUP_LIBRARIES ${BOOST_LOG_SETUP_LIBRARY})
    set(BOOST_NOWIDE_LIBRARIES ${BOOST_NOWIDE_LIBRARY})
    set(BOOST_PRG_EXEC_MONITOR_LIBRARIES ${BOOST_PRG_EXEC_MONITOR_LIBRARY})
    set(BOOST_PROGRAM_OPTIONS_LIBRARIES ${BOOST_PROGRAM_OPTIONS_LIBRARY})
    set(BOOST_RANDOM_LIBRARIES ${BOOST_RANDOM_LIBRARY})
    set(BOOST_REGEX_LIBRARIES ${BOOST_REGEX_LIBRARY})
    set(BOOST_SERIALIZATION_LIBRARIES ${BOOST_SERIALIZATION_LIBRARY})
    set(BOOST_SYSTEM_LIBRARIES ${BOOST_SYSTEM_LIBRARY})
    set(BOOST_TEST_EXEC_MONITOR_LIBRARIES ${BOOST_TEST_EXEC_MONITOR_LIBRARY})
    set(BOOST_THREAD_LIBRARIES ${BOOST_THREAD_LIBRARY})
    set(BOOST_TIMER_LIBRARIES ${BOOST_TIMER_LIBRARY})
    set(BOOST_TYPE_ERASURE_LIBRARIES ${BOOST_TYPE_ERASURE_LIBRARY})
    set(BOOST_UNIT_TEST_FRAMEWORK_LIBRARIES ${BOOST_UNIT_TEST_FRAMEWORK_LIBRARY})
    set(BOOST_WAVE_LIBRARIES ${BOOST_WAVE_LIBRARY})
    set(BOOST_WSERIALIZATION_LIBRARIES ${BOOST_WSERIALIZATION_LIBRARY})
    
    if(BOOST_HEADERS_FOUND AND NOT TARGET Boost::headers)
        add_library(Boost::headers INTERFACE IMPORTED)
        target_include_directories(Boost::headers INTERFACE "${BOOST_INCLUDE_DIR}")

        if(BOOST_BOOST_FOUND AND NOT TARGET Boost::boost)
            add_library(Boost::boost INTERFACE IMPORTED)
            target_link_libraries(Boost::boost INTERFACE Boost::headers)
        endif()
        
        if(NOT TARGET Boost::disable_autolinking)
            add_library(Boost::disable_autolinking INTERFACE IMPORTED)
            set_target_properties(Boost::disable_autolinking PROPERTIES
                INTERFACE_COMPILE_DEFINITIONS "BOOST_ALL_NO_LIB")
        endif()
    endif()

    if(BOOST_ATOMIC_FOUND AND NOT TARGET Boost::atomic)
        add_library(Boost::atomic UNKNOWN IMPORTED)
        
        set_target_properties(Boost::atomic PROPERTIES
            IMPORTED_LOCATION             "${BOOST_ATOMIC_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_CHRONO_FOUND AND NOT TARGET Boost::chrono)
        add_library(Boost::chrono UNKNOWN IMPORTED)
        
        set_target_properties(Boost::chrono PROPERTIES
            IMPORTED_LOCATION             "${BOOST_CHRONO_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_CONTAINER_FOUND AND NOT TARGET Boost::container)
        add_library(Boost::container UNKNOWN IMPORTED)
        
        set_target_properties(Boost::container PROPERTIES
            IMPORTED_LOCATION             "${BOOST_CONTAINER_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_CONTEXT_FOUND AND NOT TARGET Boost::context)
        add_library(Boost::context UNKNOWN IMPORTED)
        
        set_target_properties(Boost::context PROPERTIES
            IMPORTED_LOCATION             "${BOOST_CONTEXT_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_CONTRACT_FOUND AND NOT TARGET Boost::contract)
        add_library(Boost::contract UNKNOWN IMPORTED)
        
        set_target_properties(Boost::contract PROPERTIES
            IMPORTED_LOCATION             "${BOOST_CONTRACT_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_COROUTINE_FOUND AND NOT TARGET Boost::coroutine)
        add_library(Boost::coroutine UNKNOWN IMPORTED)
        
        set_target_properties(Boost::coroutine PROPERTIES
            IMPORTED_LOCATION             "${BOOST_COROUTINE_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_DATE_TIME_FOUND AND NOT TARGET Boost::date_time)
        add_library(Boost::date_time UNKNOWN IMPORTED)
        
        set_target_properties(Boost::date_time PROPERTIES
            IMPORTED_LOCATION             "${BOOST_DATE_TIME_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_EXCEPTION_FOUND AND NOT TARGET Boost::exception)
        add_library(Boost::exception UNKNOWN IMPORTED)
        
        set_target_properties(Boost::exception PROPERTIES
            IMPORTED_LOCATION             "${BOOST_EXCEPTION_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()

    if(BOOST_FIBER_FOUND AND NOT TARGET Boost::fiber)
        add_library(Boost::fiber UNKNOWN IMPORTED)

        set_target_properties(Boost::fiber PROPERTIES
            IMPORTED_LOCATION             "${BOOST_FIBER_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_FILESYSTEM_FOUND AND NOT TARGET Boost::filesystem)
        add_library(Boost::filesystem UNKNOWN IMPORTED)
        
        set_target_properties(Boost::filesystem PROPERTIES
            IMPORTED_LOCATION             "${BOOST_FILESYSTEM_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_GRAPH_FOUND AND NOT TARGET Boost::graph)
        add_library(Boost::graph UNKNOWN IMPORTED)
        
        set_target_properties(Boost::graph PROPERTIES
            IMPORTED_LOCATION             "${BOOST_GRAPH_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_IOSTREAMS_FOUND AND NOT TARGET Boost::iostreams)
        add_library(Boost::iostreams UNKNOWN IMPORTED)
        
        set_target_properties(Boost::iostreams PROPERTIES
            IMPORTED_LOCATION             "${BOOST_IOSTREAMS_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_JSON_FOUND AND NOT TARGET Boost::json)
        add_library(Boost::json UNKNOWN IMPORTED)
        
        set_target_properties(Boost::json PROPERTIES
            IMPORTED_LOCATION             "${BOOST_JSON_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_LOCALE_FOUND AND NOT TARGET Boost::locale)
        add_library(Boost::locale UNKNOWN IMPORTED)
        
        set_target_properties(Boost::locale PROPERTIES
            IMPORTED_LOCATION             "${BOOST_LOCALE_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_LOG_FOUND AND NOT TARGET Boost::log)
        add_library(Boost::log UNKNOWN IMPORTED)
        
        set_target_properties(Boost::log PROPERTIES
            IMPORTED_LOCATION             "${BOOST_LOG_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_LOG_SETUP_FOUND AND NOT TARGET Boost::log_setup)
        add_library(Boost::log_setup UNKNOWN IMPORTED)
        
        set_target_properties(Boost::log_setup PROPERTIES
            IMPORTED_LOCATION             "${BOOST_LOG_SETUP_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_NOWIDE_FOUND AND NOT TARGET Boost::nowide)
        add_library(Boost::nowide UNKNOWN IMPORTED)
        
        set_target_properties(Boost::nowide PROPERTIES
            IMPORTED_LOCATION             "${BOOST_NOWIDE_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_PRG_EXEC_MONITOR_FOUND AND NOT TARGET Boost::prg_exec_monitor)
        add_library(Boost::prg_exec_monitor UNKNOWN IMPORTED)
        
        set_target_properties(Boost::prg_exec_monitor PROPERTIES
            IMPORTED_LOCATION             "${BOOST_PRG_EXEC_MONITOR_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_PROGRAM_OPTIONS_FOUND AND NOT TARGET Boost::program_options)
        add_library(Boost::program_options UNKNOWN IMPORTED)
        
        set_target_properties(Boost::program_options PROPERTIES
            IMPORTED_LOCATION             "${BOOST_PROGRAM_OPTIONS_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_RANDOM_FOUND AND NOT TARGET Boost::random)
        add_library(Boost::random UNKNOWN IMPORTED)
        
        set_target_properties(Boost::random PROPERTIES
            IMPORTED_LOCATION             "${BOOST_RANDOM_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_REGEX_FOUND AND NOT TARGET Boost::regex)
        add_library(Boost::regex UNKNOWN IMPORTED)
        
        set_target_properties(Boost::regex PROPERTIES
            IMPORTED_LOCATION             "${BOOST_REGEX_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_SERIALIZATION_FOUND AND NOT TARGET Boost::serialization)
        add_library(Boost::serialization UNKNOWN IMPORTED)
        
        set_target_properties(Boost::serialization PROPERTIES
            IMPORTED_LOCATION             "${BOOST_SERIALIZATION_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_SYSTEM_FOUND AND NOT TARGET Boost::system)
        add_library(Boost::system UNKNOWN IMPORTED)
        
        set_target_properties(Boost::system PROPERTIES
            IMPORTED_LOCATION             "${BOOST_SYSTEM_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_TEST_EXEC_MONITOR_FOUND AND NOT TARGET Boost::test_exec_monitor)
        add_library(Boost::test_exec_monitor UNKNOWN IMPORTED)
        
        set_target_properties(Boost::test_exec_monitor PROPERTIES
            IMPORTED_LOCATION             "${BOOST_TEST_EXEC_MONITOR_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_THREAD_FOUND AND NOT TARGET Boost::thread)
        add_library(Boost::thread UNKNOWN IMPORTED)
        
        set_target_properties(Boost::thread PROPERTIES
            IMPORTED_LOCATION             "${BOOST_THREAD_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
        
        if(BOOST_CHRONO_FOUND)
            target_link_libraries(Boost::thread INTERFACE Boost::chrono)
        endif()
        
        if(THREADS_FOUND)
            target_link_libraries(Boost::thread INTERFACE Threads::Threads)
        endif()
    endif()
    
    if(BOOST_TIMER_FOUND AND NOT TARGET Boost::timer)
        add_library(Boost::timer UNKNOWN IMPORTED)
        
        set_target_properties(Boost::timer PROPERTIES
            IMPORTED_LOCATION             "${BOOST_TIMER_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_TYPE_ERASURE_FOUND AND NOT TARGET Boost::type_erasure)
        add_library(Boost::type_erasure UNKNOWN IMPORTED)
        
        set_target_properties(Boost::type_erasure PROPERTIES
            IMPORTED_LOCATION             "${BOOST_TYPE_ERASURE_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_UNIT_TEST_FRAMEWORK_FOUND AND NOT TARGET Boost::unit_test_framework)
        add_library(Boost::unit_test_framework UNKNOWN IMPORTED)
        
        set_target_properties(Boost::unit_test_framework PROPERTIES
            IMPORTED_LOCATION             "${BOOST_UNIT_TEST_FRAMEWORK_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_WAVE_FOUND AND NOT TARGET Boost::wave)
        add_library(Boost::wave UNKNOWN IMPORTED)
        
        set_target_properties(Boost::wave PROPERTIES
            IMPORTED_LOCATION             "${BOOST_WAVE_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    if(BOOST_WSERIALIZATION_FOUND AND NOT TARGET Boost::wserialization)
        add_library(Boost::wserialization UNKNOWN IMPORTED)
        
        set_target_properties(Boost::wserialization PROPERTIES
            IMPORTED_LOCATION             "${BOOST_WSERIALIZATION_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
    endif()
    
    
#    if(BOOST_XXXXXXXXXX_FOUND AND NOT TARGET Boost::xxxxxxxxxx)
#        add_library(Boost::xxxxxxxxxx UNKNOWN IMPORTED)
        
#        set_target_properties(Boost::xxxxxxxxxx PROPERTIES
#            IMPORTED_LOCATION             "${BOOST_XXXXXXXXXX_LIBRARY}"
#            INTERFACE_INCLUDE_DIRECTORIES "${BOOST_INCLUDE_DIR}")
#    endif()

endif()
