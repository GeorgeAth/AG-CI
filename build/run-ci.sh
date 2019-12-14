#!/bin/bash
#//////////////////////////////////////////////////////////////////////////////
# AG Development Framework.
# Copyright 2011-2020 GeorgeAth. All Rights Reserved.
#//////////////////////////////////////////////////////////////////////////////
# AG-CI : Run.
#//////////////////////////////////////////////////////////////////////////////

# Set the default target name.
if [ -z "${AG_TARGET_NAME}" ]; then export AG_TARGET_NAME="AG-DEV"; fi
# Set the default target file.
if [ -z "${AG_TARGET_FILE}" ]; then export AG_TARGET_FILE="./build/build-script.sh"; fi
# Set the default arguments.
if [ -z "${AG_TARGET_ARGS}" ]; then export AG_TARGET_ARGS=" -ci"; fi

# LOG: (current directory) > (run command) [arguments]
echo
echo "$PWD>$0 $*"
# Ensure required folders exist and if not exit this script with error 1.
if [ ! -d "../$AG_TARGET_NAME" ]; then { echo "ERROR: target not found."; exit 1; } fi
# Go to target-root.
echo "INFO: Change directory to target-root."
pushd ..
pushd $AG_TARGET_NAME
echo "DIR : $PWD"
# Run the target.
AG_RUN_CMD="$AG_TARGET_FILE$AG_TARGET_ARGS"
sh $AG_RUN_CMD
echo
# Restore path.
echo "INFO: Retore path."
popd
popd
echo "DIR : $PWD"
# Check for errors.
if [ $? -ne 0 ]; then {
	echo "ERROR: An error occurred while attempting to run: $AG_TARGET_NAME/$AG_RUN_CMD";
} else {
	echo "INFO: Run $AG_TARGET_NAME/$AG_RUN_CMD complete.";
} fi

# Exit this script.
exit $?;
