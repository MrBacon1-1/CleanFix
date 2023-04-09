@echo off
color 2
title CleanFix By MrBacon

mode con: cols=80 lines=30

net session >nul 2>&1
if %errorLevel% == 0 (
    goto main
) else (
    echo Must be ran with adminisatrator permisions!
    timeout 5 >null
    exit
)

:main
cls

echo ~CleanFix By MrBacon#7458~
echo ----------------
echo [1] Currupted File Check / System Repair
echo [2] Fix IP / Reset IP
echo [3] Clean Temp Files
echo ----------------

set /p opt= Option: 

if %opt% == 1 goto cfile
if %opt% == 2 goto ipfix
if %opt% == 3 goto temp
if %opt% != 1 or 2 or 3 exit

REM -------------------------------------------------------------------------------------------------------------------------------------------------------------------
REM System Fixing Commands
REM -------------------------------------------------------------------------------------------------------------------------------------------------------------------

:cfile
cls

echo [?] Press Enter To Begin (Restart At The End)
pause >null
cls

echo [!] Checking For Curupted Files
dism.exe /online /cleanup-image /restorehealth
echo [?] Step One Done
timeout 5

cls

echo [!] Checking For Curupted Files
dism.exe /online /cleanup-image /scanhealth
echo [?] Step Two Done
timeout 5

cls

echo [!] Checking For Curupted Files
SFC /scannow

cls

echo [?] Step Three Done Restarting In 5 Seconds
timeout 5 >null
shutdown.exe /r /t 00

REM -------------------------------------------------------------------------------------------------------------------------------------------------------------------
REM IP Fixing Commands
REM -------------------------------------------------------------------------------------------------------------------------------------------------------------------

:ipfix
cls

echo [?] Press Enter To Begin (Restart At The End)
pause >null
cls

echo [?] Fixing IP 1/5
netsh winsock reset >nul
timeout 3 >null

cls

echo [?] Fixing IP 2/5
netsh int ip reset >nul
timeout 3 >null

cls

echo [?] Fixing IP 3/5
ipconfig /release >nul
timeout 3 >null

cls

echo [?] Fixing IP 4/5
ipconfig /renew >nul
timeout 3 >null

cls

echo [?] Fixing IP 5/5
ipconfig /flushdns >nul
timeout 3 >null

cls 

echo [?] Done, Restarting In 5 Seconds
timeout 5 >null
shutdown.exe /r /t 00

REM -------------------------------------------------------------------------------------------------------------------------------------------------------------------
REM Clean Temp Files
REM -------------------------------------------------------------------------------------------------------------------------------------------------------------------

:temp
cls

echo [?] Cleaning temporary files...

del /q /s "%TEMP%\*.*" >nul

cls
echo [?] Temporary files have been cleaned.
timeout 2 >null

goto main



