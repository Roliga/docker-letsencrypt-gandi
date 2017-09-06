#!/bin/sh

api='https://dns.api.gandi.net/api/v5'

domain=$(echo "$CERTBOT_DOMAIN" | sed -r 's/.+\.(.+\..+)/\1/')
subdomain=$(echo "$CERTBOT_DOMAIN" | sed -r 's/(.+)\..+\..+/\1/')

curl -s -X DELETE \
	-H 'Content-Type: application/json' \
	-H "X-Api-Key: $GANDI_API_KEY" \
	"$api/domains/$domain/records/_acme-challenge.$subdomain/TXT" >&2
