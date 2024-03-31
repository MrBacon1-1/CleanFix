@echo off

if not "%1"=="am_admin" (
    echo Checking For Admin Permissions...
    timeout 1 >nul
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
echo:             [5] Exit
echo:       ______________________________________________________________
echo:

choice /C:12345 /N
set _erl=%errorlevel%

if %_erl%==5 exit /b
if %_erl%==4 goto extras
if %_erl%==3 goto temp
if %_erl%==2 goto ipfix
if %_erl%==1 goto system

goto main

REM -------------------------------------------------------------------------------------------------------------------------------------------------------------------
REM System Fixing Commands
REM -------------------------------------------------------------------------------------------------------------------------------------------------------------------

:system
cls

echo [CleanFix] Press Enter To Begin... (Restart At The End)
pause >nul
cls

echo [CleanFix] Checking For Corrupted Files (1/3)
dism.exe /online /cleanup-image /restorehealth >nul 2>&1
timeout 2 >nul

cls

echo [CleanFix] Checking For Corrupted Files (2/3)
dism.exe /online /cleanup-image /scanhealth >nul 2>&1
timeout 2 >nul

cls

echo [CleanFix] Checking For Corrupted Files (3/3)
SFC /scannow >nul 2>&1

cls

echo [CleanFix] Restarting In 5 Seconds...
timeout 5 >nul
shutdown.exe /r /t 00

REM -------------------------------------------------------------------------------------------------------------------------------------------------------------------
REM IP Fixing Commands
REM -------------------------------------------------------------------------------------------------------------------------------------------------------------------

:ipfix
cls

echo [CleanFix] Press Enter To Begin... (Restart At The End)
pause >nul
cls

echo [CleanFix] Fixing IP 1/5
netsh winsock reset >nul 2>&1
timeout 3 >nul

cls

echo [CleanFix] Fixing IP 2/5
netsh int ip reset >nul 2>&1
timeout 3 >nul

cls

echo [CleanFix] Fixing IP 3/5
ipconfig /release >nul 2>&1
timeout 3 >nul

cls

echo [CleanFix] Fixing IP 4/5
ipconfig /renew >nul 2>&1
timeout 3 >nul

cls

echo [CleanFix] Fixing IP 5/5
ipconfig /flushdns >nul 2>&1
timeout 3 >nul

cls 

echo [CleanFix] Restarting In 5 Seconds
timeout 5 >nul
shutdown.exe /r /t 00

REM -------------------------------------------------------------------------------------------------------------------------------------------------------------------
REM Clean Temp Files
REM -------------------------------------------------------------------------------------------------------------------------------------------------------------------

:temp
cls

echo [CleanFix] Press Enter To Begin...
pause >nul

echo [CleanFix] Clearing CryptNet SSL Certificate Cache...

certutil -URLcache * delete >nul 2>&1

echo [CleanFix] Done Clearing CryptNet SSL Certificate Cache.

echo [CleanFix] Clearing Windows Update Cache...

net stop WUAUSERV >nul 2>&1
if exist %windir%\softwaredistribution\download rmdir /s /q %windir%\softwaredistribution\download >nul 2>&1
net start WUAUSERV >nul 2>&1

echo [CleanFix] Done Clearing Windows Update Cache.

echo [CleanFix] Clearing System Temp Files...

del /F /S /Q "%WINDIR%\TEMP\*" >nul 2>&1

if exist "%ProgramFiles%\Nvidia Corporation\Installer2" rmdir /s /q "%ProgramFiles%\Nvidia Corporation\Installer2" >nul 2>&1
if exist "%ALLUSERSPROFILE%\NVIDIA Corporation\NetService" del /f /q "%ALLUSERSPROFILE%\NVIDIA Corporation\NetService\*.exe" >nul 2>&1

if exist %SystemDrive%\MSOCache rmdir /S /Q %SystemDrive%\MSOCache >nul 2>&1

if exist %SystemDrive%\i386 rmdir /S /Q %SystemDrive%\i386 >nul 2>&1

if exist "%ALLUSERSPROFILE%\Microsoft\Windows Defender\Scans\History\Results\Quick" rmdir /s /q "%ALLUSERSPROFILE%\Microsoft\Windows Defender\Scans\History\Results\Quick" >nul 2>&1
if exist "%ALLUSERSPROFILE%\Microsoft\Windows Defender\Scans\History\Results\Resource" rmdir /s /q "%ALLUSERSPROFILE%\Microsoft\Windows Defender\Scans\History\Results\Resource" >nul 2>&1

if exist "%ALLUSERSPROFILE%\Microsoft\Search\Data\Temp" rmdir /s /q "%ALLUSERSPROFILE%\Microsoft\Search\Data\Temp" >nul 2>&1

if exist "%ProgramFiles%\NVIDIA Corporation\Installer" rmdir /s /q "%ProgramFiles%\NVIDIA Corporation\Installer" >nul 2>&1
if exist "%ProgramFiles%\NVIDIA Corporation\Installer2" rmdir /s /q "%ProgramFiles%\NVIDIA Corporation\Installer2" >nul 2>&1
if exist "%ProgramFiles(x86)%\NVIDIA Corporation\Installer" rmdir /s /q "%ProgramFiles(x86)%\NVIDIA Corporation\Installer" >nul 2>&1
if exist "%ProgramFiles(x86)%\NVIDIA Corporation\Installer2" rmdir /s /q "%ProgramFiles(x86)%\NVIDIA Corporation\Installer2" >nul 2>&1
if exist "%ProgramData%\NVIDIA Corporation\Downloader" rmdir /s /q "%ProgramData%\NVIDIA Corporation\Downloader" >nul 2>&1
if exist "%ProgramData%\NVIDIA\Downloader" rmdir /s /q "%ProgramData%\NVIDIA\Downloader" >nul 2>&1

echo [CleanFix] Done Clearing System Temp Files.

echo [CleanFix] Press Enter To Return To Menu...
pause >nul

goto main

REM -------------------------------------------------------------------------------------------------------------------------------------------------------------------
REM Extras
REM -------------------------------------------------------------------------------------------------------------------------------------------------------------------

:extras
cls

goto main