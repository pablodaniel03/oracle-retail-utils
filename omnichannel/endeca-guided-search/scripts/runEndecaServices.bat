@echo off
rem
rem ----------------------------------------------
rem Created by: Pablo Almaguer
rem Creation date: 2020/06/01
rem 
rem Fork or clone from source repo:
rem  https://bitbucket.org/pablodaniel03
rem ----------------------------------------------
rem
rem Usage: runEndecaService.bat start|stop
rem   Endeca<version>_Environment.bat needs to be sourced
rem   before running this script.
rem 

set args="%*"
:argloop
for /f "tokens=1*" %%a in (%args%) do (
  
  if "%%a"=="start" goto :startEndecaServices
  if "%%a"=="stop" goto :stopEndecaServices
  
  goto :usage
  set args="%%b"
)
if not [%args%]==[""] goto :argloop
goto :usage

:usage
  echo Usage:
  echo    script-name [start]^|[stop]
  echo.
goto :failed

set action=
set platformServicesEnv=
set platformServicesCmd=
set toolsAndFrameworksCmd=
set casCmd=

:startEndecaServices
  set "action=Starting"
  set "platformServicesEnv=%ENDECA_ROOT%\tools\server\bin\setenv.bat"
  set "platformServicesCmd=%ENDECA_ROOT%\tools\server\bin\startup.bat"
  set "toolsAndFrameworksCmd=%ENDECA_TOOLS_ROOT%\server\bin\run.bat"
  set "casCmd=%CAS_ROOT%\bin\cas-service.bat"
goto :end

:stopEndecaServices
  set "action=Stopping"
  set "platformServicesEnv=%ENDECA_ROOT%\tools\server\bin\setenv.bat"
  set "platformServicesCmd=%ENDECA_ROOT%\tools\server\bin\shutdown.bat"
  set "toolsAndFrameworksCmd=%ENDECA_TOOLS_ROOT%\server\bin\stop.bat"
  set "casCmd=%CAS_ROOT%\bin\cas-service-shutdown.bat"
goto :end


:end
  echo.
  echo %action% Endeca Services
  echo --------------------------------------
  echo.
  echo  1. Platform Services
  echo    %platformServicesCmd%
  call ""%platformServicesEnv%"" > nul 2>&1
  start CMD /c "TITLE Endeca Platform Services & %platformServicesCmd%"
  
  echo  2. Tools ^& Frameworks
  echo    %toolsAndFrameworksCmd%
  start CMD /c "TITLE Endeca Tools ^& Frameworks & %toolsAndFrameworksCmd%"

  echo  3. CAS Service 
  echo    %casCmd%
  start CMD /c "TITLE Endeca CAS & %casCmd%"


  if not %ERRORLEVEL%==0 goto :failed
  exit /b 0

:failed
  exit /b 1

