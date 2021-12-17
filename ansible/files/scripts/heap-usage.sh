#!/bin/sh

METADATA=$(curl -H "Authorization: Bearer Oracle" -L http://169.254.169.254/opc/v2/instance)
COMPARTMENT_ID=$(echo "$METADATA" | jq --raw-output .compartmentId)
AVAILABILITY_DOMAIN=$(echo "$METADATA" | jq --raw-output .availabilityDomain)
FAULT_DOMAIN=$(echo "$METADATA" | jq --raw-output .faultDomain)
IMAGE_ID=$(echo "$METADATA" | jq --raw-output .image)
INSTANCE_POOL_ID=$(echo "$METADATA" | jq --raw-output .instancePoolId)
REGION=$(echo "$METADATA" | jq --raw-output .region)
RESOURCE_DISPLAY_NAME=$(echo "$METADATA" | jq --raw-output .displayName)
RESOURCE_ID=$(echo "$METADATA" | jq --raw-output .id)
SHAPE=$(echo "$METADATA" | jq --raw-output .shape)

oci --auth instance_principal monitoring metric-data post --metric-data "[
	{
		\"compartmentId\": \"$COMPARTMENT_ID\",
		\"datapoints\": [
			{
				\"timestamp\": \"$(date --iso-8601=seconds)\",
				\"value\": $(jhsdb jmap --heap --pid "$(jps | grep server.jar)" | grep "%" | head -n 1 | sed "s/^[[:space:]]*//g" | sed "s/ used//")
			}
		],
		\"dimensions\": {
			\"availabilityDomain\": \"$AVAILABILITY_DOMAIN\",
			\"faultDomain\": \"$FAULT_DOMAIN\",
			\"imageId\": \"$IMAGE_ID\",
			\"instancePoolId\": \"$INSTANCE_POOL_ID\",
			\"region\": \"$REGION\",
			\"resourceDisplayName\": \"$RESOURCE_DISPLAY_NAME\",
			\"resourceId\": \"$RESOURCE_ID\",
			\"shape\": \"$SHAPE\"
		},
		\"metadata\": {
			\"displayName\": \"Heap Usage\",
			\"maxRange\": \"100\",
			\"minRange\": \"0\",
			\"unit\": \"Percent\"
		},
		\"name\": \"heapUsage\",
		\"namespace\": \"minecraft\"
	}
]" --endpoint https://telemetry-ingestion."$REGION".oraclecloud.com
