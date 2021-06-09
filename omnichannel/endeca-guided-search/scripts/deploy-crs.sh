#!/bin/bash
# Created by Pablo Almaguer

function logger {
    
    printf 
}

echo "Deploying ATG Commerce Reference Store in Endeca"
echo "----------------------------------------------------------------------------------------------------"
echo ""
echo "\${ENDECA_TOOLS_ROOT}/deployment_template/bin/deploy.sh --app \${ATG_HOME}/CommerceReferenceStore/Store/Storefront/deploy/deploy.xml \\"
echo "                                                        --install-config \${ATG_HOME}/CommerceReferenceStore/Store/Storefront/deploy/deploy-prompt.xml"
echo ""