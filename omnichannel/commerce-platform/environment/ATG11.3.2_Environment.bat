@echo off
rem
rem ----------------------------------------------
rem Created by: Pablo Almaguer
rem Creation date: 2019/11/20
rem 
rem Fork or clone from source repo:
rem  https://bitbucket.org/pablodaniel03
rem ----------------------------------------------
rem

echo.
echo ATG Commerce 11.3.2 Environment
echo.

rem Oracle Database Server
set "ORACLE_BASE=D:\oracle"
set "ORACLE_SID=ORACLE"
set "ORACLE_HOME=%ORACLE_BASE%\database\19c\dbhome_1"
set "TNS_ADMIN=%ORACLE_HOME%\network\admin"
set "SQLDEVELOPER=%ORACLE_BASE%\sqldeveloper\sqldeveloper.exe"

set "PATH=%PATH%;%ORACLE_HOME%\bin;%SQLDEVELOPER%"

rem Java Settings
set "JAVA_HOME=%ORACLE_BASE%\Java\jdk1.8.0_261"
set "ECLIPSE_HOME=%ORACLE_BASE%\Eclipse-IDE\eclipse-mars"
set "ANT_HOME=%ECLIPSE_HOME%\plugins\org.apache.ant_1.9.6.v201510161327"

set "PATH=%PATH%;%JAVA_HOME%\bin;%ANT_HOME%\bin\ant.cmd"

rem Oracle Weblogic Server
rem set "MIDDLEWARE_HOME=%ORACLE_BASE%\middleware\12c\wls"
set "MIDDLEWARE_HOME=%ORACLE_BASE%\middleware\wls"
set "MD_HOME=%MIDDLEWARE_HOME%"
set "MW_HOME=%MIDDLEWARE_HOME%"
set "WL_HOME=%MIDDLEWARE_HOME%\wlserver"
set "WLS_HOME=%MIDDLEWARE_HOME%\wlserver"

set "DOMAIN_NAME=ATGDomain"
set "DOMAIN_BASE=%MIDDLEWARE_HOME%\user_projects\domains"
set "DOMAIN_HOME=%DOMAIN_BASE%\%DOMAIN_NAME%"
set "DOMAIN_OVERRIDES=%DOMAIN_HOME%\bin\setUserOverrides.cmd"

set "PATH=%PATH%;%DOMAIN_HOME%\bin"

rem Oracle ATG Commerce Platform
set "ATG_ROOT=%ORACLE_BASE%\ATG\ATG11.3.2"
set "ATG_HOME=%ATG_ROOT%\home"
set "DYNAMO_ROOT=%ATG_ROOT%"
set "DYNAMO_HOME=%ATG_HOME%"
set "DYNAMO_SERVER_NAME=production"
set "DYNAMO_SERVER_HOME=%DYNAMO_HOME%\servers\%DYNAMO_SERVER_NAME%"
set "ATGJRE=%JAVA_HOME%\bin\java"

set "PATH=%PATH%;%DYNAMO_HOME%\bin"



if not [%1]==[] if [%1] == [--full] (
    set "PATH=%PATH%;%~dp0..\scripts"
    echo   ATG scripts folder included in PATH
    echo.
)

:sourceEndeca
rem Endeca Guided Search
call %~dp0..\..\endeca-guided-search\env\Endeca11.3.2_Environment.bat %1
