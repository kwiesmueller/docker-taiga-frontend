FROM nginx
MAINTAINER Benjamin Borbe <bborbe@rocketnews.de>
ARG VERSION

RUN set -x \
	&& DEBIAN_FRONTEND=noninteractive apt-get update --quiet || true \
	&& DEBIAN_FRONTEND=noninteractive apt-get install --quiet --yes --no-install-recommends apt-transport-https ca-certificates wget \
	&& wget https://nginx.org/keys/nginx_signing.key -O - | apt-key add -

RUN set -x \
	&& DEBIAN_FRONTEND=noninteractive apt-get update --quiet \
	&& DEBIAN_FRONTEND=noninteractive apt-get upgrade --quiet --yes \
	&& DEBIAN_FRONTEND=noninteractive apt-get install --quiet --yes --no-install-recommends git \
	&& DEBIAN_FRONTEND=noninteractive apt-get autoremove --yes \
	&& DEBIAN_FRONTEND=noninteractive apt-get clean

RUN git clone -b 1.10.0-stable --single-branch --depth 1 https://github.com/taigaio/taiga-front-dist.git /taiga
RUN rm -f /taiga/dist/conf.example.json
COPY conf.json /taiga/dist/conf.json.template
COPY nginx-default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
