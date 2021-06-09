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
rem Usage: atgDatabaseServices.bat start|stop
rem   ATG<version>_Environment.bat needs to be sourced
rem   before running this script.
rem 

set args="%*"

set "action="
set "tnsLsnPid="
set "tnsLsnCmd=%ORACLE_HOME%\bin\tnslsnr.exe"
set "dbLsnrCtlCmd=%ORACLE_HOME%\bin\lsnrctl.exe"

:argloop
	for /f "tokens=1*" %%a in (%args%) do (
		if "%%a"=="start" goto :startOraDbServices
    if "%%a"=="status" goto :statusOraDbServices
		if "%%a"=="stop" goto :stopOraDbServices
		
		goto :usage
		set args="%%b"
	)
if not [%args%]==[""] goto :argloop
goto :usage

:usage
  echo Usage:
  echo    %0 [start]^|[status]^|[stop]
  echo.
goto :failed




:startOraDbServices
	set "action=Starting"
  start CMD /c "TITLE %ORACLE_SID% Database TNS Listener & %tnsLsnCmd%"
  timeout /t 5 /nobreak > NUL
  rem start CMD /c "TITLE %ORACLE_SID% Database Listener & %dbLsnrCtlCmd% start"
  

goto :end

:statusOraDbServices
	set "action=Status"
  call ""%dbLsnrCtlCmd% status""
  

goto :end

:stopOraDbServices
	set "action=Stopping"
  for /F "tokens=2" %%i in ('tasklist /NH /FI "IMAGENAME eq tnslsnr.exe*"') do set tnsLsnPid=%%i

  echo Killing TNS listener of ORACLE_SID "%ORACLE_SID%" (%tnsLsnPid%)
  taskkill /F /PID %tnsLsnPid%
goto :end


:end
	echo.
  echo %action% Oracle Database for ATG
  echo ------------------------------------------
  echo.

	if not %ERRORLEVEL%==0 goto :failed
  exit /b 0

:failed
  exit /b 1