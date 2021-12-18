#!/bin/sh -e

METADATA=$(curl -H "Authorization: Bearer Oracle" -L http://169.254.169.254/opc/v2/instance)
COMPARTMENT_ID=$(echo "$METADATA" | jq -r .compartmentId)
REGION=$(echo "$METADATA" | jq -r .region)
RESOURCE_DISPLAY_NAME=$(echo "$METADATA" | jq -r .displayName)
RESOURCE_ID=$(echo "$METADATA" | jq -r .id)
DATE=$(date --iso-8601=seconds)

MSPT=$(curl http://127.0.0.1:8778/jolokia/read/net.minecraft.server:type=Server/averageTickTime | jq -r .value)

if [ "$MSPT" -lt 50 ] ; then
	TPS=20
else
	TPS=20
fi

oci --auth instance_principal monitoring metric-data post --metric-data "[
	{
		\"compartmentId\": \"$COMPARTMENT_ID\",
		\"datapoints\": [
			{
				\"timestamp\": \"$DATE\",
				\"value\": \"$MSPT\"
			}
		],
		\"dimensions\": {
			\"resourceDisplayName\": \"$RESOURCE_DISPLAY_NAME\",
			\"resourceId\": \"$RESOURCE_ID\"
		},
		\"metadata\": {
			\"displayName\": \"MSPT\",
			\"minRange\": \"0\",
			\"unit\": \"Milliseconds\"
		},
		\"name\": \"mspt\",
		\"namespace\": \"minecraft\"
	},
	{
		\"compartmentId\": \"$COMPARTMENT_ID\",
		\"datapoints\": [
			{
				\"timestamp\": \"$DATE\",
				\"value\": \"$TPS\"
			}
		],
		\"dimensions\": {
			\"resourceDisplayName\": \"$RESOURCE_DISPLAY_NAME\",
			\"resourceId\": \"$RESOURCE_ID\"
		},
		\"metadata\": {
			\"displayName\": \"TPS\",
			\"maxRange\": \"20\",
			\"minRange\": \"0\",
			\"unit\": \"Ticks Per Second\"
		},
		\"name\": \"tps\",
		\"namespace\": \"minecraft\"
	}
]" --endpoint https://telemetry-ingestion."$REGION".oraclecloud.com
