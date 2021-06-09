@echo off
rem
rem ----------------------------------------------
rem Created by: Pablo Almaguer
rem Creation date: 2020/01/10
rem 
rem Fork or clone from source repo:
rem  https://bitbucket.org/pablodaniel03
rem ----------------------------------------------
rem

echo.
echo Endeca Guided Search 11.3.2 Environment
echo.

rem Oracle Guided Search
set "ENDECA_BASE=D:\Oracle\Endeca"
set "ENDECA_APP_NAME=CRS"
set "ENDECA_APP_HOME=%ENDECA_BASE%\Apps"
set "ENDECA_APP_ROOT=%ENDECA_APP_HOME%\%ENDECA_APP_NAME%"

rem MDEX
set "ENDECA_MDEX_BASE=%ENDECA_BASE%"
set "ENDECA_MDEX_ROOT=%ENDECA_BASE%\MDEX\11.3.2"
set "MDEX_INI=%ENDECA_MDEX_ROOT%"

set "PATH=%PATH%;%ENDECA_MDEX_ROOT%\bin"

rem Platform Services
set "ENDECA_CONF=%ENDECA_BASE%\PlatformServices\workspace"
set "ENDECA_REFERENCE_DIR=%ENDECA_BASE%\PlatformServices\reference"
set "ENDECA_ROOT=%ENDECA_BASE%\PlatformServices\11.3.2.0.0"
set "PLATFORM_SERVICES_INI=%ENDECA_ROOT%\setup"
set "PLATFORM_SERVICES_WORKSPACE_INI=%ENDECA_CONF%\setup"

set "PATH=%PATH%;%ENDECA_ROOT%\bin;%ENDECA_ROOT%\j2sdk\jre\bin\server"

rem Tools and Framework
set "ENDECA_TOOLS_ROOT=%ENDECA_BASE%\ToolsAndFrameworks\11.3.2.0.0"
set "ENDECA_TOOLS_CONF=%ENDECA_TOOLS_ROOT%\server\workspace"

rem CAS
set "CAS_ROOT=%ENDECA_BASE%\CAS\11.3.2.0.0"
set "CAS_HOST=localhost"
set "CAS_PORT=8500"


if not [%1]==[] if [%1] == [--full] (
    set "PATH=%PATH%;%~dp0..\scripts"
    echo   Endeca scripts folder included in PATH
    echo.
)