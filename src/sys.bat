@echo off

if not "%1"=="" goto main
else goto void

:main
REM Check parameter and jump to the corresponding label
if "%1"=="/s" goto shutdown
if "%1"=="/r" goto restart
if "%1"=="/sl" goto sleep
if "%1"=="/e" goto explorer
if "%1"=="/downloads" goto downloads
if "%1"=="/w" goto web
if "%1"=="/h" goto help
goto void

:shutdown
REM Shutdown with optional timer (default 0)
set /a timer=0
if not "%2"=="" set /a timer=%2  
shutdown /s /f /t %timer%
goto void

:restart
REM Restart immediately
shutdown /r /f /t 0
goto void

:sleep
REM Sleep for given seconds or default to 5
set /a timer=5
if not "%2"=="" set /a timer=%2
timeout /t %timer%
goto void

:explorer
REM Open Windows Explorer
explorer
goto void

:downloads
REM Open Downloads Folder
explorer "%USERPROFILE%\Downloads"
goto void

:help
REM Show Help options
echo /s [timer]   shutdown
echo /r           restart
echo /sl [timer]  sleep
echo /e           Explorer
echo /downloads   Downloads
echo /w <url>     Website
goto void

:web
REM Open Specified Website
if "%2"=="" (
  echo fatal: Url not specified
  goto void
)
start "" "https://www.%2"
goto void

REM End of script label
:void
