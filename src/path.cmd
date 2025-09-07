@echo off
if "%1"=="" goto :eof
if "%1"=="add" goto :Add

:Add
set "newPath=%~2"
SETX PATH "%PATH%;%newPath%" /M
goto :eof
