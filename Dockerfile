FROM nginx
MAINTAINER Benjamin Borbe <bborbe@rocketnews.de>

RUN set -x \
    && apt-get update --quiet \
    && apt-get install --quiet --yes --no-install-recommends git \
    && apt-get clean

RUN git clone -b stable --single-branch https://github.com/taigaio/taiga-front-dist.git /taiga
RUN rm -rf /usr/share/nginx/html
RUN mv /taiga/dist /usr/share/nginx/html
RUN rm -rf /taiga /usr/share/nginx/html/conf.example.json
ADD conf.json /usr/share/nginx/html/conf.json

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]