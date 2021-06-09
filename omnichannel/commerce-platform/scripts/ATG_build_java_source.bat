@echo off

REM call %~dp0ATG11.2_Environment.bat
echo Make sure to source the ATG environment before compiling...
echo.

REM set "JAVA_HOME=D:\Program Files\Development\Java\jdk1.7.0_80"
REM set "ECLIPSE_HOME=D:\Program Files\Eclipse IDE\eclipse"
REM set "ANT_HOME=%ECLIPSE_HOME%\plugins\org.apache.ant_1.9.6.v201510161327"
REM set "ATG_HOME=E:\Oracle\ATG\ATG11.2"
REM set "GN_HOME=%ATG_HOME%\GN"
REM set "MD_HOME=E:\Oracle\middleware\12c\wls"
REM set "WLS_HOME=%MD_HOME%\wlserver"
REM set "GN_HOME=%DYNAMO_ROOT%\..\Workspace\Impuls\atg"

REM call %~dp0ATG_impuls_classpath.bat
echo You need to source the ATG classpath file to be able to compile...
echo.
echo.

echo.
echo Compiling java source: 
echo ---------------------------------------------------
echo %%JAVA_HOME%%\bin\javac -d %%GN_HOME%%\Core\lib\classes.jar -classpath %%ATG_CLASSPATH%% -sourcepath %%GN_HOME%%\Core\src\main\java %%GN_HOME%%\Core\src\main\java\com\gn\emailEmailSender.java
echo.
echo Verbosed compilation of java source:
echo ---------------------------------------------------
echo %%JAVA_HOME%%\bin\javac -d %%GN_HOME%%\Core\lib\classes.jar -classpath %%ATG_CLASSPATH%% -sourcepath %%GN_HOME%%\Core\src\main\java -g -verbose %%GN_HOME%%\Core\src\main\java\com\gn\emailEmailSender.java
echo. 
echo Build eclipse workspace:
echo ---------------------------------------------------
echo %%ANT_HOME%%\bin\ant -debug -buildfile %%GN_HOME%%\Build\build-windows.xml
echo.