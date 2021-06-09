#!/bin/bash
#####################################
# Pablo Almaguer
# Shell Profile for Oracle Commerce Platform
# Development Environment
#
# Ver: 1.0 [20192910]
#
SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
SCRIPT_PATH="$(dirname "${BASH_SOURCE[0]}")"
export RETAIL_PROFILE="Oracle Commerce Platform"


# Linux Settings
export HOSTNAME="$(uname -n)"
export PROCESSORS="$(lscpu | sed -ne '4s/^[^ ]* *//p')"          # Numero de Procesadores
export CPU_MHz="$(lscpu | grep "CPU MHz" | awk '{print $3}')"    # Velocidad de Procesadores
export RAM_MEMORY="$(awk '$3=="kB"{$2=$2/1024**2;$3="GB";} 1' /proc/meminfo | column -t | grep MemTotal | awk '{print $2,$3}')" # Memoria RAM
export OS_VERSION="$(cat /etc/system-release)" 				     # Redhat

export TMP="/tmp"
export TEMP="${TMP}"
export TMPDIR="${TMP}"
export TEMPDIR="${TMP}"
export STAGE_HOME="${HOME}/stage"
export LOGIC="${HOME}/scripts"
export PATH="/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:${HOME}/bin:${LOGIC}"

umask 077

[ ! -x "$(command -v vim)" ] && alias vi='vim'
alias nawk='awk'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias ff='f=`ls -td */ | head -1`; cd $f; ls -ltr'
alias tlf='f="$(find . -type f -exec stat --format '\''%Y%y%n'\'' '\''{}'\'' \; | sort -nr | awk -F / '\''NR==1{print $NF}'\'')"; tail -300f $f'
alias ls='ls --color=none'
alias ltr='ls -ltr'
alias ll='ls -l'

_timestamp() { echo "$(date +"%m%d%Y%H%M%S")"; }
     _date() { echo "$(date +"%m%d%Y")"; }
   profile() { arg="${1}"; . ${HOME}/${SCRIPT_NAME} ${arg}; }


# Java Settings
export JAVA_HOME="/usr/java/jdk1.8.0_251" #"$(readlink -f /usr/bin/java | sed "s:/bin/java::")"
export JRE_HOME="${JAVA_HOME}/jre"
export JAVA_VERSION="$(java -version 2>&1 | awk '/Runtime/')"
export JAVA_ARGS="-XX:-UseGCOverheadLimit -Djava.security.egd=file:/dev/./urandom"
export RIDE_OPTIONS="-d64"

export USER_MEM_ARGS="${USER_MEM_ARGS} -Xms1024m"
export USER_MEM_ARGS="${USER_MEM_ARGS} -Xmx2048m"
export USER_MEM_ARGS="${USER_MEM_ARGS} -XX:PermSize=512m"
export USER_MEM_ARGS="${USER_MEM_ARGS} -XX:MaxPermSize=1024m"
export USER_MEM_ARGS="${USER_MEM_ARGS} -XX:CompileThreshold=16000"
export USER_ARGS="${RIDE_OPTIONS} ${JAVA_ARGS} ${USER_MEM_ARGS}"

export CLASSPATH="${JAVA_HOME}/lib:${JAVA_HOME}/jre/lib"
export PATH="${PATH}:${JRE_HOME}/bin:${CLASSPATH}"

# JBoss EAP
  # export EAP_HOME="/u01/JBoss-EAP-6.4"
  # export JBOSS_HOME="${EAP_HOME}"
  # 
  # export PATH="${PATH}:${EAP_HOME}/bin"

# Weblogic Server
export MIDDLEWARE_HOME="/home/oracle/middleware/wls"
export MD_HOME="${MIDDLEWARE_HOME}"
export MW_HOME="${MD_HOME}"
export WL_HOME="${MD_HOME}/wlserver"
export WLS_HOME="${MD_HOME}/wlserver"
export ADF_HOME="${MD_HOME}/oracle_common"
export ORACLE_HOME="${MD_HOME}"
export ORACLE_BASE="${MD_HOME}"
export DOMAIN_NAME="atg_domain"
export DOMAIN_BASE="${MD_HOME}/user_projects/domains"
export DOMAIN_HOME="${DOMAIN_BASE}/${DOMAIN_NAME}"
export WEBLOGIC_DOMAIN_HOME="${DOMAIN_HOME}"

