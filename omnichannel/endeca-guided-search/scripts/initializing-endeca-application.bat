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
rem Usage: initializing-endeca-application.bat
rem   Endeca<varsion>_Environment.bat needs to be sourced
rem   before running this script.
rem 

echo.
echo Initializing a new Endeca Application
echo ----------------------------------------------------------------------------------------------------
echo Go into %%ENDECA_APP_ROOT%%\control folder and run the following script in order:
echo   1. initialize_services.bat –force
echo   2. load_baseline_test_data.bat
echo   3. baseline_update.bat
echo   4. promote_content.bat
echo.