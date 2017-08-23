docker-letsencrypt-gandi
========================

This container generates [LetsEncrypt](https://www.letsencrypt.org) certificates for subdomains at [Gandi](https://www.gandi.net) using the DNS-01 challange type and Gandi's new LiveDNS API. It can also send a SIGHUP signal to a [Nginx container](https://store.docker.com/images/nginx) which tells it to reload its certificates.

This image is based on Alpine and uses [Certbot](https://certbot.eff.org/) to communicate with Letsencrypt.

Building
--------

Simply clone this repository and build the image:

	git clone https://github.com/Roliga/docker-letsencrypt-gandi.git
	docker build -t letsencrypt-gandi docker-letsencrypt-gandi

Configuration
-------------

An example configuration file is provided named `config.example`. Copy it somewhere and add your Gandi API key (found under the **Security** section in your Gandi account settings), email address and comma separated list of domain names, and optional Nginx container to tell about new certificates.

The container can then be started as follows:

	docker run -d \
		--restart=always \
		--name letsencrypt-gandi \
		-v /path/to/certs:/etc/letsencrypt \
		-v /path/to/config/file:/etc/update-certs/config:ro \
		-v /var/run/docker.sock:/var/run/docker.sock \
		letsencrypt-gandi

The container will then generate a certificate as it starts, then check if it needs renewing every 5 days. The certificate will be available in `path/to/certs/live/`, in a directory named after the first domain specified in the config file.

Exposing the docker control socket to the container (`-v /var/run/docker.sock:/var/run/docker.sock`) is optional and only required if you want the container to be able to tell Nginx about new certificates.
