#!/bin/bash
#//////////////////////////////////////////////////////////////////////////////
# AG Development Framework.
# Copyright 2011-2020 GeorgeAth. All Rights Reserved.
#//////////////////////////////////////////////////////////////////////////////
# Project: AG-CI
# Updated: 21-01-2020
#//////////////////////////////////////////////////////////////////////////////
# Description: Run CI.
#//////////////////////////////////////////////////////////////////////////////

# Set the default target name.
if [ -z "${AG_TARGET_NAME}" ]; then export AG_TARGET_NAME="AG-DEV"; fi
# Set the default target file.
if [ -z "${AG_TARGET_FILE}" ]; then export AG_TARGET_FILE="./scripts/ag.sh"; fi
# Set the default arguments.
if [ -z "${AG_TARGET_ARGS}" ]; then export AG_TARGET_ARGS="--ci"; fi

# LOG: (current directory)>(run command) [arguments]
echo
echo "$PWD>$0 $*"
# Ensure required folders exist and if not exit this script with error.
if [ ! -d "../$AG_TARGET_NAME" ]; then { echo "ERROR: target not found."; exit 1; } fi
# Go to target-root.
echo "INFO: Change directory to target-root."
pushd "../$AG_TARGET_NAME" > /dev/null
echo "DIR : $PWD"
# Construct run command.
if [ -z "${AG_TARGET_ARGS}" ]; then {
	AG_RUN_CMD="$AG_TARGET_FILE";
} else {
	AG_RUN_CMD="$AG_TARGET_FILE $AG_TARGET_ARGS";
} fi
# Run the command.
echo "RUN : $AG_RUN_CMD"
$AG_RUN_CMD
ec=$?
echo
# Restore path.
echo "INFO: Restore path from target-root."
popd > /dev/null
echo "DIR : $PWD"
# Check for errors.
if [ $ec -ne 0 ]; then {
	echo "ERROR: An error occurred while attempting to run: $AG_TARGET_NAME/$AG_RUN_CMD";
} else {
	echo "INFO: Run $AG_TARGET_NAME/$AG_RUN_CMD complete.";
} fi

# Exit this script.
exit $ec
