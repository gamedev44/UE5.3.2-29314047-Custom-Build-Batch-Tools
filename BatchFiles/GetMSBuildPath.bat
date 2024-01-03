@echo off
setlocal enabledelayedexpansion

echo MSBuild Locator for Unreal Engine
echo Created by P.G.D.

:MainMenu
cls
echo MSBuild Locator for Unreal Engine
echo Options:
echo 1 - Locate MSBuild
echo 2 - Exit
echo.
set /P UserChoice="Enter your choice (1-2): "

if "%UserChoice%"=="1" goto LocateMSBuild
if "%UserChoice%"=="2" goto ExitScript
goto MainMenu

:LocateMSBuild
call :FindMSBuild
if not "%MSBUILD_EXE%"=="" (
    echo MSBuild located at: %MSBUILD_EXE%
) else (
    call :LogError "MSBuild not found. Ensure Visual Studio is installed."
)
pause >nul
goto MainMenu

:FindMSBuild
set MSBUILD_EXE=

if not exist "%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" goto no_vswhere
for /f "delims=" %%i in ('"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere" -prerelease -latest -products * -requires Microsoft.Component.MSBuild -property installationPath') do (
    if exist "%%i\MSBuild\Current\Bin\MSBuild.exe" (
        set MSBUILD_EXE="%%i\MSBuild\Current\Bin\MSBuild.exe"
        goto Succeeded
    )
    if exist "%%i\MSBuild\15.0\Bin\MSBuild.exe" (
        set MSBUILD_EXE="%%i\MSBuild\15.0\Bin\MSBuild.exe"
        goto Succeeded
    )
)
:no_vswhere

call :ReadInstallPath Microsoft\VisualStudio\SxS\VS7 15.0 MSBuild\15.0\bin\MSBuild.exe
if not errorlevel 1 goto Succeeded

if exist "%ProgramFiles(x86)%\MSBuild\14.0\bin\MSBuild.exe" (
    set MSBUILD_EXE="%ProgramFiles(x86)%\MSBuild\14.0\bin\MSBuild.exe"
    goto Succeeded
)

call :ReadInstallPath Microsoft\MSBuild\ToolsVersions\14.0 MSBuildToolsPath MSBuild.exe
if not errorlevel 1 goto Succeeded

call :ReadInstallPath Microsoft\MSBuild\ToolsVersions\12.0 MSBuildToolsPath MSBuild.exe
if not errorlevel 1 goto Succeeded

call :LogError "MSBuild could not be located."
exit /B 1

:Succeeded
exit /B 0

:ReadInstallPath
for /f "tokens=2,*" %%A in ('REG.exe query HKCU\SOFTWARE\%1 /v %2 2^>Nul') do (
    if exist "%%B%%3" (
        set MSBUILD_EXE="%%B%3"
        exit /B 0
    )
)
for /f "tokens=2,*" %%A in ('REG.exe query HKLM\SOFTWARE\%1 /v %2 2^>Nul') do (
    if exist "%%B%3" (
        set MSBUILD_EXE="%%B%3"
        exit /B 0
    )
)
for /f "tokens=2,*" %%A in ('REG.exe query HKCU\SOFTWARE\Wow6432Node\%1 /v %2 2^>Nul') do (
    if exist "%%B%%3" (
        set MSBUILD_EXE="%%B%3"
        exit /B 0
    )
)
for /f "tokens=2,*" %%A in ('REG.exe query HKLM\SOFTWARE\Wow6432Node\%1 /v %2 2^>Nul') do (
    if exist "%%B%3" (
        set MSBUILD_EXE="%%B%3"
        exit /B 0
    )
)
exit /B 1

:LogError
set "ErrorMsg=%~1"
if not exist "Error Logs" mkdir "Error Logs"
echo %ErrorMsg% >> "Error Logs\Logfile.txt"
echo %ErrorMsg%
goto :eof

:ExitScript
exit /b
