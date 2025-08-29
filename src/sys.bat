@echo off

if not "%1"=="" goto commnad_executor
else goto help

:: Check parameter and jump to the corresponding label
:commnad_executor 
if "%1"=="/s" goto shutdown
if "%1"=="/r" goto restart
if "%1"=="/b" goto bios
if "%1"=="/sl" goto sleep
if "%1"=="/e" goto explorer
if "%1"=="/downloads" goto downloads
if "%1"=="/w" goto web
if "%1"=="/h" goto help
goto void

:: Shutdown with optional timer (default 0)
:shutdown 
set /a timer=0
if not "%2"=="" set /a timer=%2
shutdown /s /f /t %timer%
goto void

:: Restart immediately
:restart 
shutdown /r /f /t 0
goto void

:: Restart into BIOS
:bios 
shutdown /r /fw /f /t 0
goto void

:: Sleep for given seconds or default to 5
:sleep 
set /a timer=5
if not "%2"=="" set /a timer=%2
timeout /t %timer%
goto void

:: Open Windows Explorer
:explorer 
if "%1"=="" set dir="."
if "%2"=="home" set dir=""
explorer %dir%
goto void

:: Open Downloads Folder
:downloads 
explorer "%USERPROFILE%\Downloads"
goto void

:: Show Help options
:help 
echo /s [timer]     Shutdown
echo /r             Restart
echo /b             BIOS
echo /sl [timer]    Sleep
echo /e  [address]  Explorer
echo /downloads     Downloads
echo /w <url> 	    Website
goto void

:: Open Specified Website
:web
if "%2"=="" (
  echo fatal: Url not specified
  goto void
)
start "" "https://%2"
goto void

:: End of script label
:void
