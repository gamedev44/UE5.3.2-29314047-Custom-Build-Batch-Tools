@echo off
setlocal enabledelayedexpansion

rem This is a build script for Unreal Engine 5.3.2 projects.
rem It automates the build process for a specified game, platform, and configuration.
rem Created by P.G.D.

:MainMenu
cls
echo Unreal Engine 5.3.2 Build Script
echo 1. Enter Game Name manually
echo 2. Select Game Name using File Explorer
echo 3. Enter Platform Name
echo 4. Enter Configuration Name
echo 5. Start Build
echo 6. Exit
echo.
set /P UserChoice="Enter your choice (1-6): "

if "%UserChoice%"=="1" goto EnterGameName
if "%UserChoice%"=="2" goto SelectGameName
if "%UserChoice%"=="3" goto EnterPlatformName
if "%UserChoice%"=="4" goto EnterConfigName
if "%UserChoice%"=="5" goto StartBuild
if "%UserChoice%"=="6" goto ExitScript
goto MainMenu

:EnterGameName
set /P GameName="Enter Game Name: "
goto MainMenu

:SelectGameName
for /f "delims=" %%x in ('powershell -Command "Add-Type -AssemblyName System.Windows.Forms; $f=New-Object System.Windows.Forms.OpenFileDialog; $f.InitialDirectory=[System.IO.Path]::GetFullPath(\".\"); $f.Filter=\"All files (*.*)|*.*\"; $f.ShowDialog() | Out-Null; $f.FileName"') do set GameName=%%x
goto MainMenu

:EnterPlatformName
set /P PlatformName="Enter Platform Name: "
if "%PlatformName%"=="" set PlatformName=DefaultPlatform
goto MainMenu

:EnterConfigName
set /P ConfigName="Enter Configuration Name: "
if "%ConfigName%"=="" set ConfigName=DefaultConfig
goto MainMenu

:StartBuild
call :BuildProcess
goto MainMenu

:ExitScript
exit /b

:BuildProcess
if not exist "%~dp0..\..\Source" goto Error_Location
pushd "%~dp0\..\..\Source"
if not exist ..\Build\BatchFiles\Build.bat goto Error_Location

set UBTPath="..\..\Engine\Binaries\DotNET\UnrealBuildTool\UnrealBuildTool.dll"

call "%~dp0GetDotnetPath.bat"
if errorlevel 1 goto Error_Dotnet

if exist ..\Build\InstalledBuild.txt goto ReadyToBuild

:ReadyToBuildUBT
set ProjectFile="Programs\UnrealBuildTool\UnrealBuildTool.csproj"
if not exist %ProjectFile% goto NoProjectFile

if not exist %UBTPath% (
    if "%VisualStudioVersion%" GEQ "17.0" (
        echo Building UnrealBuildTool with %VisualStudioEdition%...
        "%VSAPPIDDIR%..\..\MSBuild\Current\Bin\MSBuild.exe" %ProjectFile% -t:Build -p:Configuration=Development -verbosity:quiet -noLogo
        if errorlevel 1 goto Error_UBTCompile
    ) else (
        echo Building UnrealBuildTool with dotnet...
        dotnet build %ProjectFile% -c Development -v quiet
        if errorlevel 1 goto Error_UBTCompile
    )
)

:ReadyToBuild
if not exist %UBTPath% goto Error_UBTMissing
echo Running UnrealBuildTool: dotnet %UBTPath% %GameName% %PlatformName% %ConfigName%
dotnet %UBTPath% %GameName% %PlatformName% %ConfigName%
goto EndScript

:Error_Location
call :LogError "ERROR: Batch file in wrong location."
goto EndScript

:Error_Dotnet
call :LogError "ERROR: Dotnet SDK not found."
goto EndScript

:Error_UBTCompile
call :LogError "ERROR: Failed to build UnrealBuildTool."
goto EndScript

:Error_UBTMissing
call :LogError "ERROR: UnrealBuildTool.dll not found."
goto EndScript

:NoProjectFile
call :LogError "ERROR: UnrealBuildTool project file missing."
goto EndScript

:LogError
set "ErrorMsg=%~1"
if not exist "%~dp0..\..\Error Logs" mkdir "%~dp0..\..\Error Logs"
echo %ErrorMsg% >> "%~dp0..\..\Error Logs\Logfile.txt"
echo %ErrorMsg%
goto :eof

:EndScript
popd
goto MainMenu
