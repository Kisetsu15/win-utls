@echo off
set RUN_DIR=%APPDATA%\Local\Run

:Dispatcher
if "%1"=="add" goto Add
if "%1"=="list" goto List
if "%1"=="remove" goto Remove
if "%1"=="rm" goto Remove
if "%1"=="/?" goto Help
if "%1"=="clear" goto Clear
goto Help

:Add
set name=%2
set path=%3
set filePath=%RUN_DIR%\%name%.cmd

if "%name%"=="" set /p name=StartupItem Name: 
if "%path%"=="" set /p path=Path to Executable/URL: 

call :IsEmpty "%name%" "Name"
if %errorlevel% NEQ 0 goto :eof
call :IsEmpty "%path%" "Path"
if %errorlevel% NEQ 0 goto :eof

if exist "%filePath%" (
    echo A startup item with the name "%name%" already exists.
    goto :eof
)

call :DirectoryCheck
(
    echo @echo off
    echo start "" "%path%" %%*
) > "%filePath%"

echo Added startup item: %name% (%path%)
goto :eof

:Remove
set name=%~2
if "%name%"=="" set /p name=StartupItem Name to Remove: 

call :IsEmpty "%name%" "Name"
if %errorlevel% NEQ 0 goto :eof

set filePath=%RUN_DIR%\%name%.cmd
if not exist "%filePath%" (
    echo No startup item found with the name "%name%".
    goto :eof
)
del "%filePath%"
echo Removed startup item: %name%
goto :eof

:List
call :DirectoryCheck
dir /b %RUN_DIR%
goto :eof

:Clear
set /p confirm=Are you sure you want to remove all startup items? (y/n): 
if /i "%confirm%"=="y" (
    del /q %RUN_DIR%\*.cmd
    echo All startup items have been removed.
) else (
    echo Operation cancelled.
)
goto :eof

:Help
echo Usage: run.cmd [command] [arguments]
echo.
echo Commands:
echo   add [name] [path]    - Add a new startup item.
echo   list                 - List all startup items.
echo   remove|rm [name]     - Remove a startup item by name.
echo   clear                - Remove all startup items.
echo   /?                   - Show this help message.
goto :eof

:DirectoryCheck
if not exist %RUN_DIR% (
    mkdir %RUN_DIR%
)
exit /b

:: IsEmpty <variable> <variableName>
:IsEmpty
if "%~1"=="" (
    echo %~2 cannot be empty.
    exit /b 1
)
exit /b 0
