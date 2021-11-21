#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Treat undefined variables as an error
set -o nounset

source "${FM_PATH_CORE_SCRIPTS_DIRECTORY}/utility.sh"
source "${FM_PATH_CORE_SCRIPTS_DIRECTORY}/functions.sh"

FM_AVAILABLE_BUILD_ACTIONS="build,install,buildInstall"


printHelp()
{
cat <<EOF

Usage: build.sh [OPTIONS]

 Option     Long option
 -h         --help                  Prints this help message and exits.
 -V         --verbose               Enables verbose mode.
 -a=value   --action=value          Action to perform. One of (${FM_AVAILABLE_BUILD_ACTIONS}).
 -l=value   --libset=value          Optional libset.
 -j=value   --jobs=value            Number of concurrent build processes to use. Default: value of \$FM_CONFIG_NUM_PROCESSES or 4 (${FM_CONFIG_NUM_PROCESSES:-4}).
 -t=value   --toolchain=value       Toolchain to use. Default: value of \$FM_TARGET_TOOLCHAIN (${FM_TARGET_TOOLCHAIN:-UNDEFINED}).
 -x=value   --architectures=value   Architectures to build. Default: all (${FM_TARGET_ALL_ARCHITECTURES:-UNDEFINED}).
 -v=value   --variants=value        Variants to build. Default: all (${FM_TARGET_ALL_BUILD_VARIANTS:-UNDEFINED}).
 -c=value   --tarball-cache=value   Cache folder for downloaded library source tarballs. Default: value of \$FM_CONFIG_TARBALL_CACHE (${FM_CONFIG_TARBALL_CACHE:-UNDEFINED}).
 -b=value   --build-root=value      Root folder for build files. Default: value of \$FM_CONFIG_BUILD_ROOT (${FM_CONFIG_BUILD_ROOT:-UNDEFINED}).
 -d=value   --deploy-root=value     Root folder for libraries deployment. Default: value of \$FM_CONFIG_DEPLOY_ROOT (${FM_CONFIG_DEPLOY_ROOT:-UNDEFINED}).

EOF
}

