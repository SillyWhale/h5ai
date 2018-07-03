FROM alpine:3.7
LABEL maintainer="Vincent FRICOU <vincent@fricouv.eu>"

ENV H5_VERSION=0.29.0
ENV H5_ARTIFACT=h5ai-${H5_VERSION}.zip \
    H5_URL=https://release.larsjung.de/h5ai/ \
    H5_ROOT=/h5ai

COPY includes/ /includes

RUN \
    apk -U --no-cache upgrade && \
    apk add --no-cache wget unzip && \
    apk add --no-cache nginx supervisor && \
    apk add --no-cache php7-fpm php7-session php7-json && \
    wget ${H5_URL}${H5_ARTIFACT} -O /tmp/${H5_ARTIFACT} && \
    unzip /tmp/${H5_ARTIFACT} -d /tmp/ && \
    mv /tmp/_h5ai ${H5_ROOT} && \
    rm /etc/php7/php-fpm.d/www.conf && \
    mkdir /run/nginx/ && \
    cp /includes/nginx.conf /etc/nginx/conf.d/default.conf && \
    cp /includes/php7-fpm.conf /etc/php7/php-fpm.d/h5ai.conf && \
    cp /includes/supervisord.conf /usr/local/supervisord.conf && \
    cp /includes/init.sh /init.sh && \
    rm -rf /includes && \
    apk del wget unzip && \
    chmod +x /init.sh

ENTRYPOINT [ "/init.sh" ]