@echo off
setlocal enabledelayedexpansion

rem ## Unreal Engine code rebuild script
rem ## Copyright Epic Games, Inc. All Rights Reserved.
rem ## Modified and enhanced by P.G.D.
rem ##
rem ## This script is now a menu-driven system for rebuilding Unreal Engine code.
rem ## It allows for manual entry of game name, platform name, and configuration name.

:MainMenu
cls
echo Unreal Engine Code Rebuild Script
echo 1. Enter Game Name
echo 2. Enter Platform Name
echo 3. Enter Configuration Name
echo 4. Start Rebuild
echo 5. Exit
echo.
set /P UserChoice="Enter your choice (1-5): "

if "%UserChoice%"=="1" goto EnterGameName
if "%UserChoice%"=="2" goto EnterPlatformName
if "%UserChoice%"=="3" goto EnterConfigName
if "%UserChoice%"=="4" goto StartRebuild
if "%UserChoice%"=="5" goto ExitScript
goto MainMenu

:EnterGameName
set /P GameName="Enter Game Name: "
if "%GameName%"=="" set GameName=DefaultGame
goto MainMenu

:EnterPlatformName
set /P PlatformName="Enter Platform Name: "
if "%PlatformName%"=="" set PlatformName=DefaultPlatform
goto MainMenu

:EnterConfigName
set /P ConfigName="Enter Configuration Name: "
if "%ConfigName%"=="" set ConfigName=DefaultConfig
goto MainMenu

:StartRebuild
IF NOT EXIST "%~dp0\Build.bat" GOTO Error_MissingBuildBatchFile
call "%~dp0\Build.bat" %GameName% %PlatformName% %ConfigName% -Rebuild
echo Rebuild process started. Check console for progress.
goto MainMenu

:Error_MissingBuildBatchFile
ECHO ERROR: Build.bat not found in "%~dp0"
pause >nul
goto MainMenu

:ExitScript
exit /b
