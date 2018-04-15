#!/bin/sh

. /etc/update-certs/config

while true; do
	certbot certonly --manual \
		--expand \
		--agree-tos \
		--manual-public-ip-logging-ok \
		--no-eff-email \
		--non-interactive \
		--preferred-challenges=dns \
		--manual-auth-hook authenticate.sh \
		--manual-cleanup-hook cleanup.sh \
		--post-hook reload-nginx.sh \
		--email "$EMAIL" \
		-d "$DOMAINS" \
		--server https://acme-v02.api.letsencrypt.org/directory
		"$@"

	sleep 5d
done
