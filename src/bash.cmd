@ECHO OFF
setlocal EnableDelayedExpansion
for /f %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
title Bash

:Loop
echo.
echo !ESC![36m%USERNAME%@%COMPUTERNAME%!ESC![33m ~ !ESC![32m%CD%!ESC![0m
SET "INPUT="
SET /P "INPUT=$ "

:: Exit conditions (use =="" check safely with delayed expansion OFF)
SETLOCAL DISABLEDELAYEDEXPANSION
IF /I "%INPUT%"=="q"     ENDLOCAL & ENDLOCAL & EXIT /B
IF /I "%INPUT%"=="exit"  ENDLOCAL & ENDLOCAL & EXIT /B
IF "%INPUT%"=="^C"       ENDLOCAL & ENDLOCAL & EXIT /B
ENDLOCAL & SET "CMD=%INPUT%":: --- Handle cd manually ---
for /f "tokens=1,* delims= " %%A in ("!input!") do (
    if /i "%%A"=="cd" (
        if "%%B"=="" (
            echo !CD!
        ) else (
            cd /d %%B
        )
        goto Loop
    )
)

:: --- Run everything else in PowerShell ---
powershell -NoLogo -NoProfile -Command "!input!"
goto Loop
