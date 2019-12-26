:://///////////////////////////////////////////////////////////////////////////
:: AG Development Framework.
:: Copyright 2011-2020 GeorgeAth. All Rights Reserved.
:://///////////////////////////////////////////////////////////////////////////
:: AG-CI : Run.
:://///////////////////////////////////////////////////////////////////////////
@echo off

:: Set the default target file.
if "%AG_TARGET_FILE%"=="" ( SET "AG_TARGET_FILE=.\build\build-script.bat" )
:: Set the default arguments.
if "%AG_TARGET_ARGS%"=="" ( SET "AG_TARGET_ARGS=-ci" )
:: Set the default target name.
if "%AG_TARGET_NAME%"=="" ( SET "AG_TARGET_NAME=AG-DEV" )

:: LOG: (current directory) > (run command) [arguments]
echo.
echo %CD%^>%0 %*
:: Ensure required folder exist and if not exit this script with error 1.
if not exist ..\%AG_TARGET_NAME% ( echo ERROR: target not found. && exit /b 1 )
:: Go to target-root.
echo INFO: Change directory to target-root.
pushd ..\%AG_TARGET_NAME%
echo DIR : %CD%
:: Construct run command.
SET "AG_RUN_CMD=%AG_TARGET_FILE% %AG_TARGET_ARGS%"
:: Run the target.
echo RUN : %AG_RUN_CMD%
CALL %AG_RUN_CMD%
echo.
:: Restore path.
echo INFO: Restore path from target-root.
popd
echo DIR : %CD%
:: Check for errors.
IF %ERRORLEVEL% NEQ 0 (
	echo ERROR: An error occurred while attempting to run: %AG_TARGET_NAME%\%AG_RUN_CMD%
) else (
	echo INFO: Run %AG_TARGET_NAME%\%AG_RUN_CMD% complete.
)

:: Exit this script.
exit /b
