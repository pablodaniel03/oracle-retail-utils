#!/bin/bash

# Author: Pablo Almaguer (pablo.almaguer@logicinfo.com)
#   Date: 01/06/2021


printf "\n"
printf "\e[0;32m=========== ATG Utilities Loaded ===========\e[m"
printf "\n\n"
export PS1="\e[0;31m\u\e[m:\e[0;34m\W\e[m \$ "


# Global Variables
export ORACLE_BASE="/home/oracle"
export MD_HOME="${ORACLE_BASE}/Oracle/Middleware/Oracle_Home"
export WLS_HOME="${MD_HOME}/wlserver"
export DOMAIN_NAME="atg_domain"
export DOMAIN_BASE="${MD_HOME}/user_projects/domains"
export DOMAIN_HOME="${DOMAIN_BASE}/${DOMAIN_NAME}"
export DOMAIN_OVERRIDES="${DOMAIN_HOME}/bin/setUserOverrides.sh"

export DYNAMO_ROOT="${ORACLE_BASE}/ATG/ATG11.2"
export DYNAMO_HOME="${DYNAMO_ROOT}/home"

export ATG_ROOT="${DYNAMO_ROOT}"
export ATG_HOME="${DYNAMO_HOME}"
export ATG_UTILS="$(readlink -f ${BASH_SOURCE[0]})"
export ATG_PROJECT_NAME="GN"
export ATG_PROJECT_DIR="${ORACLE_BASE}/git/logic/atg11.2"
export ATG_ENV="qa"




alias atgUtils="source ${ATG_UTILS}"
alias atgProject="cd ${DYNAMO_ROOT}/${ATG_PROJECT_NAME}"
alias atgGitProject="cd ${ATG_PROJECT_DIR}"
alias atgBuildModule="cd ${ATG_PROJECT_DIR}/Build"


###################################################################
#
#
function atgBuild {
  antFile="build.xml"
  target="build-ears"
  
  if [[ ! -z ${1} ]]; then
    target=${1}
  fi

  message "Building ATG for target \"${target}\""
  runAnt ${antFile} ${target}
}

###################################################################
#
#
function atgDeploy {
  antFile="deploy.xml"
  target="exec"


  message "Running ANT Deployment for Weblogic"
  runAnt ${antFile} ${target}
}

###################################################################
#
#
function atgClean {
  message "Cleanning ATG Deployment"

  rm -vrf ${ATG_ROOT}/$ATG_PROJECT_NAME &> /dev/null
  rm -vrf ${ATG_HOME}/cimEars/*.ear &> /dev/null
  rm -vrf ${WLS_HOME}/../user_projects/domains/gn_domain/servers/*/tmp/* &> /dev/null
}

###################################################################
#
#
function atgUpdate {
  message "Updating local repository from remote"  
  
  atgGitProject
  git fetch && git pull
}


function wlsUsrOvrd {
  if [[ $1 == "list" ]]; then
    cat "${DOMAIN_OVERRIDES}"
  else
    vi "${DOMAIN_OVERRIDES}"
  fi
}



###################################################################
#
#
function runAnt {
  local antFile=$1
  local antTarget=$2

  _goToBuild
  
  echo "----------------------------------------------------------"
  echo "-- Running ANT (${antFile}) for target \"${antTarget}\""
  echo "----------------------------------------------------------"
  echo "- DYNAMO_ROOT=${DYNAMO_ROOT}"
  echo "- WLS_HOME=${WLS_HOME}"
  echo "- ATG_ENV=${ATG_ENV}"
  echo "----------------------------------------------------------"

  _cleanLog
  nohup ant -DDYNAMO_ROOT=${DYNAMO_ROOT} -DWLS_HOME=${WLS_HOME} -DATG_ENV=${ATG_ENV} -f ${antFile} ${antTarget} &
  _tailLog
}

###################################################################


###########################################
# Function __message
# ---------------------------------
# privately called by _message, for log script.
#
# $1 - Line number
# $2 - Level "DEBUG" 
#            "INFO"
#            "WARNING"
#            "ERROR" 
# $3 - Double quoted message string
###########################################
function _message {
  typeset lineno=${1}
  typeset level=${2}
  typeset msg="${3}"

  printf "[$(date +'%T')][${level}][$(basename ${BASH_SOURCE[0]}):${lineno}] - ${msg}\n"
}
alias debug="_message ${LINENO} '\e[0;36mDEBUG\e[m'"       # Custom alias for WARNING message.
alias warning="_message ${LINENO} '\e[0;33mWARNING\e[m'"       # Custom alias for WARNING message.
alias error="_message ${LINENO} '\e[0;31mERROR\e[m'"           # Custom alias for ERROR message.
alias message="_message ${LINENO} '\e[0;34mINFO\e[m'"   # Custom alias for integration scripts.

function _cleanLog {
  rm nohup.out &> /dev/null
}
function _tailLog {
  sleep 2
  tail -100f nohup.out
}
