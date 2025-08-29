@echo off
setlocal

if "%~1"=="" goto help

:: Dispatcher
if "%~1"=="/s"  goto shutdown
if "%~1"=="/r"  goto restart
if "%~1"=="/b"  goto bios
if "%~1"=="/sl" goto sleep
if "%~1"=="/e"  goto explorer
if "%~1"=="/downloads" goto downloads
if "%~1"=="/w"  goto web
if "%~1"=="/h"  goto help
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

:: Sleep (just delays console, doesn’t really sleep PC)
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

:: Help
:help
echo.
echo Usage:
echo   /s [timer]      Shutdown (default 0 sec)
echo   /r              Restart
echo   /b              Restart into BIOS
echo   /sl [seconds]   Sleep (console delay)
echo   /e [dir|home]   Open Explorer
echo   /downloads      Open Downloads folder
echo   /w <url>        Open Website
echo   /h              Show this help
goto :eof

:: Invalid command
:invalid
echo Unknown command: %~1
echo Use /h for help.
goto :eof

