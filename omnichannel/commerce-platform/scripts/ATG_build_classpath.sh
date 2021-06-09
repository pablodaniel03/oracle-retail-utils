#!/bin/bash

# Classpath for ATG Environment
## pablo.almaguer@logicinfo.com

source ../env/ATG11.2_Environment.sh

### Linux Classpath
ATG_CLASSPATH="${ATG_HOME}/Agent/ExternalUsers/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/Agent/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/AssetUI/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/BCC/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/BCC/lib/commons-fileupload-1.3.1.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/BCC/lib/commons-io-2.4.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/BCC/lib/commons-lang-2.5.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/BCC/Versioned/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/BIZUI/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/CAF11.2/CAF/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/CAF11.2/CAF/lib/jfreechart/jcommon-0.9.3.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/CAF11.2/CAF/lib/jfreechart/jfreechart-0.9.18.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/CAF11.2/CAF/lib/jfreechart/log4j-1.2.17.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/ContentMgmt/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/CSC-UI11.2/DCS-CSR-UI/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/CSC11.2/DCS-CSR/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/CSC11.2/DCS-CSR/Management/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DAF/Endeca/Assembler/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DAF/Endeca/Assembler/lib/endeca_assembler_core-11.2.0.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DAF/Endeca/Assembler/lib/endeca_assembler_navigation-11.2.0.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DAF/Endeca/Assembler/lib/endeca_navigation-6.5.2.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DAF/Endeca/Base/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DAF/Endeca/Index/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DAF/Search/Base/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DAF/Search/Base/lib/rmi-stub-classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DAF/Search/common/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DAF/Search/Index/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DAF/TextSearch/Base/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DAF/TextSearch/Index/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DAF/TextSearch/LiveIndex/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DafEar/base/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DafEar/JBoss/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DafEar/Tomcat/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DafEar/WebLogic/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DafEar/WebSphere/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DAS-UI/lib/jhall.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DAS-UI/lib/uiclasses.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DAS-UI/lib/uiresources.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DAS/lib/cglib-nodep-2.1_3.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DAS/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DAS/lib/ice.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DAS/lib/jline-0.9.94.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DAS/lib/jsp-api.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DAS/lib/resources.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DAS/lib/servlet.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DAS/lib/spring-aop-1.2-rc1.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DAS/lib/validation-api-1.0.0.GA.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DCS/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DCS/lib/resources.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DPS-UI/AccessControl/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DPS-UI/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DPS/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DPS/lib/resources.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DSS/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/DSS/lib/resources.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/FlexUI/lib/backport-util-concurrent-2.2.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/FlexUI/lib/cfgatewayadapter-3.2.0.3978.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/FlexUI/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/FlexUI/lib/commons-codec-1.3.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/FlexUI/lib/concurrent-1.3.3.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/FlexUI/lib/flex-messaging-3.2.0.3978.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/FlexUI/lib/httpclient-4.2.5.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/FlexUI/lib/httpcore-4.2.4.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/Publishing/base/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/PublishingAgent/base/lib/agent.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/PublishingAgent/base/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/PubPortlet/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/REST/lib/atg-rest-1.0.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/REST/lib/commons-fileupload-1.3.1.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/REST/lib/commons-io-2.4.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/REST/lib/dom4j-1.6.1.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/REST/lib/org.json.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/RL/lib/RLClient.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/Service-UI11.2/Service-UI/Framework/Agent/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/Service11.2/Service/Framework/Agent/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/Service11.2/Service/Framework/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/Service11.2/Service/Framework/lib/ssce.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/Service11.2/Service/Framework/UI/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/Service11.2/Service/Response/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/Service11.2/Service/Ticketing/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/Ticketing/lib/ticketing.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/WebUI/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/WebUI/Preview/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ATG_HOME}/WebUI/Preview/Versioned/lib/classes.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ANT_HOME}/lib/ant-antlr.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ANT_HOME}/lib/ant-apache-bcel.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ANT_HOME}/lib/ant-apache-bsf.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ANT_HOME}/lib/ant-apache-log4j.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ANT_HOME}/lib/ant-apache-oro.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ANT_HOME}/lib/ant-apache-regexp.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ANT_HOME}/lib/ant-apache-resolver.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ANT_HOME}/lib/ant-apache-xalan2.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ANT_HOME}/lib/ant-commons-logging.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ANT_HOME}/lib/ant-commons-net.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ANT_HOME}/lib/ant-jai.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ANT_HOME}/lib/ant-javamail.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ANT_HOME}/lib/ant-jdepend.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ANT_HOME}/lib/ant-jmf.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ANT_HOME}/lib/ant-jsch.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ANT_HOME}/lib/ant-junit.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ANT_HOME}/lib/ant-junit4.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ANT_HOME}/lib/ant-launcher.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ANT_HOME}/lib/ant-netrexx.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ANT_HOME}/lib/ant-swing.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ANT_HOME}/lib/ant-testutil.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ANT_HOME}/lib/ant.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${WLS_HOME}/server/lib/weblogic.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ECLIPSE_HOME}/configuration/org.eclipse.osgi/79/0/.cp/lib/antdebug.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ECLIPSE_HOME}/configuration/org.eclipse.osgi/79/0/.cp/lib/remote.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ECLIPSE_HOME}/configuration/org.eclipse.osgi/80/0/.cp/lib/remoteAnt.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${ECLIPSE_HOME}/plugins/org.eclipse.swt.win32.win32.x86_64_3.104.2.v20160212-1350.jar"
ATG_CLASSPATH="${ATG_CLASSPATH}:${JAVA_HOME}/lib/tools.jar"

export ATG_CLASSPATH