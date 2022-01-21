@echo off
REM --------------------------------------------
REM  Delay start-up bat
REM  v 0.0.1
REM --------------------------------------------
setlocal

set APP_LOCATION=%SystemDrive%\Users\%USERNAME%\startup
set STARTUP_PATH=%SystemDrive%\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
set SELF_FILE=%0
set SELF_FILE_NAME=%~nx0

if not exist "%STARTUP_PATH%\%SELF_FILE_NAME%" (
    echo Install Startup bat...
    copy /Y "%SELF_FILE_NAME%" "%STARTUP_PATH%\%SELF_FILE_NAME%" > nul
    echo Install done.
    pause
    exit 0
)

fc %SELF_FILE% "%STARTUP_PATH%\%SELF_FILE_NAME%" > nul
if %ERRORLEVEL% neq 0 (
    echo Update Startup bat...
    copy /Y "%SELF_FILE_NAME%" "%STARTUP_PATH%\%SELF_FILE_NAME%" > nul
    echo Install done.
    pause
    exit 0
)

timeout 60
cd %APP_LOCATION%
for %%a in (*.lnk) do (
  start cmd /C start %%a
  timeout 30 > nul
)
endlocal
