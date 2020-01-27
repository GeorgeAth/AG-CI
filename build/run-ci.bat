@echo off
:://///////////////////////////////////////////////////////////////////////////
:: AG Development Framework.
:: Copyright 2011-2020 GeorgeAth. All Rights Reserved.
:://///////////////////////////////////////////////////////////////////////////
:: Project: AG-CI [master]
:: Updated: 27-01-2020
:://///////////////////////////////////////////////////////////////////////////
:: Description: Run CI/CD.
:://///////////////////////////////////////////////////////////////////////////

:: Set the default target environment.
if "%AG_CI_ENV%"=="" ( SET "AG_CI_ENV=.." )
:: Set the default target project.
if "%AG_CI_PROJECT%"=="" ( SET "AG_CI_PROJECT=AG-DEV" )
:: Set the default target file.
if "%AG_CI_FILE%"=="" ( SET "AG_CI_FILE=.\scripts\ag.bat" )
:: Set the default arguments.
if "%AG_CI_ARGS%"=="" ( SET "AG_CI_ARGS=--ci" )

:: LOG: (current directory)>(run command) [arguments]
echo.
echo %CD%^>%0 %*
:: Ensure required folder exist and if not exit this script with error.
if not exist "%AG_CI_ENV%\%AG_CI_PROJECT%" ( echo "ERROR: target not found." && exit /b 1 )
:: Go to target-root.
echo "INFO: Change directory to target-root."
pushd "%AG_CI_ENV%\%AG_CI_PROJECT%"
echo "DIR : %CD%"
:: Construct run command.
if "%AG_CI_ARGS%"=="" (
	SET "AG_RUN_CMD=%AG_CI_FILE%
) else (
	SET "AG_RUN_CMD=%AG_CI_FILE% %AG_CI_ARGS%"
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
	echo "ERROR: An error occurred while attempting to run: %AG_CI_PROJECT%\%AG_RUN_CMD%"
) else (
	echo "INFO: Run %AG_CI_PROJECT%\%AG_RUN_CMD% complete."
)

:: Exit this script.
exit /b %ec%
