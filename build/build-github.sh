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
# Build command: create.
AG_CMD_CREATE="cmake ../$AG_DIR_SRC"
#------------------------------------------------------------------------------
# Build command: build.
AG_CMD_BUILD="cmake --build . --config $AG_BUILD_TYPE"
#------------------------------------------------------------------------------
# Build command: test.
AG_CMD_TEST="ctest -C $AG_BUILD_TYPE"
#------------------------------------------------------------------------------
# Print commands.
echo "command create: $AG_CMD_CREATE"
echo "command build: $AG_CMD_BUILD"
echo "command test: $AG_CMD_TEST"
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