WEBLOGIC_MEM_ARGS="-Xms1024m -Xmx1024m -XX:PermSize=1024m -XX:MaxPermSize=2048m -XX:CompileThreshold=16000"
WEBLOGIC_JAVA_ARGS="${RIDE_OPTIONS} ${JAVA_ARGS} ${WEBLOGIC_MEM_ARGS}"
# You must add this variable as an argument into $DOMAIN_HOME/startWebLogic.sh script.
export WEBLOGIC_JAVA_ARGS="${WEBLOGIC_JAVA_ARGS} -XX:+UnlockCommercialFeatures -XX:+ResourceManagement"

alias wls='cd ${WLS_HOME}'
alias  dh='cd ${DOMAIN_HOME}'


# Oracle Database
export NLS_LANG="AMERICAN_AMERICA.UTF8"
export LANG="EN_US.UTF-8"
export LC_ALL="C"

export ORACLE_SID="ATGDB"
export ORACLE_BASE="/u01/Oracle"
export ORACLE_HOME="${ORACLE_BASE}/db/12c/dbhome_1"
export TNS_ADMIN="${ORACLE_HOME}/network/admin"
export LD_LIBRARY_PATH="${ORACLE_HOME}/lib:${RETAIL_HOME}/oracle/lib/bin:/usr/lib:${LD_LIBRARY_PATH}"

export PATH="${PATH}:${ORACLE_HOME}/bin:${ORACLE_HOME}/opmn/bin:${ORACLE_HOME}/OPatch:${RETAIL_HOME}/oracle/lib/src"

alias oh='cd ${ORACLE_HOME}'
alias ob='cd ${ORACLE_BASE}'

alias up='${ORACLE_HOME}/bin/sqlplus $UP'
alias tns='cd ${TNS_ADMIN}'
alias tnse='vi ${TNS_ADMIN}/tnsadmin.ora'

function sqldeveloper {
	nohup ${ORACLE_HOME}/sqldeveloper.sh &
}

# Oracle Guided Search
export ENDECA_BASE="/home/oracle/endeca"
export ENDECA_APP_ROOT="${ENDECA_BASE}/Apps"

# MDEX
export ENDECA_MDEX_BASE="${ENDECA_BASE}"
export ENDECA_MDEX_ROOT="${ENDECA_BASE}/MDEX/11.3.2"
export MDEX_INI="${ENDECA_MDEX_ROOT}"

## Platform Services
export ENDECA_CONF="${ENDECA_BASE}/PlatformServices/workspace"
export ENDECA_REFERENCE_DIR="${ENDECA_BASE}/PlatformServices/reference"
export ENDECA_ROOT="${ENDECA_BASE}/PlatformServices/11.3.2.0.0"
export PLATFORM_SERVICES_INI="${ENDECA_ROOT}/setup"
export PLATFORM_SERVICES_WORKSPACE_INI="${ENDECA_CONF}/setup"

## Tools and Framework
export ENDECA_TOOLS_ROOT="${ENDECA_BASE}/ToolsAndFrameworks/11.3.2.0.0"
export ENDECA_TOOLS_CONF="${ENDECA_TOOLS_ROOT}/server/workspace"

## CAS
export CAS_ROOT="${ENDECA_BASE}/CAS/11.3.2.0.0"
export CAS_HOST="172.20.10.5"
export CAS_PORT=8500

export PERL5="${ENDECA_ROOT}/perl"
export PERL5LIB="${PERL5}:${PERL5}/lib/5.8.3"
export UNIXUTILS="${ENDECA_ROOT}/utilities"
export PATH="${PATH}:${ENDECA_MDEX_ROOT}/bin:${PERL5LIB}:${PERL5}/bin:${ENDECA_ROOT}/bin:${ENDECA_ROOT}/j2sdk/jre/bin/server:${UNIXUTILS}"

## Catalina Tomcat Server
CATALINA_OPTS="-Xms512m -Xmx2048m -XX:MaxPermSize=512m"
CATALINA_OPTS="${CATALINA_OPTS} -Dorg.apache.el.parser.SKIP_IDENTIFIER_CHECK=true"
CATALINA_OPTS="${CATALINA_OPTS} -Dcom.endeca.manager.endecaroot=${ENDECA_TOOLS_CONF}"

