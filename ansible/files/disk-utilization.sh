#!/bin/sh

METADATA=$(curl -H "Authorization: Bearer Oracle" -L http://169.254.169.254/opc/v2/instance)
REGION=$(echo $METADATA | jq --raw-output .region)

oci --auth instance_principal monitoring metric-data post --metric-data "[
	{
		\"compartmentId\": \"$(echo $METADATA | jq --raw-output .compartmentId)\",
		\"datapoints\": [
			{
				\"timestamp\": \"$(date --iso-8601=seconds)\",
				\"value\": $(df --output=pcent / | grep -v 'Use%' | awk '{print $1}' | tr -d \%)
			}
		],
		\"dimensions\": {
			\"availabilityDomain\": \"$(echo $METADATA | jq --raw-output .availabilityDomain)\",
			\"faultDomain\": \"$(echo $METADATA | jq --raw-output .faultDomain)\",
			\"imageId\": \"$(echo $METADATA | jq --raw-output .image)\",
			\"instancePoolId\": \"$(echo $METADATA | jq --raw-output .instancePoolId)\",
			\"region\": \"$REGION\",
			\"resourceDisplayName\": \"$(echo $METADATA | jq --raw-output .displayName)\",
			\"resourceId\": \"$(echo $METADATA | jq --raw-output .id)\",
			\"shape\": \"$(echo $METADATA | jq --raw-output .shape)\"
		},
		\"metadata\": {
			\"displayName\": \"Disk Utilization\",
			\"maxRange\": \"100\",
			\"minRange\": \"0\",
			\"unit\": \"Percent\"
		},
		\"name\": \"diskUtilization\",
		\"namespace\": \"minecraft\"
	}
]" --endpoint https://telemetry-ingestion.$REGION.oraclecloud.com
