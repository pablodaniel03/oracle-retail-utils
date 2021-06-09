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
echo ATG Commerce 11.2.0 Environment
echo.

rem Java Settings
set "JAVA_HOME=D:\Program Files\Development\Java\jdk1.7.0_80"
set "ECLIPSE_HOME=D:\Program Files\Eclipse IDE\eclipse"
set "ANT_HOME=%ECLIPSE_HOME%\plugins\org.apache.ant_1.9.6.v201510161327"

set "PATH=%PATH%;%JAVA_HOME%\bin;%ANT_HOME%\bin"

rem Oracle Weblogic Server
set "MIDDLEWARE_HOME=D:\Oracle\middleware\12c\wls"
set "MD_HOME=%MIDDLEWARE_HOME%"
set "MW_HOME=%MIDDLEWARE_HOME%"
set "WL_HOME=%MIDDLEWARE_HOME%\wlserver"
set "WLS_HOME=%MIDDLEWARE_HOME%\wlserver"

set "DOMAIN_NAME=atg_domain"
set "DOMAIN_BASE=%MIDDLEWARE_HOME%\user_projects\domains"
set "DOMAIN_HOME=%DOMAIN_BASE%\%DOMAIN_NAME%"
set "DOMAIN_OVERRIDES=%DOMAIN_HOME%\bin\setUserOverrides.cmd"

set "PATH=%PATH%;%DOMAIN_HOME%\bin"

rem Oracle Database Server
set "ORACLE_BASE=D:\Oracle"
set "ORACLE_SID=ATGDB"
set "ORACLE_HOME=%ORACLE_BASE%\database\12c\dbhome_1"
set "TNS_ADMIN=%ORACLE_BASE%\network\admin"
set "SQLDEVELOPER=%ORACLE_HOME%\sqldeveloper\sqldeveloper.exe"

set "PATH=%PATH%;%ORACLE_HOME%\bin;%SQLDEVELOPER%"

rem Oracle ATG Commerce Platform
set "ATG_ROOT=D:\Oracle\ATG\ATG11.2"
set "ATG_HOME=%ATG_ROOT%\home"
set "DYNAMO_ROOT=%ATG_ROOT%"
set "DYNAMO_HOME=%ATG_HOME%"
set "DYNAMO_SERVER_NAME=production"
set "DYNAMO_SERVER_HOME=%DYNAMO_HOME%\servers\%DYNAMO_SERVER_NAME%"
set "ATGJRE=%JAVA_HOME%\bin\java"

set "PATH=%PATH%;%DYNAMO_HOME%\bin"


