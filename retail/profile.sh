#!/bin/bash

umask 013

# Linux Settings
if [[ "$SHELL" =~ .*ksh.* ]]; then
   export PS1='$(print -n "`logname`@`hostname`:";if [[ "${PWD#$HOME}" != "$PWD" ]] then; print -n "~${PWD#$HOME}"; else; print -n "${PWD##*/}";fi;print " $ ")'
fi
export HOSTNAME="$(uname -n)"
export PROCESSORS="$(lscpu | sed -ne '4s/^[^ ]* *//p')"          # Numero de Procesadores
export CPU_MHz="$(lscpu | grep "CPU MHz" | awk '{print $3}')"    # Velocidad de Procesadores
export RAM_MEMORY="$(awk '$3=="kB"{$2=$2/1024**2;$3="GB";} 1' /proc/meminfo | column -t | grep MemTotal | awk '{print $2,$3}')" # Memoria RAM
export OS_VERSION="$(cat /etc/system-release)" 				     # Redhat

export OLDPATH=${PATH}
export PATH="${HOME}/.local/bin:${HOME}/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/var/lib/snapd/snap/bin"

export TMP="/tmp"
export TEMP="${TMP}"
export TMPDIR="${TMP}"
export TEMPDIR="${TMP}"

[ ! -x "$(command -v vim)" ] && alias vi='vim'
alias nawk='awk'
alias ff='f=`ls -td */ | head -1`; cd $f; ls -ltr'
alias tlf='f="$(find . -type f -exec stat --format '\''%Y%y%n'\'' '\''{}'\'' \; | sort -nr | awk -F / '\''NR==1{print $NF}'\'')"; tail -300f $f'
alias ls='ls --color=none'
alias ltr='ls -ltr'
alias ll='ls -l'


_timestamp() { echo "$(date +"%m%d%Y%H%M%S")"; }
reload() {
    source /u02/profile.sh $@
}
backup() {
  usage="backup [file.txt]|[folder]"
  timestamp="$(_timestamp)"
  [ -n "$1" ] && f="$1" || echo "$usage"
  mv "${f}" "${f}.${timestamp}" 
}

# Java Variables
export JAVA_HOME="$(readlink -f /usr/bin/java | sed "s:/bin/java::")"
export JRE_HOME="${JAVA_HOME}/jre"
export JAVA_VERSION="$(java -version 2>&1 | awk '/Runtime/')"
export JAVA_ARGS="-Djava.security.egd=file:/dev/./urandom -Xms512m -Xmx2049m -XX:MaxPermSize=1024m"
export CLASSPATH="${JAVA_HOME}/lib:${JAVA_HOME}/jre/lib"
export RIDE_OPTIONS="-d64"
export PATH="${PATH}:${JAVA_HOME}/bin:${JRE_HOME}/bin:${CLASSPATH}"

alias jh='cd ${JAVA_HOME}'

STAGING_DIR=/u01/stage
alias stg='cd ${STAGING_DIR}'

PROFILE="Oracle Linux"
if [ "$1" = "db" ]; then     source /u02/db.env
elif [ "$1" = "wls" ]; then  source /u02/wls.env
fi

echo
echo ================================================
echo " $PROFILE" Profile
echo ================================================
echo


export RETAIL_HOME="/u01/retail_home"