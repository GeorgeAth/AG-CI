:://///////////////////////////////////////////////////////////////////////////
:: AG Development Framework.
:: Copyright 2011-2020 GeorgeAth. All Rights Reserved.
:://///////////////////////////////////////////////////////////////////////////
:: AG-CI : Run.
:://///////////////////////////////////////////////////////////////////////////
@echo off

:: Set the default target name.
if "%AG_TARGET_NAME%"=="" ( SET "AG_TARGET_NAME=AG-DEV" )
:: Set the default target file.
if "%AG_TARGET_FILE%"=="" ( SET "AG_TARGET_FILE=.\build\run-ci.bat" )

:: LOG: script name.
echo script  : %0
:: LOG: project-root.
echo project : %CD%
:: Go to parent directory.
cd ..
:: LOG: enviroment-root.
echo root    : %CD%
:: Ensure required folder exist and if not exit this script with error 1.
if not exist %AG_TARGET_NAME% ( echo ERROR: target not found. && exit /b 1 )
:: Go to target-root.
cd %AG_TARGET_NAME%
:: Run the target.
CALL %AG_TARGET_FILE%

:: Exit this script.
exit /b
