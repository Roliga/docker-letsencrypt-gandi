#!/bin/sh

if [ -n "$NGINX_CONTAINER" ] && [ -S '/var/run/docker.sock' ]; then
	curl -s -X POST --unix-socket /var/run/docker.sock \
		"http://v1.30/containers/$NGINX_CONTAINER/kill?signal=SIGHUP" >&2
fi
