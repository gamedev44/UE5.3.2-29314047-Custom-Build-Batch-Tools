@echo off
setlocal EnableExtensions

echo Running AutomationTool...
echo Created by P.G.D.

set SCRIPT_DIR=%~dp0
set UATExecutable=AutomationTool.dll
set UATDirectory=Binaries\DotNET\AutomationTool

rem Uppercase the drive letter
set DRIVE_LETTER=%~d0
FOR %%Z IN (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO (
    IF /I %DRIVE_LETTER%==%%Z: SET DRIVE_LETTER=%%Z:
)

set MSBUILD_LOGLEVEL=quiet
set FORCECOMPILE_UAT=
set NOCOMPILE_UAT=0
set SET_TURNKEY_VARIABLES=1

pushd "%SCRIPT_DIR%..\..\"
if not exist Build\BatchFiles\RunUAT.bat goto Error_BatchFileInWrongLocation

rem Unset some env vars that are set when running from VisualStudio
set VisualStudioDir=
set VSSKUEDITION=
set PkgDefApplicationConfigFile=
set VSAPPIDDIR=
set VisualStudioEdition=
set VisualStudioVersion=

:ParseArguments
set ARGUMENT=%1
if not defined ARGUMENT goto ParseArguments_Done
set ARGUMENT=%ARGUMENT:"=%
if /I "%ARGUMENT%" == "-msbuild-verbose" set MSBUILD_LOGLEVEL=normal
if /I "%ARGUMENT%" == "-compile" set FORCECOMPILE_UAT=FORCE
if /I "%ARGUMENT%" == "-nocompileuat" set NOCOMPILE_UAT=1
if /I "%ARGUMENT%" == "-noturnkeyvariables" set SET_TURNKEY_VARIABLES=0
shift
goto ParseArguments
:ParseArguments_Done

call "%SCRIPT_DIR%GetDotnetPath.bat"
if errorlevel 1 goto Error_NoDotnetSDK

if %NOCOMPILE_UAT%==1 goto RunPrecompiled
if exist Build\InstalledBuild.txt goto RunPrecompiled
if not "%ForcePrecompiledUAT%"=="" goto RunPrecompiled
if not exist Source\Programs\AutomationTool\AutomationTool.csproj goto RunPrecompiled
if not exist Source\Programs\AutomationToolLauncher\AutomationToolLauncher.csproj goto RunPrecompiled

call "%SCRIPT_DIR%BuildUAT.bat" %MSBUILD_LOGLEVEL% %FORCECOMPILE_UAT%
if errorlevel 1 goto Error_UATCompileFailed

goto DoRunUAT

:RunPrecompiled
if not exist %UATDirectory%\%UATExecutable% goto Error_NoFallbackExecutable
goto DoRunUAT

:DoRunUAT
pushd %UATDirectory%
dotnet %UATExecutable% %*
popd
set RUNUAT_ERRORLEVEL=%ERRORLEVEL%

if %SET_TURNKEY_VARIABLES% == 0 goto SkipTurnkey
if EXIST "%SCRIPT_DIR%..\..\Intermediate\Turnkey\PostTurnkeyVariables.bat" (
    endlocal & set RUNUAT_ERRORLEVEL=%RUNUAT_ERRORLEVEL%
    echo Updating environment variables set by a Turnkey sub-process
    call "%SCRIPT_DIR%..\..\Intermediate\Turnkey\PostTurnkeyVariables.bat"
    del "%SCRIPT_DIR%..\..\Intermediate\Turnkey\PostTurnkeyVariables.bat"
    setlocal
)
:SkipTurnkey

if not %RUNUAT_ERRORLEVEL% == 0 goto Error_UATFailed
goto Exit

:Error_BatchFileInWrongLocation
CALL :LogError "RunUAT.bat ERROR: The batch file does not appear to be located in the /Engine/Build/BatchFiles directory."
EXIT /B 999

:Error_NoDotnetSDK
CALL :LogError "RunUAT.bat ERROR: Unable to find an install of Dotnet SDK."
EXIT /B 999

:Error_NoFallbackExecutable
CALL :LogError "RunUAT.bat ERROR: Visual Studio and/or AutomationTool.csproj was not found, nor was %UATDirectory%\%UATExecutable%."
EXIT /B 999

:Error_UATCompileFailed
CALL :LogError "RunUAT.bat ERROR: AutomationTool failed to compile."
EXIT /B 999

:Error_UATFailed
CALL :LogError "RunUAT.bat ERROR: AutomationTool run failed with error code %RUNUAT_ERRORLEVEL%."
EXIT /B 999

:Exit
popd
EXIT /B 0

:LogError
set "ErrorMsg=%~1"
if not exist "%SCRIPT_DIR%Error Logs" mkdir "%SCRIPT_DIR%Error Logs"
echo %ErrorMsg% >> "%SCRIPT_DIR%Error Logs\Logfile.txt"
echo %ErrorMsg%
goto :eof
