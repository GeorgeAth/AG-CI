:://///////////////////////////////////////////////////////////////////////////
:: AG Development Framework.
:: Copyright 2011-2020 GeorgeAth. All Rights Reserved.
:://///////////////////////////////////////////////////////////////////////////
@echo off
:://///////////////////////////////////////////////////////////////////////////

:://///////////////////////////////////////////////////////////////////////////
:: Enviroment Variables
set "AG_BUILD_TYPE=Release"
set "AG_DIR_OUT=build"
set "AG_DIR_SRC=AG-DEV"
set "AG_DIR_DEP=AG-LIB"
::-----------------------------------------------------------------------------

:://///////////////////////////////////////////////////////////////////////////
:: Print current script.
echo file : %0
:: Print the current directory. (expected: <project-root>)
echo project : %CD%
:: Change directory to the <eviroment-root>.
cd ..
:: Print the current directory. (expected: <enviroment-root>)
echo env-root : %CD%
::-----------------------------------------------------------------------------
:: Ensure required folders exist and if not exit this script with error 1.
if not exist %AG_DIR_SRC% ( echo ERROR: src not found. && exit /b 1 )
if not exist %AG_DIR_DEP% ( echo ERROR: dep not found. && exit /b 1 )
::-----------------------------------------------------------------------------
:: Ensure output directory does not exist.
if exist %AG_DIR_OUT% ( echo ERROR: out %AG_DIR_OUT% exist. && exit /b 1 )
:: Create output directory.
mkdir %AG_DIR_OUT%
:: Change directory to output.
cd %AG_DIR_OUT%
echo output : %CD%
::-----------------------------------------------------------------------------


:://///////////////////////////////////////////////////////////////////////////
:: Ensure cmake is available on the current build environment.
where /q cmake
:: Check for errors and exit this script if any.
IF %ERRORLEVEL% NEQ 0 ( echo ERROR: cmake not found. && exit /b )
::-----------------------------------------------------------------------------
:: Ensure ctest is available on the current build environment.
where /q ctest
:: Check for errors and exit this script if any.
IF %ERRORLEVEL% NEQ 0 ( echo ERROR: ctest not found. && exit /b )
::-----------------------------------------------------------------------------


:://///////////////////////////////////////////////////////////////////////////
:: Build command: create.
SET "AG_CMD_CREATE=cmake ../%AG_DIR_SRC%"
::-----------------------------------------------------------------------------
:: Build command: build.
SET "AG_CMD_BUILD=cmake --build . --config %AG_BUILD_TYPE%"
::-----------------------------------------------------------------------------
:: Build command: test.
SET "AG_CMD_TEST=ctest -C %AG_BUILD_TYPE%"
::-----------------------------------------------------------------------------
:: Print commands.
echo command create: %AG_CMD_CREATE%
echo command build: %AG_CMD_BUILD%
echo command test: %AG_CMD_TEST%
::-----------------------------------------------------------------------------


:://///////////////////////////////////////////////////////////////////////////
:: Run command: create.
%AG_CMD_CREATE%
:: Check for errors and exit this script if any.
IF %ERRORLEVEL% NEQ 0 ( echo ERROR: create command fail. && exit /b )
::-----------------------------------------------------------------------------
:: Run command: build.
%AG_CMD_BUILD%
:: Check for errors and exit this script if any.
IF %ERRORLEVEL% NEQ 0 ( echo ERROR: build command fail. && exit /b )
::-----------------------------------------------------------------------------
:: Run command: test.
%AG_CMD_TEST%
:: Check for errors and exit this script if any.
IF %ERRORLEVEL% NEQ 0 ( echo ERROR: test command fail. && exit /b )
::-----------------------------------------------------------------------------


:://///////////////////////////////////////////////////////////////////////////
:: Exit this script.
exit /b
::-----------------------------------------------------------------------------
