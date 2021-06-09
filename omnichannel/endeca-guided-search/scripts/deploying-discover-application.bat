@echo off
rem
rem ----------------------------------------------
rem Created by: Pablo Almaguer
rem Creation date: 2020/04/01
rem 
rem Fork or clone from source repo:
rem  https://bitbucket.org/pablodaniel03
rem ----------------------------------------------
rem
rem Usage: deploying-discover-application.bat
rem   Endeca<varsion>_Environment.bat needs to be sourced
rem   before running this script.
rem 

echo.
echo Deploying Endeca Discover Electronics
echo ----------------------------------------------------------------------------------------------------
echo First you have to recreate your admin credential running the following command: 
echo   - %%ENDECA_TOOLS_ROOT%%\credential_store\bin\manage_credentials.bat add --user admin --config %%ENDECA_TOOLS_ROOT%%\server\workspace\credential_store\jps-config.xml --mapName endecaToolsAndFrameworks --key ifcr
echo.
echo Finally deploy Discover Electronics application integrated with CAS:
echo   - %%ENDECA_TOOLS_ROOT%%\deployment_template\bin\deploy.bat --app %%ENDECA_TOOLS_ROOT%%\reference\discover-data-cas\deploy.xml
echo.