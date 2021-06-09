#!/bin/bash

echo
echo "ATG Commerce 11.2 Environment for Impuls"
echo

## Java Settings
export JAVA_HOME="/usr/bin/jdk1.7.0_80"
export ECLIPSE_HOME="/mnt/d/Program Files/Eclipse IDE/eclipse"
export ANT_HOME="${ECLIPSE_HOME}/plugins/org.apache.ant_1.9.6.v201510161327"

export PATH="${PATH}:${JAVA_HOME}/bin:${ANT_HOME}/bin"

## Oracle Weblogic Server
export MIDDLEWARE_HOME="/mnt/sdcard/Oracle/middleware/12c/wls"
export MD_HOME="${MIDDLEWARE_HOME}"
export MW_HOME="${MIDDLEWARE_HOME}"
export WL_HOME="${MIDDLEWARE_HOME}/wlserver"
export WLS_HOME="${MIDDLEWARE_HOME}/wlserver"

export DOMAIN_NAME="atg_domain"
export DOMAIN_BASE="${MIDDLEWARE_HOME}/user_projects/domains"
export DOMAIN_HOME="${DOMAIN_BASE}/${DOMAIN_NAME}"
export DOMAIN_OVERRIDES="${DOMAIN_HOME}/bin/setUserOverrides.sh"

export PATH="${PATH}:${DOMAIN_HOME}/bin"

## Oracle Database Server
export ORACLE_BASE="/mnt/sdcard/Oracle"
export ORACLE_HOME="${ORACLE_BASE}/database/12c/dbhome_1"
export TNS_ADMIN="${ORACLE_BASE}/network/admin"
export SQLDEVELOPER="${ORACLE_HOME}/sqldeveloper/sqldeveloper.exe"

export PATH="${PATH}:${ORACLE_HOME}/bin:${SQLDEVELOPER}"

## Oracle ATG Commerce Platform
export ATG_ROOT="/mnt/sdcard/Oracle/ATG/ATG11.2"
export ATG_HOME="${ATG_ROOT}/home"
export DYNAMO_ROOT="${ATG_ROOT}"
export DYNAMO_HOME="${ATG_HOME}"
export DYNAMO_SERVER_NAME="production"
export DYNAMO_SERVER_HOME="${DYNAMO_HOME}/servers/$DYNAMO_SERVER_NAME"
export ATGJRE="${JAVA_HOME}/bin/java"

export PATH="${PATH}:$DYNAMO_HOME/bin"


