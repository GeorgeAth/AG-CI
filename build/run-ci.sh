#!/bin/bash
#//////////////////////////////////////////////////////////////////////////////
# AG Development Framework.
# Copyright 2011-2020 GeorgeAth. All Rights Reserved.
#//////////////////////////////////////////////////////////////////////////////

# Set the default target name.
if [ -z "$AG_TARGET_NAME" ]; then ( AG_TARGET_NAME="AG-DEV" ) fi
# Set the default target file.
if [ -z "$AG_TARGET_FILE" ]; then ( AG_TARGET_FILE="./build/run-ci.sh" ) fi

# LOG: script name.
echo "script   : $0"
# LOG: project-root.
echo "project  : $PWD"
# Go to parent directory.
cd ..
# LOG: enviroment-root.
echo "env-root : $PWD"
# Ensure required folders exist and if not exit this script with error 1.
if [ ! -d "$AG_TARGET_NAME" ]; then ( echo "ERROR: target not found." && exit 1 ) fi
# Go to target-root.
cd $AG_TARGET_NAME
# Run the target.
sh $AG_TARGET_FILE

# Exit this script.
exit 0