JAVA_OPTS="${JAVA_OPTS} -XX:CompileCommand=exclude,org/apache/derby/impl/services/locks/LockControl,getLock"
JAVA_OPTS="${JAVA_OPTS} -XX:CompileCommand=exclude,org/apache/derby/impl/services/locks/LockControl,addLock"
JAVA_OPTS="${JAVA_OPTS} -XX:CompileCommand=exclude,org/apache/derby/impl/services/locks/LockControl,isGrantable"
JAVA_OPTS="${JAVA_OPTS} -XX:+UnlockDiagnosticVMOptions"
JAVA_OPTS="${JAVA_OPTS} -XX:-DisplayVMOutput"
JAVA_OPTS="${JAVA_OPTS} -d64"
WORKING_DIR="${ENDECA_TOOLS_CONF}/state"


# Oracle Commerce Platform
export ATG_ROOT="/home/oracle/ATG/ATG11.3.2"
export ATG_HOME="${ATG_ROOT}/home"
export DYNAMO_ROOT="${ATG_ROOT}"
export DYNAMO_HOME="${ATG_HOME}"
export DYNAMO_SERVER_NAME="production"
export DYNAMO_SERVER_HOME="${DYNAMO_HOME}/servers/$DYNAMO_SERVER_NAME"
export ATGJRE="${JAVA_HOME}/bin/java"

# Aliases and functions
alias watchEndeca='ps -fea | grep --color=auto endeca'
alias _stopPlatform='${ENDECA_ROOT}/tools/server/bin/shutdown.sh'
alias _stopTools='${ENDECA_TOOLS_ROOT}/server/bin/shutdown.sh'
alias _stopCAS='${CAS_ROOT}/bin/cas-service-shutdown.sh'

function _startPlatformServices {
	nohup ${ENDECA_ROOT}/tools/server/bin/startup.sh &
}
function _startToolsAndFrameworks {
	#nohup ${ENDECA_TOOLS_ROOT}/server/bin/startup.sh &
	nohup ${ENDECA_TOOLS_ROOT}/server/bin/workbench.sh start &
}
function _startCAS {
	nohup ${CAS_ROOT}/bin/cas-service.sh &
}

function startEndecaService {
	_startPlatformServices
	sleep 2
	_startToolsAndFrameworks
	sleep 2
	_startCAS
}
function stopEndecaService {
	_stopPlatform
	_stopTools
	_stopCAS
}
function startOracleService {
      sudo systemctl start mysqld.service
}
function exportEndeca {
	cd ${ENDECA_APP_ROOT}/control	
	[ -d "./ExportContent" ] || mkdir "./ExportContent"
	
	echo "Cleaning previous export."
	rm -rf "./control/Export*/*" 2&> /dev/null
	
	echo "Exporting application..."
	./runcommand.sh IFCR exportApplication ExportApp

	echo "Exporting legacy content..."
	./runcommand.sh IFCR legacyExportContent "/" ExportContent

	echo "Export configuration..."
	./index_config_cmd.sh get-config -f ExportConfig/CAS.conf
	
	echo "Packing export into \${ENDECA_BASE}/<export-import-dir>"
	tar cvzf ${ENDECA_BASE}/Export-Import-Site/ExportEndeca.$(date +"%Y%d%m").tgz ./Export*

	echo "Export finished successfully..."
	cd ${ENDECA_BASE}/Export-Import-Site
}

function printh { printf "\n%s\n" "${1}";printf "%70s\n" | tr " " -; }
function printv { printf "%-${2:-20}s%s\n" "${1}" "$(eval echo \$${1})"; }
function printa { printf "%-${2:-7}s%s\n" "${1}" "$(echo $( alias ${1} ) | cut -d "=" -f2)"; }

printh "${RETAIL_PROFILE}"
printh "Oracle Database Variables"
printv NLS_LANG
printv LC_ALL
printv LANG
printv ORACLE_SID
printv ORACLE_BASE
printv ORACLE_HOME
printv TNS_ADMIN
printv LD_LIBRARY_PATH

printh "Weblogic Variables"
printv MD_HOME
printv WL_HOME
printv ADF_HOME
printv DOMAIN_NAME
printv DOMAIN_BASE
printv DOMAIN_HOME
printv WEBLOGIC_JAVA_ARGS

printh "Java Variables"
printv JAVA_VERSION
printv RIDE_OPTIONS
printv JAVA_HOME
printv JRE_HOME
printv JAVA_ARGS
printv RIDE_OPTIONS
printv USER_MEM_ARGS

printh "Server Variables"
printv OS_VERSION
printv HOSTNAME
printv RAM_MEMORY
printv PROCESSORS
printv CPU_MHz
printv TMP
printv TMPDIR

printf "\n\n"
