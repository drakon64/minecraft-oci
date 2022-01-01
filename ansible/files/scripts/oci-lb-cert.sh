#!/bin/sh

METADATA=$(curl -H "Authorization: Bearer Oracle" -L http://169.254.169.254/opc/v2/instance/)
COMPARTMENT_ID=$(echo "$METADATA" | jq -r .compartmentId)
LOAD_BALANCER_ID=$(oci lb load-balancer list --auth instance_principal --compartment-id "$COMPARTMENT_ID" --display-name bluemap | jq -r .data[].id)
CERTIFICATES=$(oci lb certificate list --auth instance_principal --load-balancer-id "$LOAD_BALANCER_ID" | jq -r '.data[]."certificate-name"')
DATE=$(date --iso-8601)

oci lb certificate create --auth instance_principal --certificate-name "bluemap-$DATE" --load-balancer-id "$LOAD_BALANCER_ID" --private-key-file "$RENEWED_LINEAGE/privkey.pem" --public-certificate-file "$RENEWED_LINEAGE/fullchain.pem" --wait-for-state SUCCEEDED --wait-for-state FAILED || exit 1

oci lb listener update --auth instance_principal --cipher-suite-name oci-default-http2-ssl-cipher-suite-v1 --force --default-backend-set-name bluemap --listener-name bluemap --load-balancer-id "$LOAD_BALANCER_ID" --port 443 --protocol HTTP2 --ssl-certificate-name "bluemap-$DATE" --wait-for-state SUCCEEDED --wait-for-state FAILED || exit 1

if [ -n "$CERTIFICATES" ] ; then
	for i in $CERTIFICATES ; do
		oci lb certificate delete --certificate-name "$i" --load-balancer-id "$LOAD_BALANCER_ID" || exit 1
	done
fi
