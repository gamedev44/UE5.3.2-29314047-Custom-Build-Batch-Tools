@echo off
setlocal

IF NOT EXIST "%~dp0\Build.bat" GOTO Error_MissingBuildBatchFile

call "%~dp0\Build.bat" %* -Clean
IF %ERRORLEVEL% NEQ 0 CALL :LogError "Error during build clean operation."
goto Exit

:Error_MissingBuildBatchFile
CALL :LogError "Build.bat not found in '%~dp0'."
EXIT /B 999

:Exit
exit /b

:LogError
set "ErrorMsg=%~1"
if not exist "%~dp0Error Logs" mkdir "%~dp0Error Logs"
echo %ErrorMsg% >> "%~dp0Error Logs\Logfile.txt"
echo %ErrorMsg%
goto :eof
