#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

export FM_PATH_ENVIRONMENT_INIT_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "${FM_PATH_ENVIRONMENT_INIT_SCRIPT_DIRECTORY}/../.."

export FM_PATH_SCRIPTS_ROOT_DIRECTORY="$(pwd)"
export FM_PATH_CORE_SCRIPTS_DIRECTORY="${FM_PATH_SCRIPTS_ROOT_DIRECTORY}/core"

export FM_CONFIG_CMAKE_COMMAND="$(cygpath -u "${FM_CONFIG_CMAKE_COMMAND}")"
export FM_CONFIG_CURL_COMMAND="$(cygpath -u "${FM_CONFIG_CURL_COMMAND}")"
export FM_CONFIG_PERL_COMMAND="$(cygpath -u "${FM_CONFIG_PERL_COMMAND}")"
export FM_CONFIG_PERL_WINDOWS_COMMAND="$(cygpath -u "${FM_CONFIG_PERL_WINDOWS_COMMAND}")"
export FM_CONFIG_PYTHON_COMMAND="$(cygpath -u "${FM_CONFIG_PYTHON_COMMAND}")"
export FM_CONFIG_PYTHON_WINDOWS_COMMAND="$(cygpath -u "${FM_CONFIG_PYTHON_WINDOWS_COMMAND}")"
export FM_CONFIG_PYTHON_WINDOWS_INSTALLATION_PATH="${FM_CONFIG_PYTHON_WINDOWS_COMMAND%/*}/"
export FM_CONFIG_TAR_COMMAND="$(cygpath -u "${FM_CONFIG_TAR_COMMAND}")"
export FM_CONFIG_UNZIP_COMMAND="$(cygpath -u "${FM_CONFIG_UNZIP_COMMAND}")"
export FM_CONFIG_PATCH_COMMAND="$(cygpath -u "${FM_CONFIG_PATCH_COMMAND}")"

initHostVariables()
{
    # Identify the operating system of the build host
    export FM_HOST_OS_TYPE="windows"

    # Identify the architecture and the address model of the build host
    local LOCAL_SYSTEM_ARCHITECTURE="$(uname -m | tr '[:upper:]' '[:lower:]')"
    case ${LOCAL_SYSTEM_ARCHITECTURE} in
        x86|i386|i686)
            export FM_HOST_ARCHITECTURE="x86"
            export FM_HOST_ADDRESS_MODEL="32"
        ;;
        x86_64|amd64)
            export FM_HOST_ARCHITECTURE="x86_64"
            export FM_HOST_ADDRESS_MODEL="64"
        ;;
        *)
            echo "ERROR: Unsupported architecture type reported by 'uname -m': '${LOCAL_SYSTEM_ARCHITECTURE}'"
            exit 1
        ;;
    esac
}

printInstructions()
{
cat <<EOF

Shell scripts to build some common open source C/C++ libraries.

**** IMPORTANT WARNING: ****
Refer to the licenses of the respective libraries for conditions on their use and distribution.

To build the latest version of all libraries with all architectures and variants:
  ./build_libset.sh
which is equivalent to:
  ./build_libset.sh --libset=latest --architectures=${FM_TARGET_ALL_ARCHITECTURES} --variants=${FM_TARGET_ALL_BUILD_VARIANTS}

To build a single library with all architectures and variants:
  ./build_lib.sh LIBNAME/LIBVERSION
which is equivalent to:
  ./build_lib.sh LIBNAME/LIBVERSION --architectures=${FM_TARGET_ALL_ARCHITECTURES} --variants=${FM_TARGET_ALL_BUILD_VARIANTS}

EOF
}

initHostVariables
printInstructions
