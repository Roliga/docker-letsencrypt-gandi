#!/bin/sh

api='https://dns.api.gandi.net/api/v5'

domain=$(echo "$CERTBOT_DOMAIN" | sed -r 's/.+\.(.+\..+)/\1/')
subdomain=$(echo "$CERTBOT_DOMAIN" | sed -r 's/(.+)\..+\..+/\1/')

if [ $subdomain == $domain ]; then
  record_name="_acme-challenge"
else
  record_name="_acme-challenge.$subdomain"
fi

curl -s -X POST \
	-H 'Content-Type: application/json' \
	-H "X-Api-Key: $GANDI_API_KEY" \
	-d "{\"rrset_name\": \"$record_name\",
	     \"rrset_type\": \"TXT\",
	     \"rrset_ttl\": 300,
	     \"rrset_values\": [\"$CERTBOT_VALIDATION\"]}" \
	"$api/domains/$domain/records" | sed 's/{"message": "DNS Record Created"}//' >&2
