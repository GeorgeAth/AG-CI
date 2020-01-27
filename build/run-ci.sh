#!/bin/bash
#//////////////////////////////////////////////////////////////////////////////
# AG Development Framework.
# Copyright 2011-2020 GeorgeAth. All Rights Reserved.
#//////////////////////////////////////////////////////////////////////////////
# Project: AG-CI [master]
# Updated: 27-01-2020
#//////////////////////////////////////////////////////////////////////////////
# Description: Run CI/CD.
#//////////////////////////////////////////////////////////////////////////////

# Set the default target environment.
if [ -z "${AG_CI_ENV}" ]; then { export AG_CI_ENV=".."; } fi
# Set the default target project.
if [ -z "${AG_CI_PROJECT}" ]; then { export AG_CI_PROJECT="AG-DEV"; } fi
# Set the default target file.
if [ -z "${AG_CI_FILE}" ]; then { export AG_CI_FILE="./scripts/ag.sh"; } fi
# Set the default arguments.
if [ -z "${AG_CI_ARGS}" ]; then { export AG_CI_ARGS="--ci"; } fi

# LOG: (current directory)>(run command) [arguments]
echo
echo "$PWD>$0 $*"
# Ensure required folders exist and if not exit this script with error.
if [ ! -d "$AG_CI_ENV/$AG_CI_PROJECT" ]; then { echo "ERROR: target not found."; exit 1; } fi
# Go to target-root.
echo "INFO: Change directory to target-root."
pushd "$AG_CI_ENV/$AG_CI_PROJECT" > /dev/null
echo "DIR : $PWD"
# Construct run command.
if [ -z "${AG_CI_ARGS}" ]; then {
	AG_RUN_CMD="$AG_CI_FILE";
} else {
	AG_RUN_CMD="$AG_CI_FILE $AG_CI_ARGS";
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
	echo "ERROR: An error occurred while attempting to run: $AG_CI_PROJECT/$AG_RUN_CMD";
} else {
	echo "INFO: Run $AG_CI_PROJECT/$AG_RUN_CMD complete.";
} fi

# Exit this script.
exit $ec
