#!/bin/sh -e

oci dns record zone patch --auth instance_principal --zone-name-or-id "$CERTBOT_DOMAIN" --items "[
	{
		\"domain\": \"_acme-challenge.$CERTBOT_DOMAIN\",
		\"operation\": \"REMOVE\"
	}
]"
