@echo off
setlocal

if "%~1"=="" goto help

:: Dispatcher (accepts /s or s, same for others)
if /i "%~1"=="/s"  goto shutdown
if /i "%~1"=="s"   goto shutdown

if /i "%~1"=="/r"  goto restart
if /i "%~1"=="r"   goto restart

if /i "%~1"=="/b"  goto bios
if /i "%~1"=="b"   goto bios

if /i "%~1"=="/sl" goto sleep
if /i "%~1"=="sl"  goto sleep

if /i "%~1"=="/e"  goto explorer
if /i "%~1"=="e"   goto explorer

if /i "%~1"=="/downloads" goto downloads
if /i "%~1"=="downloads"  goto downloads
if /i "%~1"=="d"          goto downloads

if /i "%~1"=="/w"  goto web
if /i "%~1"=="w"   goto web

if /i "%~1"=="/h"  goto help
if /i "%~1"=="h"   goto help

goto invalid

:: Shutdown with optional timer (default 0)
:shutdown
set "timer=0"
if not "%~2"=="" set "timer=%~2"
shutdown /s /f /t %timer%
goto :eof

:: Restart immediately
:restart
shutdown /r /f /t 0
goto :eof

:: Restart into BIOS
:bios
shutdown /r /fw /f /t 0
goto :eof

:: Sleep (console delay)
:sleep
set "timer=5"
if not "%~2"=="" set "timer=%~2"
timeout /t %timer%
goto :eof

:: Open Explorer
:explorer
set "dir=%~2"
if "%dir%"=="" set "dir=."
if /i "%dir%"=="home" set "dir=%USERPROFILE%"
explorer "%dir%"
goto :eof

:: Open Downloads folder
:downloads
explorer "%USERPROFILE%\Downloads"
goto :eof

:: Open Website
:web
if "%~2"=="" (
  echo fatal: URL not specified
  goto :eof
)
start "" "%~2"
goto :eof

:path
path.cmd
goto :eof

:: Help
:help
help
goto :eof

:: Invalid command
:invalid
echo Unknown command: %~1
echo Use /h or h for help.
goto :eof


