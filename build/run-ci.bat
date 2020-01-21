@echo off
:://///////////////////////////////////////////////////////////////////////////
:: AG Development Framework.
:: Copyright 2011-2020 GeorgeAth. All Rights Reserved.
:://///////////////////////////////////////////////////////////////////////////
:: Project: AG-CI
:: Updated: 21-01-2020
:://///////////////////////////////////////////////////////////////////////////
:: Description: Run CI.
:://///////////////////////////////////////////////////////////////////////////

:: Set the default target name.
if "%AG_TARGET_NAME%"=="" ( SET "AG_TARGET_NAME=AG-DEV" )
:: Set the default target file.
if "%AG_TARGET_FILE%"=="" ( SET "AG_TARGET_FILE=.\scripts\ag.bat" )
:: Set the default arguments.
if "%AG_TARGET_ARGS%"=="" ( SET "AG_TARGET_ARGS=--ci" )

:: LOG: (current directory)>(run command) [arguments]
echo.
echo %CD%^>%0 %*
:: Ensure required folder exist and if not exit this script with error.
if not exist "..\%AG_TARGET_NAME%" ( echo "ERROR: target not found." && exit /b 1 )
:: Go to target-root.
echo "INFO: Change directory to target-root."
pushd "..\%AG_TARGET_NAME%"
echo "DIR : %CD%"
:: Construct run command.
if "%AG_TARGET_ARGS%"=="" (
	SET "AG_RUN_CMD=%AG_TARGET_FILE%
) else (
	SET "AG_RUN_CMD=%AG_TARGET_FILE% %AG_TARGET_ARGS%"
)
:: Run the command.
echo "RUN : %AG_RUN_CMD%"
CALL %AG_RUN_CMD%
SET "ec=%ERRORLEVEL%"
echo.
:: Restore path.
echo "INFO: Restore path from target-root."
popd
echo "DIR : %CD%"
:: Check for errors.
IF %ec% NEQ 0 (
	echo "ERROR: An error occurred while attempting to run: %AG_TARGET_NAME%\%AG_RUN_CMD%"
) else (
	echo "INFO: Run %AG_TARGET_NAME%\%AG_RUN_CMD% complete."
)

:: Exit this script.
exit /b %ec%
