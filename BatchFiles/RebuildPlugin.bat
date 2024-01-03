@echo off

set BATCHFILES="C:\ue5.3\UE_5.3\Engine\Build\BatchFiles"
C:

cd %BATCHFILES%
set /p PLUGIN="Plugin directory with .uplugin Included:"
set PLUGIN=%PLUGIN:"=%
set /p FOLDER="Folder name for rebuilt plugin: "
RunUAT.bat BuildPlugin -plugin="%PLUGIN%" -package="C:\ue5.3\UE_5.3\Engine\Plugins\Marketplace\%FOLDER%"
pause >nul