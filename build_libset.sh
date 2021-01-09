#!/bin/bash

# Treat undefined variables as an error
set -o nounset

BUILD_LIBSET_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${BUILD_LIBSET_SCRIPT_DIRECTORY}/core/utility.sh"
source "${BUILD_LIBSET_SCRIPT_DIRECTORY}/core/help.sh"


BLOCK_SEPARATOR="------------------------------------------------------------"


printHelp()
{
cat <<EOF

Usage: build_libset.sh [OPTIONS]

 Option     Long option
 -h         --help                  Prints this help message and exits.
            --list                  Lists available libraries and exits.
 -l=value   --libset=value          Libset. Default: latest
 -x=value   --architectures=value   Architectures to build. Default: all (${FM_TARGET_ALL_ARCHITECTURES:-UNDEFINED}).
 -v=value   --variants=value        Variants to build. Default: all (${FM_TARGET_ALL_BUILD_VARIANTS:-UNDEFINED}).

EOF
}

parseArguments()
{
    FM_ARG_LIBSET="latest"
    FM_ARG_ARCHITECTURES="all"
    FM_ARG_BUILD_VARIANTS="all"

    local LOCAL_ARGUMENT=""
    for LOCAL_ARGUMENT in "$@"
    do
        case ${LOCAL_ARGUMENT} in
            -h|--help)
                printHelp
                exit 0
            ;;
            --list)
                helpListLibsets silent
                exit 0
            ;;
            -l=*|--libset=*)
                FM_ARG_LIBSET="$(echo ${LOCAL_ARGUMENT#*=} | tr '[:upper:]' '[:lower:]')"
            ;;
            -x=*|--architectures=*)
                FM_ARG_ARCHITECTURES="$(echo ${LOCAL_ARGUMENT#*=} | tr '[:upper:]' '[:lower:]' | tr "," " ")"
            ;;
            -v=*|--variants=*)
                FM_ARG_BUILD_VARIANTS="$(echo ${LOCAL_ARGUMENT#*=} | tr '[:upper:]' '[:lower:]' | tr "," " ")"
            ;;
            *)
                echo "Unknown argument: '${LOCAL_ARGUMENT}'"
            ;;
        esac

        shift
    done


    local LOCAL_RETURN_VALUE=0

    # Libset
    if [ -z "${FM_ARG_LIBSET-}" ]; then
        LOCAL_RETURN_VALUE=1
        echo "ERROR: A libset must be specified."
    else
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
                printf "Loading libset ${FM_ARG_LIBSET} ... "
                if [ ! -f "${LOCAL_LIBSET_FILE}" ]; then
                    LOCAL_RETURN_VALUE=1
                    echo "ERROR: File '${LOCAL_LIBSET_FILE}' not found."
                else
                    source "${LOCAL_LIBSET_FILE}"
                    if [ $? -ne 0 ]; then
                        LOCAL_RETURN_VALUE=1
                        echo "ERROR: Error loading libset file '${LOCAL_LIBSET_FILE}'"
                    else
                        FM_ARG_LIBSET_LIBS="${FM_LIBSET_LIBS[@]}"
                        echo "OK"
                    fi
                fi
            ;;
        esac

        # Load and check the configuration file for each library in the libset
        local LOCAL_LIBSET_LIB=""
        for LOCAL_LIBSET_LIB in ${FM_ARG_LIBSET_LIBS}
        do
            local LOCAL_LIBSET_LIB_NAME="${LOCAL_LIBSET_LIB%%/*}"
            local LOCAL_LIBSET_LIB_VERSION="${LOCAL_LIBSET_LIB#*/}"
            local LOCAL_LIBSET_LIB_CONFIG_FILE="${FM_PATH_SCRIPTS_ROOT_DIRECTORY}/libs/${LOCAL_LIBSET_LIB_NAME}/${LOCAL_LIBSET_LIB_NAME}-${LOCAL_LIBSET_LIB_VERSION}/config.sh"

            printf "Checking ${LOCAL_LIBSET_LIB} ... "

            if [ ! -f "${LOCAL_LIBSET_LIB_CONFIG_FILE}" ]; then
                LOCAL_RETURN_VALUE=1
                echo "ERROR: File '${LOCAL_LIBSET_LIB_CONFIG_FILE}' not found."
            else
                source "${LOCAL_LIBSET_LIB_CONFIG_FILE}"
                if [ $? -ne 0 ]; then
                    LOCAL_RETURN_VALUE=1
                    echo "ERROR: Error loading library configuration file: ${LOCAL_LIBSET_LIB_CONFIG_FILE}"
                else
                    echo "OK"
                fi
            fi
        done
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
        for LOCAL_ARCHITECTURE in ${FM_ARG_ARCHITECTURES}
        do
            if ! isItemInArray "${LOCAL_ARCHITECTURE}" "$(echo "${FM_TARGET_ALL_ARCHITECTURES}" | tr "," " ")" ; then
                LOCAL_RETURN_VALUE=1
                echo "ERROR: Invalid architecture: ${LOCAL_ARCHITECTURE}"
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
        for LOCAL_BUILD_VARIANT in ${FM_ARG_BUILD_VARIANTS}
        do
            if ! isItemInArray "${LOCAL_BUILD_VARIANT}" "$(echo "${FM_TARGET_ALL_BUILD_VARIANTS}" | tr "," " ")" ; then
                LOCAL_RETURN_VALUE=1
                echo "ERROR: Invalid build variant: ${LOCAL_BUILD_VARIANT}"
            fi
        done
    fi

    return $LOCAL_RETURN_VALUE
}

buildLibraries()
{
    local LOCAL_LIBSET_LIB=""
    for LOCAL_LIBSET_LIB in ${FM_ARG_LIBSET_LIBS}
    do
        echo ${BLOCK_SEPARATOR}

        local LOCAL_LIBSET_LIB_NAME="${LOCAL_LIBSET_LIB%%/*}"
        local LOCAL_LIBSET_LIB_VERSION="${LOCAL_LIBSET_LIB#*/}"
        local LOCAL_LIBSET_LIB_BUILD_SCRIPT="${FM_PATH_SCRIPTS_ROOT_DIRECTORY}/libs/${LOCAL_LIBSET_LIB_NAME}/${LOCAL_LIBSET_LIB_NAME}-${LOCAL_LIBSET_LIB_VERSION}/build.sh"

        ${LOCAL_LIBSET_LIB_BUILD_SCRIPT} --action=buildInstall --architectures="${FM_ARG_ARCHITECTURES}" --variants="${FM_ARG_BUILD_VARIANTS}"
        if [ $? -ne 0 ]; then
            error "Build failed"
        fi
    done

    echo ${BLOCK_SEPARATOR}
    echo "OK: All libraries built successfully"
    echo
}


if ! parseArguments "$@"; then
    printHelp
    exit 1
fi

buildLibraries

success
