#!/bin/bash

# Classpath for Impuls Environment
## pablo.almaguer@logicinfo.com

source ATG_build_classpath.sh

GN_ATG_CLASSPATH="${DYNAMO_ROOT}/GN/Core/lib/classes.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/Core/lib/commons-collections-3.2.1.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/Core/lib/commons-lang3-3.1.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/Core/lib/commons-vfs2-2.0.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/Core/lib/jsch-0.1.54.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/Core/lib/migrationframework.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/Core/lib/opencsv-2.2.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/Core/lib/resources.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/DataMigration/lib/classes.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/Endeca/lib/classes.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/Endeca/lib/resources.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/Integration/ORCE/lib/cardservices.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/Integration/ORCE/lib/classes.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/Integration/ORCE/lib/commons-lang3-3.1.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/Integration/ORCE/lib/customerservices.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/Integration/ORCE/lib/transactionservices.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/Integration/OROB/lib/classes.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/Integration/OROB/lib/commons-lang3-3.1.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/Integration/OROB/lib/locateservices.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/POCFulfillment/lib/classes.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/Service/lib/classes.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/Store/lib/barcode4j.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/Store/lib/cardservices.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/Store/lib/classes.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/Store/lib/commons-validator-1.5.1.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/Store/lib/gson-2.6.2.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/StoreModule/Core/lib/classes.jar"
GN_ATG_CLASSPATH="${GN_ATG_CLASSPATH}:${DYNAMO_ROOT}/GN/StoreModule/Store/lib/classes.jar"

export GN_ATG_CLASSPATH
