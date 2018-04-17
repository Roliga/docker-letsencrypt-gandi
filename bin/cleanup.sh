#!/bin/sh

api='https://dns.api.gandi.net/api/v5'

domain=$(echo "$CERTBOT_DOMAIN" | sed -r 's/.+\.(.+\..+)/\1/')
subdomain=$(echo "$CERTBOT_DOMAIN" | sed -r 's/(.+)\..+\..+/\1/')

if [ $subdomain == $domain ]; then
  record_name="_acme-challenge"
else
  record_name="_acme-challenge.$subdomain"
fi

curl -s -X DELETE \
	-H 'Content-Type: application/json' \
	-H "X-Api-Key: $GANDI_API_KEY" \
	"$api/domains/$domain/records/$record_name/TXT" >&2
