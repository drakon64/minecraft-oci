#!/bin/sh

oci dns record zone patch --auth instance_principal --zone-name-or-id "[
	{
		\"domain\": \"$CERTBOT_DOMAIN\",
		\"rdata\": \"$CERTBOT_VALIDATION\",
		\"rtype\": \"TXT\",
		\"ttl\": 300
	}
]"
