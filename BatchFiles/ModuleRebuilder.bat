@echo off
setlocal enabledelayedexpansion

rem Batch script for rebuilding Unreal Engine modules with error logging
rem Allows the user to select a module, specify source and target Unreal Engine versions, and target project
rem Error logs are saved in the 'Error Logs' folder
echo Created by P.G.D.

:MainMenu
cls
echo Unreal Engine Module Rebuilder by P.G.D.
echo 1. Select Module using File Explorer
echo 2. Enter Source Unreal Engine Version
echo 3. Enter Target Unreal Engine Version
echo 4. Specify Target Project File
echo 5. Start Rebuild
echo 6. Exit
echo.
set /P UserChoice="Enter your choice (1-6): "

if "%UserChoice%"=="1" goto SelectModule
if "%UserChoice%"=="2" goto EnterSourceVersion
if "%UserChoice%"=="3" goto EnterTargetVersion
if "%UserChoice%"=="4" goto EnterTargetProject
if "%UserChoice%"=="5" goto StartRebuild
if "%UserChoice%"=="6" goto ExitScript
goto MainMenu

:SelectModule
echo Select the module file (.umodule) using File Explorer.
for /f "delims=" %%x in ('powershell -Command "Add-Type -AssemblyName System.Windows.Forms; $f=New-Object System.Windows.Forms.OpenFileDialog; $f.Filter=\"Unreal Engine Module (*.umodule)|*.umodule\"; $f.ShowDialog() | Out-Null; $f.FileName"') do set MODULE=%%x
if "%MODULE%"=="" goto MainMenu
echo Module selected: %MODULE%
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

:EnterTargetProject
set /P TargetProject="Enter the full path to the target project file (e.g., C:\Projects\MyProject\MyProject.uproject): "
if "%TargetProject%"=="" goto MainMenu
echo Target Project: %TargetProject%
goto MainMenu

:StartRebuild
if "%MODULE%"=="" (
    echo No module selected. Please select a module first.
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
if "%TargetProject%"=="" (
    echo Target project not specified. Please enter the target project.
    goto MainMenu
)
call :RebuildModule
goto MainMenu

:RebuildModule
set BATCHFILES="C:\ue5.3\UE_%TargetVersion%\Engine\Build\BatchFiles"
set ERRORLOGS="C:\ue5.3\UE_%TargetVersion%\Engine\Error Logs"
if not exist "%ERRORLOGS%" mkdir "%ERRORLOGS%"

C:
cd %BATCHFILES%
set /p FOLDER="Folder name for rebuilt module (Enter for default): "
if "%FOLDER%"=="" set FOLDER=RebuiltModule

RunUAT.bat BuildModule -module="%MODULE%" -package="C:\ue5.3\UE_%TargetVersion%\Engine\Modules\%FOLDER%" -project="%TargetProject%" > "%ERRORLOGS%\%FOLDER%_ErrorLog.txt" 2>&1

echo Module rebuild process started. Check console for progress.
echo Error logs (if any) will be saved in: %ERRORLOGS%
pause >nul
goto :eof

:ExitScript
exit /b
