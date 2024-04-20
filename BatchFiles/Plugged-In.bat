@echo off
cls
color 0f
Title Plugged In Rebuilder for UE5.3.2 by IndieUnlimited

set "BATCHFILES=%~dp0"
if not exist "%BATCHFILES%RunUAT.bat" (
    echo Error: This script must be located in the BatchFiles directory and RunUAT.bat must be present.
    echo Current directory: %BATCHFILES%
    pause
    exit /b 1
)

set "MARKETPLACEPATH=%~dp0..\Plugins\Marketplace"
if not exist "%MARKETPLACEPATH%" (
    echo Marketplace directory not found at %MARKETPLACEPATH%. Creating it...
    mkdir "%MARKETPLACEPATH%"
)

echo ******************************************************************
echo *            PLUGIN REBUILD TOOL     By Mr_Asterisk_Ceo        *
echo ******************************************************************
echo Note: Drag this script into the BatchFiles folder of your Unreal Engine installation.
echo Press any key to continue to the main menu...
pause >nul

echo Step 1: Select Plugin using File Explorer.
for /f "delims=" %%x in ('powershell -Command "Add-Type -AssemblyName System.Windows.Forms; $f=New-Object System.Windows.Forms.OpenFileDialog; $f.Filter='Unreal Engine Plugin (*.uplugin)|*.uplugin'; $f.ShowDialog() | Out-Null; $f.FileName"') do set PLUGIN=%%x
if "%PLUGIN%"=="" (
    echo No plugin was selected. Exiting the script.
    pause
    exit /b
)
echo Plugin selected: %PLUGIN%

echo Step 2: Enter Source Unreal Engine Version.
echo Choose Source Unreal Engine Version:
echo 1. UE 4.5
echo 2. UE 4.18
echo 3. UE 4.27
echo 4. UE 5.0
echo 5. UE 5.1
set /P UserChoice="Enter your choice (1-5): "
if "%UserChoice%"=="1" set SourceVersion=4.5
if "%UserChoice%"=="2" set SourceVersion=4.18
if "%UserChoice%"=="3" set SourceVersion=4.27
if "%UserChoice%"=="4" set SourceVersion=5.0
if "%UserChoice%"=="5" set SourceVersion=5.1
echo Source Version: UE %SourceVersion% selected.

echo Step 3: Enter Target Unreal Engine Version.
echo Choose Target Unreal Engine Version:
echo 1. UE 4.18
echo 2. UE 4.27
echo 3. UE 5.0
echo 4. UE 5.1
echo 5. UE 5.2
echo 6. UE 5.3
echo 7. UE 5.4
set /P UserChoice="Enter your choice (1-7): "
if "%UserChoice%"=="1" set TargetVersion=4.18
if "%UserChoice%"=="2" set TargetVersion=4.27
if "%UserChoice%"=="3" set TargetVersion=5.0
if "%UserChoice%"=="4" set TargetVersion=5.1
if "%UserChoice%"=="5" set TargetVersion=5.2
if "%UserChoice%"=="6" set TargetVersion=5.3
if "%UserChoice%"=="7" set TargetVersion=5.4
echo Target Version: UE %TargetVersion% selected.

echo Step 4: Starting the rebuild process.
set "BATCHFILES=C:\ue5.3\UE_%TargetVersion%\Engine\Build\BatchFiles"
cd /d %BATCHFILES%
set /p FOLDER="Folder name for rebuilt plugin (Enter for default): "
if "%FOLDER%"=="" set "FOLDER=RebuiltPlugin"
RunUAT.bat BuildPlugin -plugin="%PLUGIN%" -package="C:\ue5.3\UE_%TargetVersion%\Engine\Plugins\Marketplace\%FOLDER%"
echo Plugin rebuild process started. Check console for progress.
pause >nul

echo Step 5: Exit
echo Exiting the script...
exit /b