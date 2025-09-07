@ECHO OFF
setlocal EnableDelayedExpansion
for /f %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
title Bash
:Loop
echo.
echo !ESC![36m%USERNAME%@%COMPUTERNAME% !ESC![33m~ !ESC![32m%CD%!ESC![0m
SET /P input=$ 
if "%input%"=="q" endlocal & goto :eof
if "%input%"=="Q" endlocal & goto :eof
if NOT "%input%"=="" powershell -command "%input%"
goto Loop

