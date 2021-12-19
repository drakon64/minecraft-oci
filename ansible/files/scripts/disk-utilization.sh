#!/bin/sh

METADATA=$(curl -H "Authorization: Bearer Oracle" -L http://169.254.169.254/opc/v2/instance)
COMPARTMENT_ID=$(echo $METADATA | jq --raw-output .compartmentId)
REGION=$(echo $METADATA | jq --raw-output .region)
RESOURCE_DISPLAY_NAME=$(echo $METADATA | jq --raw-output .displayName)
RESOURCE_ID=$(echo $METADATA | jq --raw-output .id)
DATE=$(date --iso-8601=seconds)

oci --auth instance_principal monitoring metric-data post --metric-data "[
	{
		\"compartmentId\": \"$COMPARTMENT_ID\",
		\"datapoints\": [
			{
				\"timestamp\": \"$DATE\",
				\"value\": $(df --output=pcent / | grep -v 'Use%' | awk '{print $1}' | tr -d \%)
			}
		],
		\"dimensions\": {
			\"resourceDisplayName\": \"$RESOURCE_DISPLAY_NAME\",
			\"resourceId\": \"$RESOURCE_ID\"
		},
		\"metadata\": {
			\"displayName\": \"Root Disk Utilization\",
			\"maxRange\": \"100\",
			\"minRange\": \"0\",
			\"unit\": \"Percent\"
		},
		\"name\": \"rootDiskUtilization\",
		\"namespace\": \"minecraft\"
	},
	{
		\"compartmentId\": \"$COMPARTMENT_ID\",
		\"datapoints\": [
			{
				\"timestamp\": \"$DATE\",
				\"value\": $(df --output=pcent /boot/efi | grep -v 'Use%' | awk '{print $1}' | tr -d \%)
			}
		],
		\"dimensions\": {
			\"resourceDisplayName\": \"$RESOURCE_DISPLAY_NAME\",
			\"resourceId\": \"$RESOURCE_ID\"
		},
		\"metadata\": {
			\"displayName\": \"EFI Disk Utilization\",
			\"maxRange\": \"100\",
			\"minRange\": \"0\",
			\"unit\": \"Percent\"
		},
		\"name\": \"efiDiskUtilization\",
		\"namespace\": \"minecraft\"
	}
]" --endpoint https://telemetry-ingestion.$REGION.oraclecloud.com
