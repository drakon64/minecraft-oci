#!/bin/sh

oci dns record zone patch --auth instance_principal --zone-name-or-id "$CERTBOT_DOMAIN" --items "[
	{
		\"domain\": \"_acme-challenge.$CERTBOT_DOMAIN\",
		\"operation\": \"REMOVE\"
	}
]"

oci dns record zone patch --auth instance_principal --zone-name-or-id "$CERTBOT_DOMAIN" --items "[
	{
		\"domain\": \"_acme-challenge.$CERTBOT_DOMAIN\",
		\"rdata\": \"$CERTBOT_VALIDATION\",
		\"rtype\": \"TXT\",
		\"ttl\": 1
	}
]"

sleep 30
