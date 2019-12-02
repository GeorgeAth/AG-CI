#!/bin/bash
#//////////////////////////////////////////////////////////////////////////////
# AG Development Framework.
# Copyright 2011-2020 GeorgeAth. All Rights Reserved.
#//////////////////////////////////////////////////////////////////////////////

#//////////////////////////////////////////////////////////////////////////////

#//////////////////////////////////////////////////////////////////////////////
# Enviroment Variables
AG_BUILD_TYPE="Release"
AG_DIR_OUT="build"
AG_DIR_SRC="AG-DEV"
AG_DIR_DEP="AG-LIB"
#//////////////////////////////////////////////////////////////////////////////

#//////////////////////////////////////////////////////////////////////////////
# Print current script.
echo "file : $0"
# Print current directory (module).
echo "home : $PWD"
#//////////////////////////////////////////////////////////////////////////////
# Change directory to root.
cd ../
echo "root : $PWD"
# Ensure required folders exist.
if [ ! -d "$AG_DIR_SRC" ]; then ( echo "src not found." && exit 1 ) fi
if [ ! -d "$AG_DIR_DEP" ]; then ( echo "dep not found." && exit 1 ) fi
#//////////////////////////////////////////////////////////////////////////////
# Ensure output directory does not exist.
if [ -d "$AG_DIR_OUT" ]; then ( echo "out $AG_DIR_OUT exist." && exit 1 ) fi
# Create output directory.
mkdir -p -- "$AG_DIR_OUT"
# Change directory to (build) output.
cd $AG_DIR_OUT
echo "Current directory (output) : $PWD"
#//////////////////////////////////////////////////////////////////////////////


#//////////////////////////////////////////////////////////////////////////////
# Android SDK
#------------------------------------------------------------------------------
# Ensure android sdk is installed.
if [[ ! -d ${ANDROID_HOME} ]]; then
	echo "Andorid SDK not found."
	exit 1
fi
echo "Andorid SDK found at '${ANDROID_HOME}"
cd ${ANDROID_HOME}
dir
#------------------------------------------------------------------------------
# NDK
#------------------------------------------------------------------------------
# Set the Android NDK path.
AG_DIR_NDK="${ANDROID_HOME}/ndk-bundel"
#------------------------------------------------------------------------------
# Ensure android sdk is installed.
if [[ ! -d $AG_DIR_NDK ]]; then
	echo "Andorid NDK not found."
	exit 1
fi
# Print NDK version.
# Expected NDK version: 20.0.5594570
echo "Andorid NDK found. (version: ${ANDROID_NDK_VERSION})"
exit 0
#//////////////////////////////////////////////////////////////////////////////


#//////////////////////////////////////////////////////////////////////////////
# Build the cmake create command.
AG_CMD_CREATE="cmake ../$AG_DIR_SRC"
#------------------------------------------------------------------------------
# Build the cmake build command.
AG_CMD_BUILD="cmake --build . --config $AG_BUILD_TYPE"
#------------------------------------------------------------------------------
# Build the cmake test command.
AG_CMD_TEST="ctest -C $AG_BUILD_TYPE"
#//////////////////////////////////////////////////////////////////////////////

#//////////////////////////////////////////////////////////////////////////////
# Print the cmake create command.
echo "cmake create command : $AG_CMD_CREATE"
echo "cmake build command : $AG_CMD_BUILD"
echo "cmake test command : $AG_CMD_TEST"
#//////////////////////////////////////////////////////////////////////////////

# Ensure cmake is installed.
#cmake --version

#//////////////////////////////////////////////////////////////////////////////
# Run the cmake create command.
$AG_CMD_CREATE
# Run the cmake build command.
$AG_CMD_BUILD
# Run the cmake test command.
$AG_CMD_TEST
#//////////////////////////////////////////////////////////////////////////////


#//////////////////////////////////////////////////////////////////////////////
#:EXIT_SCRIPT
# Exit this batch script with error level equal to 0.
exit 0
#//////////////////////////////////////////////////////////////////////////////
#:ABORT_OPERATION
#echo Operation aborted.
# Exit this batch script with error level equal to 1.
#exit 1
#//////////////////////////////////////////////////////////////////////////////