#!/bin/sh

api='https://dns.beta.gandi.net/api/v5'

domain=$(echo "$CERTBOT_DOMAIN" | sed -r 's/.+\.(.+\..+)/\1/')
subdomain=$(echo "$CERTBOT_DOMAIN" | sed -r 's/(.+)\..+\..+/\1/')

curl -s -X POST \
	-H 'Content-Type: application/json' \
	-H "X-Api-Key: $GANDI_API_KEY" \
	-d "{\"rrset_name\": \"_acme-challenge.$subdomain\",
	     \"rrset_type\": \"TXT\",
	     \"rrset_ttl\": 300,
	     \"rrset_values\": [\"$CERTBOT_VALIDATION\"]}" \
	"$api/domains/$domain/records" | sed 's/{"message": "DNS Record Created"}//' >&2
