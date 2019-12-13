#!/bin/bash
#//////////////////////////////////////////////////////////////////////////////
# AG Development Framework.
# Copyright 2011-2020 GeorgeAth. All Rights Reserved.
#//////////////////////////////////////////////////////////////////////////////


#//////////////////////////////////////////////////////////////////////////////
# Enviroment Variables
AG_BUILD_TYPE="Release"
AG_DIR_OUT="build"
AG_DIR_SRC="AG-DEV"
AG_DIR_DEP="AG-LIB"
#------------------------------------------------------------------------------

#//////////////////////////////////////////////////////////////////////////////
# Print current script.
echo "file : $0"
# Print the current directory. (expected: <project-root>)
echo "project : $PWD"
# Change directory to the <eviroment-root>.
cd ..
# Print the current directory. (expected: <enviroment-root>)
echo "env-root : $PWD"
#------------------------------------------------------------------------------
# Ensure required folders exist and if not exit this script with error 1.
if [ ! -d "$AG_DIR_SRC" ]; then ( echo "ERROR: src not found." && exit 1 ) fi
if [ ! -d "$AG_DIR_DEP" ]; then ( echo "ERROR: dep not found." && exit 1 ) fi
#------------------------------------------------------------------------------
# Ensure output directory does not exist.
if [ -d "$AG_DIR_OUT" ]; then ( echo "ERROR: out $AG_DIR_OUT exist." && exit 1 ) fi
# Create output directory.
mkdir -p -- "$AG_DIR_OUT"
# Change directory to output.
cd $AG_DIR_OUT
echo "Current directory (build) : $PWD"
#------------------------------------------------------------------------------


#//////////////////////////////////////////////////////////////////////////////
# Ensure cmake is available on the current build environment.
# todo...
#------------------------------------------------------------------------------
# Ensure ctest is available on the current build environment.
# todo...
#------------------------------------------------------------------------------


#//////////////////////////////////////////////////////////////////////////////
# Android SDK
#------------------------------------------------------------------------------
# Ensure android sdk is installed.
if [[ ! -d ${ANDROID_HOME} ]]; then
	echo "Andorid SDK not found."
	exit 1
fi
echo "Andorid SDK found at '${ANDROID_HOME}"
#------------------------------------------------------------------------------
# NDK
#------------------------------------------------------------------------------
# Ensure android sdk is installed.
if [[ -d "${ANDROID_HOME}/ndk" ]];
then
	# Set the Android NDK path.
	AG_DIR_NDK="${ANDROID_HOME}/ndk"
	echo "Andorid NDK (Side by side) found at '$AG_DIR_NDK', version '${ANDROID_NDK_VERSION}'"
elif [[ -d "${ANDROID_HOME}/ndk-bundle" ]];
then
	# Set the Android NDK path.
	AG_DIR_NDK="${ANDROID_HOME}/ndk-bundle"
	echo "Andorid legacy NDK found at '$AG_DIR_NDK', version '${ANDROID_NDK_VERSION}'"
else
	echo "Andorid NDK not found."
	exit 1
fi
#------------------------------------------------------------------------------
#set AG_TEMP_DIR="$PWD"
#cd ${AG_DIR_NDK}
#echo "$PWD"
#dir
#cd ./build
#echo "$PWD"
#dir
#cd ./cmake
#echo "$PWD"
#dir
#cd ${AG_TEMP_DIR}
#echo "$PWD"
#exit 1
#------------------------------------------------------------------------------


#//////////////////////////////////////////////////////////////////////////////
# Build command: create.
AG_CMD_CREATE="cmake \
../$AG_DIR_SRC \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_TOOLCHAIN_FILE=$AG_DIR_NDK/build/cmake/android.toolchain.cmake \
-DANDROID_TOOLCHAIN=clang \
-DANDROID_PLATFORM=android-21 \
-DANDROID_ABI=arm64-v8a \
-DANDROID_STL=c++_shared \
-DCMAKE_INSTALL_PREFIX=$AG_DIR_OUT/install/android/arm64-v8a
"
#------------------------------------------------------------------------------
# Build command: build.
AG_CMD_BUILD="cmake --build . --config $AG_BUILD_TYPE"
#------------------------------------------------------------------------------
# Build command: test.
AG_CMD_TEST="ctest -C $AG_BUILD_TYPE"
#------------------------------------------------------------------------------
# Print commands.
echo "cmake create command : $AG_CMD_CREATE"
echo "cmake build command : $AG_CMD_BUILD"
echo "cmake test command : $AG_CMD_TEST"
#------------------------------------------------------------------------------


#//////////////////////////////////////////////////////////////////////////////
# Run command: create.
$AG_CMD_CREATE
#------------------------------------------------------------------------------
# Run command: build.
$AG_CMD_BUILD
#------------------------------------------------------------------------------
# Run command: test.
$AG_CMD_TEST
#------------------------------------------------------------------------------


#//////////////////////////////////////////////////////////////////////////////
# Exit this script.
exit 0
#------------------------------------------------------------------------------
