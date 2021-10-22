# Oracle Retail Workstation v16

- [Oracle Retail Workstation v16](#oracle-retail-workstation-v16)
  - [Oracle Database Enterprise](#oracle-database-enterprise)
    - [System Parameters](#system-parameters)
    - [Schema Profile](#schema-profile)
  - [Fusion Middleware Domain](#fusion-middleware-domain)
    - [Templates](#templates)
    - [Administrator Server](#administrator-server)
    - [Repository Components](#repository-components)
    - [Node Manager](#node-manager)
    - [Topology](#topology)
      - [__Managed Servers__](#managed-servers)
      - [__Server Templates__](#server-templates)
      - [__Cohherence Clusters__](#cohherence-clusters)
      - [__Machines (Unix)__](#machines-unix)
      - [__Deployment Targeting__](#deployment-targeting)
      - [__Services Targeting__](#services-targeting)
  - [Retail Merchandise System (RMS)](#retail-merchandise-system-rms)
    - [RMS Tablespaces (Required)](#rms-tablespaces-required)
    - [Schema Owner for RMS](#schema-owner-for-rms)
    - [RMS Installation](#rms-installation)
    - [MOM Installation Steps](#mom-installation-steps)
      - [Component Selection](#component-selection)
    - [Database Component Selection](#database-component-selection)
    - [Full or Patch](#full-or-patch)

<br/><br/>


## Oracle Database Enterprise
### System Parameters
```sql
alter system set processes=1500 scope=spfile;

alter system set open_cursors=900 scope=spfile;
```

### Schema Profile
```sql
alter profile default limit password_life_time unlimited;

alter profile default limit failed_login_attempts unlimited;
```



## Fusion Middleware Domain
### Templates
 * Oracle Enterprise Manager [em]
 * Oracle WSM Policy Manager [oracle_common]
 * Oracle JRF [oracle_common]
 * Weblogic Coherence Cluster Extension [wlserver]

<br/>

### Administrator Server
__server_name__: _AdminServer_  
__server_port__: _7001_  
__server_group__: _JRF-MAN-SVR_  
__credentials:__ _weblogic/Orawls12c_  

<br/>

### Repository Components
__prefix:__ _MOM16_  
__password:__ _Oretail16_

<br/>

### Node Manager
__credentials:__ _nodemanager/Orawls12c_  
__port:__ _5556_  

<br/>

### Topology
#### __Managed Servers__
| Server Name              | Port | Server Groups |
|--------------------------|------|---------------|
| rms-server               | 7101 | JRF-MAN-SVR   |
| resa-server              | 7102 | JRF-MAN-SVR   |
| reim-server              | 7103 | JRF-MAN-SVR   |
| rpm-server               | 7104 | JRF-MAN-SVR   |
| alloc-server             | 7105 | JRF-MAN-SVR   |
| sim-server               | 7106 | JRF-MAN-SVR   |
| rib-func-artifact-server | 7200 | JRF-MAN-SVR   |
| rib-tafr-server          | 7201 | JRF-MAN-SVR   |
| rib-riha-server          | 7202 | JRF-MAN-SVR   |
| rib-igs-server           | 7203 | JRF-MAN-SVR   |
| rib-rms-server           | 7211 | JRF-MAN-SVR   |
| rib-rpm-server           | 7212 | JRF-MAN-SVR   |
| rib-sim-server           | 7213 | JRF-MAN-SVR   |
| rsb-http-proxy           | 7300 | JRF-MAN-SVR   |
| rsb-server-1             | 7301 | JRF-MAN-SVR   |

<br/>

#### __Server Templates__
| Name                      | Listen Port | SSL Port | Enable SSL | 
|---------------------------|-------------|----------|------------|
| wsm-cache-server-template | 7100        | 8100     | false      |
| wsmpm-server-template     | 7100        | 8100     | false      |

#### __Cohherence Clusters__
| Cluster Name            | Cluster Listen Port |
|-------------------------|---------------------|
| defaultCoherenceCluster | 7574                |

#### __Machines (Unix)__
| Name            | Node Manager Listen Address | Node Manager |
|-----------------|-----------------------------|--------------|
| retail-machine  | vik2sen-oel                 | 5556         |

>_Assign __all__ servers to the machine_

<br/>

#### __Deployment Targeting__
From Deployments side, add the _opss-rest_ and _wsm-pm_ deployments from the _AppDeployment_ to each managed server in the DeploymentTargets side.

#### __Services Targeting__
From Services side, add the _mds-owsm_ from the _JDBCSystemResource_ service to each managed server in the DeploymentTargets side.

<br/>

----------

## Retail Merchandise System (RMS)

### RMS Tablespaces (Required)
  * REAIL_DATA
  * REAIL_INDEX
  * ENCRYPTED_RETAIL_DATA
  * ENCRYPTED_RETAIL_INDEX

<br/>

Modify all the &lt;datafile_path&gt; and data file storage params and sizes based on partitioning strategy in the following files:
  * `STAGING_DIR/rms/installer/create_db/create_rms_tablespaces.sql`
  * `STAGING_DIR/rms/installer/create_db/create_encrypted_tablespaces_no_TDE.sql`

```bash
file=${STAGING_DIR}/rms/installer/create_db/create_rms_tablespaces.sql
file=${STAGING_DIR/}rms/installer/create_db/create_encrypted_tablespaces_no_TDE.sql

sed -i "s/RETAIL_index04/retail_index04/g" $file
sed -i "s+<datafile_path>+${ORACLE_BASE}/oradata/RETAIL+g" $file
sed -i "s/MAXSIZE 2000M/MAXSIZE 5000M/g" $file
sed -i "s/SIZE 500M/SIZE 1000M/g" $file
sed -i "s/SIZE 50M/SIZE 200M/g" $file
sed -i "s/SIZE 100M/SIZE 500M/g" $file

sqlplus / as sysdba @$file
```

### Schema Owner for RMS

```bash

script_dir="$STAGING_DIR/rms/installer/create_db"
sql="sqlplus / as sysdba"

${sql} @${script_dir}/create_roles.sql
${sql} @${script_dir}/create_user.sql
${sql} @${script_dir}/create_bdi_int_user.sql   
${sql} @${script_dir}/create_bdi_infr_user.sql
${sql} @${script_dir}/create_user_generic.sql

```

__Credentials__

| Schema Owner   | Schema Pasword | Temporal Tablespace |
|----------------|----------------|---------------------|
| RMS16          | Oretail16      | TEMP                |
| ALLOC16        | Oretail16      | TEMP                |
| RMS16DEMO      | Oretail16      | TEMP                |
| BDI_RMS16_INT  | Oretail16      | TEMP                |
| BDI_RMS16_INFR | Oretail16      | TEMP                |

<br/>

### RMS Installation
It is recommended, but not required, that the Schema and Batch installation be done at the same time and use the same path for _RETAIL_HOME_.
> Verify the _ORACLE_HOME_ and _ORACLE_SID_ variables after running the installation,

```bash
# Examples
JAVA_HOME=/usr/java/jdk1.8.64bit; export JAVA_HOME
NLS_LANG=AMERICAN_AMERICA.AL32UTF8; export NLS_LANG
ANT_HOME=${STAGING_DIR}/rms/installer/mom/Build/orpatch/deploy/ant; export ANT_HOME

PATH=${PATH}:${ANT_HOME}/bin; export PATH

find ${STAGING_DIR}/rms/installer -name preinstall.sh -exec chmod +x '{}' \;
chmod +x ${ANT_HOME}/bin/ant
chmod +x ${STAGING_DIR}/rms/installer/install.sh

# For RMS Batch installation
find ${STAGING_DIR}/rms/installer -name demo_rdbms.mk -exec cp '{}' ${ORACLE_HOME}/rdbms/demo \;
```

For the Batch Installation, you must check the following notes:
> Refer to the following Oracle Support note if the operating system platform is Linux: <br>__DocID 102288.1 – *Precompiling Sample Pro\*C Programs on Linux Fails with PCC-02015 and PCC-02201*__

Look for the _pcscfg.cfg_ located in `${ORACLE_HOME}/precomp/admin/pcscfg.cfg` and compare the paths to that the Linux OS has. You can check this by running the next command:  
```bash 
bash$ cpp -v /dev/null -o /dev/null
-------------------------------
# Output from the above command will look something like:

Using built-in specs.
COLLECT_GCC=cpp
OFFLOAD_TARGET_NAMES=nvptx-none
OFFLOAD_TARGET_DEFAULT=1
Target: x86_64-redhat-linux
Configured with: ../configure --enable-bootstrap --enable-languages=c,c++,fortran,lto --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-bugurl=http://bugzilla.redhat.com/bugzilla --enable-shared --enable-threads=posix --enable-checking=release --enable-multilib --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-id --with-gcc-major-version-only --with-linker-hash-style=gnu --enable-plugin --enable-initfini-array --with-isl --disable-libmpx --enable-offload-targets=nvptx-none --without-cuda-driver --enable-gnu-indirect-function --enable-cet --with-tune=generic --with-arch_32=x86-64 --build=x86_64-redhat-linux
Thread model: posix
gcc version 8.4.1 20200928 (Red Hat 8.4.1-1.0.4) (GCC)
COLLECT_GCC_OPTIONS='-E' '-v' '-o' '/dev/null' '-mtune=generic' '-march=x86-64'
 /usr/libexec/gcc/x86_64-redhat-linux/8/cc1 -E -quiet -v /dev/null -o /dev/null -mtune=generic -march=x86-64
ignoring nonexistent directory "/usr/lib/gcc/x86_64-redhat-linux/8/include-fixed"
ignoring nonexistent directory "/usr/lib/gcc/x86_64-redhat-linux/8/../../../../x86_64-redhat-linux/include"
#include "..." search starts here:
#include <...> search starts here:
 /usr/lib/gcc/x86_64-redhat-linux/8/include
 /usr/local/include
 /usr/include
End of search list.
COMPILER_PATH=/usr/libexec/gcc/x86_64-redhat-linux/8/:/usr/libexec/gcc/x86_64-redhat-linux/8/:/usr/libexec/gcc/x86_64-redhat-linux/:/usr/lib/gcc/x86_64-redhat-linux/8/:/usr/lib/gcc/x86_64-redhat-linux/
LIBRARY_PATH=/usr/lib/gcc/x86_64-redhat-linux/8/:/usr/lib/gcc/x86_64-redhat-linux/8/../../../../lib64/:/lib/../lib64/:/usr/lib/../lib64/:/usr/lib/gcc/x86_64-redhat-linux/8/../../../:/lib/:/usr/lib/
COLLECT_GCC_OPTIONS='-E' '-v' '-o' '/dev/null' '-mtune=generic' '-march=x86-64'
-------------------------------
```


Run the `${STAGING_DIR}/rms/installer/install.sh` script to start the installation in GUI mode. You must see a log like this:
```log
*********************************************
  Checking environment for RMS installation
*********************************************

Verified NLS_LANG: AMERICAN_AMERICA.UTF8

JAVA_HOME=/opt/java/jdk1.8.0_311
Verified Java version 1.7.0.x or greater. Java version: 1.8.0

ANT_HOME=/u01/stage/mom16/rms16//rms/installer/mom/Build/orpatch/deploy/ant
Verified Ant version 1.9.6.x or greater. Ant version: 1.10.5

**************************************************
  Checking environment for Database installation
**************************************************

Verified Java version 1.7.0.x or greater. Java version: 1.8.0
JAVA_HOME=/opt/java/jdk1.8.0_311
Verified $ORACLE_HOME.
Verified ORACLE_SID: RETAIL
Verified write permissions
Verified SQL*Plus exists
Verified sqlldr exists
Running tnsping to get listener port

This Oracle Retail product will be installed using the following environment settings:
ORACLE_HOME=/u01/app/product/12c/dbhome_1
ORACLE_SID=RETAIL

Database environment check successful

***********************************************
  Checking environment for Batch installation
***********************************************

Verified $ORACLE_HOME.
Verified ORACLE_SID: RETAIL
Verified demo_rdbms.mk exists.
Verified write permissions.
Verified Java version 1.7.0.x or greater. Java version: 1.8.0
JAVA_HOME=/opt/java/jdk1.8.0_311
Verified make: /usr/bin/make.
Verified makedepend: /usr/bin/makedepend.
Verified cc: /usr/bin/cc.
Verified ar: /usr/bin/ar.
Verified ANSI compliance.

Batch environment check successful

*****************************************************
  Checking environment for WLS J2EE installation
*****************************************************


WLS J2EE environment check successful

***************************
  Final preinstall status
***************************

Database Preinstall Check:    SUCCESS

Batch Preinstall Check:       SUCCESS

WLS J2EE Preinstall Check:    SUCCESS
```


### MOM Installation Steps
#### Component Selection
  * Install Database Objects 
  * Install Batch            
  * Install Application      

### Database Component Selection
  * RMS/RPM
  * ReIM
  * Allocation
  * ~~RMS DAS Schema~~

### Full or Patch
  * Full
  * ~~Patch~~

hostname: vik2sen-oel  
Secure JDBC Connection: false  
RMS JDBC URL: jdbc:oracle:thin:@//vik2sen-oel:1521/RETAIL  
RMS Schema Security Alias: dsRMS16Alias  
RMS INT Schema Security Alias: dsRMS16BDIIntAlias  
RMS INFT Schema Security Alias: dsRMS16BDIInfrAlias  
Alloc Schema Security Alias: dsAlloc16Alias  
Primary Country: MEXICO (MX)  
Primary Currency: Mexico Peso (MXN)  
Primary Language: English (en)  
Default Tax Type: SVAT  
Class-Level VAT: Enable  
Calendar Type: 454 Calendar  
Week Start-End: Mon-Sun  
HTS Tracking Level: Country of Manufacturer  
Data Level Security: Disabled  

RMS Demo Data: True  
ReIM Demo Data: True  
Demo Data Schema Security Alias: dsDemoData16Alias  
Number of demo items: 20
Transaction Level: 2 (Line Extension)