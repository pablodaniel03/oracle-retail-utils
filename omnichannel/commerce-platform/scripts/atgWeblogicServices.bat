@echo off
rem
rem ----------------------------------------------
rem Created by: Pablo Almaguer
rem Creation date: 2020/06/02
rem 
rem Fork or clone from source repo:
rem  https://bitbucket.org/pablodaniel03
rem ----------------------------------------------
rem
rem Usage: atgWeblogicServices.bat start|stop
rem   ATG<version>_Environment.bat needs to be sourced
rem   before running this script.
rem 

set args="%*"
:argloop
for /f "tokens=1*" %%a in (%args%) do (
  
  if "%%a"=="start" goto :startWeblogicServices
  if "%%a"=="stop" goto :stopWeblogicServices
  
  goto :usage
  set args="%%b"
)
if not [%args%]==[""] goto :argloop
goto :usage

:usage
  echo Usage:
  echo    %0 [start]^|[stop]
  echo.
goto :failed

set action=
set nodeMgrCmd=
set wlsCmd=


:startWeblogicServices
	set "action=Starting"
	set "nodeMgrCmd=%DOMAIN_HOME%\bin\startNodeManager.cmd"
	set "wlsCmd=%DOMAIN_HOME%\startWebLogic.cmd"
goto :end

:stopWeblogicServices
	set "action=Stopping"
	set "nodeMgrCmd=%DOMAIN_HOME%\bin\stopNodeManager.cmd"
	set "wlsCmd=%DOMAIN_HOME%\bin\stopWebLogic.cmd"
goto :end


:end
	echo.
  echo %action% Endeca Services for ATG
  echo ------------------------------------------
  echo.
	echo  1. Node Manager

	if exist %nodeMgrCmd% (
		echo    %nodeMgrCmd%
		start CMD /c "TITLE Node Manager of %DOMAIN_NAME% domain & %nodeMgrCmd%"
	)

	timeout /t 5 /nobreak > NUL

	echo  1. Weblogic AdminServer
	if exist %wlsCmd% (
		echo    %wlsCmd%
		start CMD /c "TITLE Weblogic AdminServer of %DOMAIN_NAME% domain & %wlsCmd%"
	)

	echo.
	if not %ERRORLEVEL%==0 goto :failed
  exit /b 0

:failed
  exit /b 1