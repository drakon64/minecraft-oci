#!/bin/sh -e

METADATA=$(curl -H "Authorization: Bearer Oracle" -L http://169.254.169.254/opc/v2/instance)
COMPARTMENT_ID=$(echo "$METADATA" | jq -r .compartmentId)
REGION=$(echo "$METADATA" | jq -r .region)
RESOURCE_DISPLAY_NAME=$(echo "$METADATA" | jq -r .displayName)
RESOURCE_ID=$(echo "$METADATA" | jq -r .id)

IP=$(oci --auth instance_principal compute instance list-vnics --instance-id "$RESOURCE_ID" --compartment-id "$COMPARTMENT_ID" | jq -r '.data[]."public-ip"')
QUERY=$(curl --silent https://api.mcsrvstat.us/2/"$IP" | jq -r .)
PLAYERS_ONLINE=$(echo "$QUERY" | jq -r .players.online)

if [ "$PLAYERS_ONLINE" -gt 0 ] ; then
	tmux send-keys -t minecraft chunky SPACE pause ENTER
elif [ "$PLAYERS_ONLINE" -eq 0 ] ; then
	tmux send-keys -t minecraft chunky SPACE continue ENTER
fi

oci --auth instance_principal monitoring metric-data post --metric-data "[
	{
		\"compartmentId\": \"$COMPARTMENT_ID\",
		\"datapoints\": [
			{
				\"timestamp\": \"$(date --iso-8601=seconds)\",
				\"value\": \"$PLAYERS_ONLINE\"
			}
		],
		\"dimensions\": {
			\"mount\": \"/\",
			\"resourceDisplayName\": \"$RESOURCE_DISPLAY_NAME\",
			\"resourceId\": \"$RESOURCE_ID\"
		},
		\"metadata\": {
			\"displayName\": \"Players\",
			\"maxRange\": \"$(echo "$QUERY" | jq -r .players.max)\",
			\"minRange\": \"0\",
			\"unit\": \"Percent\"
		},
		\"name\": \"playerCount\",
		\"namespace\": \"minecraft\"
	}
]" --endpoint https://telemetry-ingestion."$REGION".oraclecloud.com
