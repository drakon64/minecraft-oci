#!/bin/sh

METADATA=$(curl -H "Authorization: Bearer Oracle" -L http://169.254.169.254/opc/v2/instance)
COMPARTMENT_ID=$(echo $METADATA | jq --raw-output .compartmentId)
AVAILABILITY_DOMAIN=$(echo $METADATA | jq --raw-output .availabilityDomain)
FAULT_DOMAIN=$(echo $METADATA | jq --raw-output .faultDomain)
IMAGE_ID=$(echo $METADATA | jq --raw-output .image)
INSTANCE_POOL_ID=$(echo $METADATA | jq --raw-output .instancePoolId)
REGION=$(echo $METADATA | jq --raw-output .region)
RESOURCE_DISPLAY_NAME=$(echo $METADATA | jq --raw-output .displayName)
RESOURCE_ID=$(echo $METADATA | jq --raw-output .id)
SHAPE=$(echo $METADATA | jq --raw-output .shape)

oci --auth instance_principal monitoring metric-data post --metric-data "[
	{
		\"compartmentId\": \"$COMPARTMENT_ID\",
		\"datapoints\": [
			{
				\"timestamp\": \"$(date --iso-8601=seconds)\",
				\"value\": $(df --output=pcent / | grep -v 'Use%' | awk '{print $1}' | tr -d \%)
			}
		],
		\"dimensions\": {
			\"availabilityDomain\": \"$AVAILABILITY_DOMAIN\",
			\"faultDomain\": \"$FAULT_DOMAIN\",
			\"imageId\": \"$IMAGE_ID\",
			\"instancePoolId\": \"$INSTANCE_POOL_ID\",
			\"mount\": \"/\",
			\"region\": \"$REGION\",
			\"resourceDisplayName\": \"$RESOURCE_DISPLAY_NAME\",
			\"resourceId\": \"$RESOURCE_ID\",
			\"shape\": \"$SHAPE\"
		},
		\"metadata\": {
			\"displayName\": \"Disk Utilization\",
			\"maxRange\": \"100\",
			\"minRange\": \"0\",
			\"unit\": \"Percent\"
		},
		\"name\": \"diskUtilization\",
		\"namespace\": \"minecraft\"
	},
	{
		\"compartmentId\": \"$COMPARTMENT_ID\",
		\"datapoints\": [
			{
				\"timestamp\": \"$(date --iso-8601=seconds)\",
				\"value\": $(df --output=pcent /boot/efi | grep -v 'Use%' | awk '{print $1}' | tr -d \%)
			}
		],
		\"dimensions\": {
			\"availabilityDomain\": \"$AVAILABILITY_DOMAIN\",
			\"faultDomain\": \"$FAULT_DOMAIN\",
			\"imageId\": \"$IMAGE_ID\",
			\"instancePoolId\": \"$INSTANCE_POOL_ID\",
			\"mount\": \"/boot/efi\",
			\"region\": \"$REGION\",
			\"resourceDisplayName\": \"$RESOURCE_DISPLAY_NAME\",
			\"resourceId\": \"$RESOURCE_ID\",
			\"shape\": \"$SHAPE\"
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
