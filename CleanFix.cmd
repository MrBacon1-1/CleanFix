@echo off

if not "%1"=="am_admin" (
    echo Checking For Admin Permissions...
    timeout 1 >null
    powershell -Command "Start-Process -Verb RunAs -FilePath '%0' -ArgumentList 'am_admin'"
    exit /b
)

:main
cls

color 3
title CleanFix v1.0.0 - By MrBacon
mode 76, 30

echo:
echo:
echo:
echo:
echo:       ______________________________________________________________
echo:
echo:                            ~ CleanFix v1.0.0 ~                       
echo:
echo:             [1] Currupted File Check / System Repair       
echo:             [2] Fix IP / Reset IP      
echo:             [3] Clean Temp Files    
echo:             __________________________________________________      
echo:
echo:             [4] Extras
echo:             [0] Exit
echo:       ______________________________________________________________
echo:

set /p opt="        CleanFix: "

if %opt% == 1 goto system
if %opt% == 2 goto ipfix
if %opt% == 3 goto temp
if %opt% == 4 goto extras
if %opt% == 0 exit /b

goto main

REM -------------------------------------------------------------------------------------------------------------------------------------------------------------------
REM System Fixing Commands
REM -------------------------------------------------------------------------------------------------------------------------------------------------------------------

:system
cls

echo [CleanFix] Press Enter To Begin... (Restart At The End)
pause >null
cls

echo [CleanFix] Checking For Curupted Files (1/3)
dism.exe /online /cleanup-image /restorehealth
timeout 5

cls

echo [CleanFix] Checking For Curupted Files (2/3)
dism.exe /online /cleanup-image /scanhealth
timeout 5

cls

echo [CleanFix] Checking For Curupted Files (3/3)
SFC /scannow

cls

echo [CleanFix] Restarting In 5 Seconds...
timeout 5 >null
shutdown.exe /r /t 00

REM -------------------------------------------------------------------------------------------------------------------------------------------------------------------
REM IP Fixing Commands
REM -------------------------------------------------------------------------------------------------------------------------------------------------------------------

:ipfix
cls

echo [CleanFix] Press Enter To Begin... (Restart At The End)
pause >null
cls

echo [CleanFix] Fixing IP 1/5
netsh winsock reset >nul
timeout 3 >null

cls

echo [CleanFix] Fixing IP 2/5
netsh int ip reset >nul
timeout 3 >null

cls

echo [CleanFix] Fixing IP 3/5
ipconfig /release >nul
timeout 3 >null

cls

echo [CleanFix] Fixing IP 4/5
ipconfig /renew >nul
timeout 3 >null

cls

echo [CleanFix] Fixing IP 5/5
ipconfig /flushdns >nul
timeout 3 >null

cls 

echo [CleanFix] Restarting In 5 Seconds
timeout 5 >null
shutdown.exe /r /t 00

REM -------------------------------------------------------------------------------------------------------------------------------------------------------------------
REM Clean Temp Files
REM -------------------------------------------------------------------------------------------------------------------------------------------------------------------

:temp
cls

echo [CleanFix] Press Enter To Begin...
pause >null

echo [CleanFix] Cleaning temporary files...

rd /s /q "%temp%"

FOR /F "tokens=1,2*" %%V IN ('bcdedit') DO SET adminTest=%%V
for /F "tokens=*" %%G in ('wevtutil.exe el') DO (call :do_clear "%%G")
echo.
goto theEnd

:do_clear
echo clearing %1
wevtutil.exe cl %1
goto :eof


:theEnd
cls
echo [CleanFix] Temporary files have been cleaned.
timeout 2 >null

REM -------------------------------------------------------------------------------------------------------------------------------------------------------------------
REM Extras
REM -------------------------------------------------------------------------------------------------------------------------------------------------------------------

:extras
cls

goto main