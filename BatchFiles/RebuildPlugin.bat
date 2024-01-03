@echo off
setlocal enabledelayedexpansion

rem Batch script for rebuilding Unreal Engine plugins
rem Allows the user to select a plugin and specify source and target Unreal Engine versions for rebuilding
rem Created by P.G.D.

:MainMenu
cls
echo Unreal Engine Plugin Rebuilder
echo 1. Select Plugin using File Explorer
echo 2. Enter Source Unreal Engine Version
echo 3. Enter Target Unreal Engine Version
echo 4. Start Rebuild
echo 5. Exit
echo.
set /P UserChoice="Enter your choice (1-5): "

if "%UserChoice%"=="1" goto SelectPlugin
if "%UserChoice%"=="2" goto EnterSourceVersion
if "%UserChoice%"=="3" goto EnterTargetVersion
if "%UserChoice%"=="4" goto StartRebuild
if "%UserChoice%"=="5" goto ExitScript
goto MainMenu

:SelectPlugin
echo Select the plugin file (.uplugin) using File Explorer.
for /f "delims=" %%x in ('powershell -Command "Add-Type -AssemblyName System.Windows.Forms; $f=New-Object System.Windows.Forms.OpenFileDialog; $f.Filter=\"Unreal Engine Plugin (*.uplugin)|*.uplugin\"; $f.ShowDialog() | Out-Null; $f.FileName"') do set PLUGIN=%%x
if "%PLUGIN%"=="" goto MainMenu
echo Plugin selected: %PLUGIN%
goto MainMenu

:EnterSourceVersion
set /P SourceVersion="Enter Source Unreal Engine Version (e.g., 5.1): "
if "%SourceVersion%"=="" goto MainMenu
echo Source Version: %SourceVersion%
goto MainMenu

:EnterTargetVersion
set /P TargetVersion="Enter Target Unreal Engine Version (e.g., 5.3.2): "
if "%TargetVersion%"=="" goto MainMenu
echo Target Version: %TargetVersion%
goto MainMenu

:StartRebuild
if "%PLUGIN%"=="" (
    echo No plugin selected. Please select a plugin first.
    goto MainMenu
)
if "%SourceVersion%"=="" (
    echo Source version not specified. Please enter the source version.
    goto MainMenu
)
if "%TargetVersion%"=="" (
    echo Target version not specified. Please enter the target version.
    goto MainMenu
)
call :RebuildPlugin
goto MainMenu

:RebuildPlugin
set BATCHFILES="C:\ue5.3\UE_%TargetVersion%\Engine\Build\BatchFiles"
C:
cd %BATCHFILES%
set /p FOLDER="Folder name for rebuilt plugin (Enter for default): "
if "%FOLDER%"=="" set FOLDER=RebuiltPlugin
RunUAT.bat BuildPlugin -plugin="%PLUGIN%" -package="C:\ue5.3\UE_%TargetVersion%\Engine\Plugins\Marketplace\%FOLDER%"
echo Plugin rebuild process started. Check console for progress.
pause >nul
goto :eof

:ExitScript
exit /b