parseArguments()
{
    FM_ARG_VERBOSE=false
    FM_ARG_ACTION=""
    FM_ARG_LIBSET=""
    FM_ARG_NUM_PROCESSES="${FM_CONFIG_NUM_PROCESSES:-4}"
    FM_ARG_TOOLCHAIN="${FM_TARGET_TOOLCHAIN-}"
    FM_ARG_ARCHITECTURES="all"
    FM_ARG_BUILD_VARIANTS="all"
    FM_ARG_TARBALL_CACHE="${FM_CONFIG_TARBALL_CACHE-}"
    FM_ARG_BUILD_ROOT="${FM_CONFIG_BUILD_ROOT-}"
    FM_ARG_DEPLOY_ROOT="${FM_CONFIG_DEPLOY_ROOT-}"

    local LOCAL_ARGUMENT=""
    for LOCAL_ARGUMENT in "$@"
    do
        case ${LOCAL_ARGUMENT} in
            -h|--help)
                printHelp
                exit 0
            ;;
            -V|--verbose)
                FM_ARG_VERBOSE=true
            ;;
            -a=*|--action=*)
                FM_ARG_ACTION="$(echo ${LOCAL_ARGUMENT#*=} | tr '[:upper:]' '[:lower:]')"
            ;;
            -l=*|--libset=*)
                FM_ARG_LIBSET="$(echo ${LOCAL_ARGUMENT#*=} | tr '[:upper:]' '[:lower:]')"
            ;;
            -j=*|--jobs=*)
                FM_ARG_NUM_PROCESSES="${LOCAL_ARGUMENT#*=}"
            ;;
            -t=*|--toolchain=*)
                FM_ARG_TOOLCHAIN="$(echo ${LOCAL_ARGUMENT#*=} | tr '[:upper:]' '[:lower:]')"
            ;;
            -x=*|--architectures=*)
                FM_ARG_ARCHITECTURES="$(echo ${LOCAL_ARGUMENT#*=} | tr '[:upper:]' '[:lower:]' | tr "," " ")"
            ;;
            -v=*|--variants=*)
                FM_ARG_BUILD_VARIANTS="$(echo ${LOCAL_ARGUMENT#*=} | tr '[:upper:]' '[:lower:]' | tr "," " ")"
            ;;
            -c=*|--tarball-cache=*)
                FM_ARG_TARBALL_CACHE="${LOCAL_ARGUMENT#*=}"
            ;;
            -b=*|--build-root=*)
                FM_ARG_BUILD_ROOT="${LOCAL_ARGUMENT#*=}"
            ;;
            -d=*|--deploy-root=*)
                FM_ARG_DEPLOY_ROOT="${LOCAL_ARGUMENT#*=}"
            ;;
            *)
                echo "Unknown argument: '${LOCAL_ARGUMENT}'"
            ;;
        esac

        shift
    done


    local LOCAL_RETURN_VALUE=0

    # Action
    if [ -z "${FM_ARG_ACTION-}" ]; then
        LOCAL_RETURN_VALUE=1
        echo "ERROR: An action must be specified."
    else
        if ! isItemInArray "${FM_ARG_ACTION}" "$(echo "${FM_AVAILABLE_BUILD_ACTIONS}" | tr '[:upper:]' '[:lower:]' | tr "," " ")" ; then
            LOCAL_RETURN_VALUE=1
            echo "ERROR: Invalid action: ${FM_ARG_ACTION}"
        fi
    fi

    # Libset
    if [ -n "${FM_ARG_LIBSET-}" ]; then
        # Get the list of libraries
        FM_ARG_LIBSET_LIBS=""
        case ${FM_ARG_LIBSET} in
            *\/*)
                # Assume that the string is a list of libraries
                FM_ARG_LIBSET_LIBS="$(echo ${FM_ARG_LIBSET} | tr "," " ")"
            ;;
            *)
                # Assume that the string is the name of a libset file
                local LOCAL_LIBSET_FILE="${FM_PATH_SCRIPTS_ROOT_DIRECTORY}/libsets/${FM_ARG_LIBSET}.sh"
                if [ ! -f "${LOCAL_LIBSET_FILE}" ]; then
                    LOCAL_RETURN_VALUE=1
                    echo "ERROR: Invalid libset file name: ${FM_ARG_LIBSET}"
                else
                    source "${LOCAL_LIBSET_FILE}"
                    if [ $? -ne 0 ]; then
                        LOCAL_RETURN_VALUE=1
                        echo "ERROR: Error loading libset file: ${LOCAL_LIBSET_FILE}"
                    else
                        FM_ARG_LIBSET_LIBS="${FM_LIBSET_LIBS[@]}"
                    fi
                fi
            ;;
        esac

        # Load and check the configuration file for each library in the libset
        local LOCAL_LIBSET_LIB=""
        local LOCAL_JOINED_LIBSET_LIBS=""
        for LOCAL_LIBSET_LIB in ${FM_ARG_LIBSET_LIBS}
        do
            local LOCAL_LIBSET_LIB_NAME="${LOCAL_LIBSET_LIB%%/*}"
            local LOCAL_LIBSET_LIB_VERSION="${LOCAL_LIBSET_LIB#*/}"
            local LOCAL_LIBSET_LIB_CONFIG_FILE="${FM_PATH_SCRIPTS_ROOT_DIRECTORY}/libs/${LOCAL_LIBSET_LIB_NAME}/${LOCAL_LIBSET_LIB_NAME}-${LOCAL_LIBSET_LIB_VERSION}/config.sh"

            if [ ! -f "${LOCAL_LIBSET_LIB_CONFIG_FILE}" ]; then
                LOCAL_RETURN_VALUE=1
                echo "ERROR: Invalid library in libset: ${LOCAL_LIBSET_LIB}"
            else
                source "${LOCAL_LIBSET_LIB_CONFIG_FILE}"
                if [ $? -ne 0 ]; then
                    LOCAL_RETURN_VALUE=1
                    echo "ERROR: Error loading library configuration file: ${LOCAL_LIBSET_LIB_CONFIG_FILE}"
                else
                    if [ -z "${LOCAL_JOINED_LIBSET_LIBS-}" ]; then
                        LOCAL_JOINED_LIBSET_LIBS="${LOCAL_LIBSET_LIB_NAME}-${LOCAL_LIBSET_LIB_VERSION}"
                    else
                        LOCAL_JOINED_LIBSET_LIBS="${LOCAL_JOINED_LIBSET_LIBS}, ${LOCAL_LIBSET_LIB_NAME}-${LOCAL_LIBSET_LIB_VERSION}"
                    fi
                fi
            fi
        done
    fi

    # Number of build processes
    if [ -z "${FM_ARG_NUM_PROCESSES-}" ]; then
        LOCAL_RETURN_VALUE=1
        echo "ERROR: The number of build processes must be specified."
    else
        case ${FM_ARG_NUM_PROCESSES} in
            0|*[!0-9]*)
                LOCAL_RETURN_VALUE=1
                echo "ERROR: Invalid number of build processes: ${FM_ARG_NUM_PROCESSES}"
            ;;
        esac
    fi

    # Toolchain
    if [ -z "${FM_ARG_TOOLCHAIN-}" ]; then
        LOCAL_RETURN_VALUE=1
        echo "ERROR: A toolchain must be specified."
    else
        local LOCAL_TOOLCHAIN_INIT_SCRIPT="${FM_PATH_CORE_SCRIPTS_DIRECTORY}/toolchains/${FM_ARG_TOOLCHAIN}.sh"
        if [ ! -f "${LOCAL_TOOLCHAIN_INIT_SCRIPT}" ]; then
            LOCAL_RETURN_VALUE=1
            echo "ERROR: Invalid toolchain: ${FM_ARG_TOOLCHAIN}"
        else
            source ${LOCAL_TOOLCHAIN_INIT_SCRIPT}
        fi
    fi

    # Architectures
    if [ -z "${FM_ARG_ARCHITECTURES-}" ]; then
        LOCAL_RETURN_VALUE=1
        echo "ERROR: At least one architecture must be specified."
    else
        if [ "${FM_ARG_ARCHITECTURES}" = "all" ]; then
            FM_ARG_ARCHITECTURES="$(echo "${FM_TARGET_ALL_ARCHITECTURES}" | tr '[:upper:]' '[:lower:]' | tr "," " ")"
        fi

        local LOCAL_ARCHITECTURE=""
        local LOCAL_JOINED_ARCHITECTURES=""
        for LOCAL_ARCHITECTURE in ${FM_ARG_ARCHITECTURES}
        do
            if ! isItemInArray "${LOCAL_ARCHITECTURE}" "$(echo "${FM_TARGET_ALL_ARCHITECTURES}" | tr "," " ")" ; then
                LOCAL_RETURN_VALUE=1
                echo "ERROR: Invalid architecture: ${LOCAL_ARCHITECTURE}"
            else
                if [ -z "${LOCAL_JOINED_ARCHITECTURES-}" ]; then
                    LOCAL_JOINED_ARCHITECTURES="${LOCAL_ARCHITECTURE}"
                else
                    LOCAL_JOINED_ARCHITECTURES="${LOCAL_JOINED_ARCHITECTURES}, ${LOCAL_ARCHITECTURE}"
                fi
            fi
        done
    fi

    # Build variants
    if [ -z "${FM_ARG_BUILD_VARIANTS-}" ]; then
        LOCAL_RETURN_VALUE=1
        echo "ERROR: At least one build variant must be specified."
    else
        if [ "${FM_ARG_BUILD_VARIANTS}" = "all" ]; then
            FM_ARG_BUILD_VARIANTS="$(echo "${FM_TARGET_ALL_BUILD_VARIANTS}" | tr '[:upper:]' '[:lower:]' | tr "," " ")"
        fi

        local LOCAL_BUILD_VARIANT=""
        local LOCAL_JOINED_BUILD_VARIANTS=""
        for LOCAL_BUILD_VARIANT in ${FM_ARG_BUILD_VARIANTS}
        do
            if ! isItemInArray "${LOCAL_BUILD_VARIANT}" "$(echo "${FM_TARGET_ALL_BUILD_VARIANTS}" | tr "," " ")" ; then
                LOCAL_RETURN_VALUE=1
                echo "ERROR: Invalid build variant: ${LOCAL_BUILD_VARIANT}"
            else
                if [ -z "${LOCAL_JOINED_BUILD_VARIANTS-}" ]; then
                    LOCAL_JOINED_BUILD_VARIANTS="${LOCAL_BUILD_VARIANT}"
                else
                    LOCAL_JOINED_BUILD_VARIANTS="${LOCAL_JOINED_BUILD_VARIANTS}, ${LOCAL_BUILD_VARIANT}"
                fi
            fi
        done
    fi

    # Tarball cache
    if [ -z "${FM_ARG_TARBALL_CACHE-}" ]; then
        LOCAL_RETURN_VALUE=1
        echo "ERROR: The cache folder for downloaded library source tarballs must be specified."
    else
        if ! mkdir -p "${FM_ARG_TARBALL_CACHE}"; then
            LOCAL_RETURN_VALUE=1
            echo "ERROR: Cannot create the cache folder for downloaded library source tarballs: ${FM_ARG_TARBALL_CACHE}"
        fi
    fi

    # Build root
    if [ -z "${FM_ARG_BUILD_ROOT-}" ]; then
        LOCAL_RETURN_VALUE=1
        echo "ERROR: The root folder for the builds must be specified."
    else
        if ! mkdir -p "${FM_ARG_BUILD_ROOT}"; then
            LOCAL_RETURN_VALUE=1
            echo "ERROR: Cannot create the root folder for the builds: ${FM_ARG_BUILD_ROOT}"
        fi
    fi

    # Deploy root
    if [ -z "${FM_ARG_DEPLOY_ROOT-}" ]; then
        LOCAL_RETURN_VALUE=1
        echo "ERROR: The root folder for libraries deployment must be specified."
    else
        if ! mkdir -p "${FM_ARG_DEPLOY_ROOT}"; then
            LOCAL_RETURN_VALUE=1
            echo "ERROR: Cannot create the root folder for libraries deployment: ${FM_ARG_DEPLOY_ROOT}"
        fi
    fi


    if [ ${FM_ARG_VERBOSE} = true ] && [ $LOCAL_RETURN_VALUE = 0 ]; then
        echo "Verbose mode:     ${FM_ARG_VERBOSE}"
        echo "Action:           ${FM_ARG_ACTION}"
        echo "Libset argument:  ${FM_ARG_LIBSET}"
        echo "Libset libs:      ${LOCAL_JOINED_LIBSET_LIBS-}"
        echo "Build jobs:       ${FM_ARG_NUM_PROCESSES}"
        echo "Toolchain:        ${FM_ARG_TOOLCHAIN}"
        echo "Architectures:    ${LOCAL_JOINED_ARCHITECTURES}"
        echo "Build variants:   ${LOCAL_JOINED_BUILD_VARIANTS}"
        echo "Tarball cache:    ${FM_ARG_TARBALL_CACHE}"
        echo "Build root:       ${FM_ARG_BUILD_ROOT}"
        echo "Deploy root:      ${FM_ARG_DEPLOY_ROOT}"
    fi

    return $LOCAL_RETURN_VALUE
}


if ! parseArguments "$@"; then
    printHelp
    exit 1
fi
