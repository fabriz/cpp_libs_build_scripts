#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

helpListLibsets()
{
    pushd "${FM_PATH_SCRIPTS_ROOT_DIRECTORY}/libsets"
    local LOCAL_AVAILABLE_LIBSETS=(*.sh)
    popd

    if [ $# = 1 ]; then
        local LOCAL_INDENT=""
    else
        local LOCAL_INDENT="    "
        echo "Available libsets are: "
    fi

    for LOCAL_AVAILABLE_LIBSET in "${LOCAL_AVAILABLE_LIBSETS[@]}"
    do
        echo "${LOCAL_INDENT}${LOCAL_AVAILABLE_LIBSET%.*}"
    done
}

helpListLibs()
{
    pushd "${FM_PATH_SCRIPTS_ROOT_DIRECTORY}/libs"
    local LOCAL_AVAILABLE_LIBS=(*)
    popd

    if [ $# = 1 ]; then
        local LOCAL_INDENT=""
    else
        local LOCAL_INDENT="    "
        echo "Available libraries are: "
    fi

    for LOCAL_AVAILABLE_LIB in "${LOCAL_AVAILABLE_LIBS[@]}"
    do
        local LOCAL_LIB_ROOT_PATH="${FM_PATH_SCRIPTS_ROOT_DIRECTORY}/libs/${LOCAL_AVAILABLE_LIB}"
        if [ -d "${LOCAL_LIB_ROOT_PATH}" ] ; then
            pushd "${LOCAL_LIB_ROOT_PATH}"
            local LOCAL_AVAILABLE_LIB_VERSIONS=(*)
            popd

            for LOCAL_AVAILABLE_LIB_VERSION in "${LOCAL_AVAILABLE_LIB_VERSIONS[@]}"
            do
                echo "${LOCAL_INDENT}${LOCAL_AVAILABLE_LIB_VERSION}"
            done
        fi
    done
}

helpListToolchains()
{
    pushd "${FM_PATH_CORE_SCRIPTS_DIRECTORY}/toolchains"
    local LOCAL_AVAILABLE_TOOLCHAINS=(*.sh)
    popd

    if [ $# = 1 ]; then
        local LOCAL_INDENT=""
    else
        local LOCAL_INDENT="    "
        echo "Available toolchains are: "
    fi

    for LOCAL_AVAILABLE_TOOLCHAIN in "${LOCAL_AVAILABLE_TOOLCHAINS[@]}"
    do
        echo "${LOCAL_INDENT}${LOCAL_AVAILABLE_TOOLCHAIN%.*}"
    done
}

helpListArchitectures()
{
    local LOCAL_AVAILABLE_ARCHITECTURES=${FM_TARGET_ALL_ARCHITECTURES//,/ }

    if [ $# = 1 ]; then
        local LOCAL_INDENT=""
    else
        local LOCAL_INDENT="    "
        echo "Available architectures are: "
    fi

    for LOCAL_AVAILABLE_ARCHITECTURE in ${LOCAL_AVAILABLE_ARCHITECTURES}
    do
        echo "${LOCAL_INDENT}${LOCAL_AVAILABLE_ARCHITECTURE}"
    done
}

helpListBuildVariants()
{
    local LOCAL_AVAILABLE_BUILD_VARIANTS=${FM_TARGET_ALL_BUILD_VARIANTS//,/ }

    if [ $# = 1 ]; then
        local LOCAL_INDENT=""
    else
        local LOCAL_INDENT="    "
        echo "Available build variants are: "
    fi

    for LOCAL_AVAILABLE_BUILD_VARIANT in ${LOCAL_AVAILABLE_BUILD_VARIANTS}
    do
        echo "${LOCAL_INDENT}${LOCAL_AVAILABLE_BUILD_VARIANT}"
    done
}
