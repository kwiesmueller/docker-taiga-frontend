FROM nginx
MAINTAINER Benjamin Borbe <bborbe@rocketnews.de>

RUN set -x \
	&& apt-get update --quiet \
	&& apt-get upgrade --quiet --yes \
	&& apt-get install --quiet --yes --no-install-recommends git \
	&& apt-get autoremove --yes \
	&& apt-get clean

RUN git clone -b stable --single-branch https://github.com/taigaio/taiga-front-dist.git /taiga
RUN rm -f /taiga/dist/conf.example.json
ADD conf.json /taiga/dist/conf.json
ADD nginx-default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]