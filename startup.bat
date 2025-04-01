@echo off
echo      ____       __                    __             __                       __          __  
echo     / __ \___  / /___ ___  __   _____/ /_____ ______/ /_      __  ______     / /_  ____ _/ /_ 
echo    / / / / _ \/ / __ `/ / / /  / ___/ __/ __ `/ ___/ __/_____/ / / / __ \   / __ \/ __ `/ __/ 
echo   / /_/ /  __/ / /_/ / /_/ /  (__  ) /_/ /_/ / /  / /_/_____/ /_/ / /_/ /  / /_/ / /_/ / /_   
echo  /_____/\___/_/\__,_/\__, /  /____/\__/\__,_/_/   \__/      \__,_/ .___/  /_.___/\__,_/\__/   
echo                     /____/                                      /_/                    V 1.5.0
echo.

setlocal enabledelayedexpansion

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

set idx=1
cd %APP_LOCATION%
for %%a in (*.lnk, *.txt) do (
    if "%%~xa"==".lnk" (
        if !idx! gtr 1 (
            echo waitng 30 sec... [%%~na]
            timeout 30 > nul
        ) else (
            echo waitng 60 sec... [%%~na]
            timeout 60 > nul
        )
        start cmd /C start %%a
        set /a idx=!idx!+1
    ) else (
        setlocal disabledelayedexpansion
        for /f "usebackq delims=\ tokens=*" %%l in (%%a) do (
            echo waitng 30 sec... [%%~na]
            timeout 30 > nul
            cmd /c start shell:Appsfolder\%%l
        )
        setlocal enabledelayedexpansion
    )
)
endlocal
