#!/bin/bash
#To see reference visit page http://docs.aws.amazon.com/AmazonCloudWatch/latest/cli/SetupCLI.html
#CLoudwatch download link http://ec2-downloads.s3.amazonaws.com/CloudWatch-2010-08-01.zip

export JAVA_HOME=/usr/lib/jvm/java-6-openjdk/jre
export PATH=$PATH:$JAVA_HOME/bin
export AWS_CLOUDWATCH_HOME=/root/cloudwatch
export PATH=$PATH:$AWS_CLOUDWATCH_HOME/bin
export AWS_CREDENTIAL_FILE=/root/cloudwatch/credential-file-path
export AWS_CLOUDWATCH_URL='https://monitoring.us-east-1.amazonaws.com'

SERVICES='mysql java'

function service_check {
        SERVICE="$1"
        RESULT=`ps -A | sed -n /${SERVICE}/p`

        if [ "${RESULT:-null}" = null ]; then
                mon-put-data --metric-name ${SERVICE}StatusProd --namespace "MyServices" --value 0
        else
                mon-put-data --metric-name ${SERVICE}StatusProd --namespace "MyServices" --value 1
        fi
}

for service in $SERVICES
do
	service_check $service
done
