FROM alpine:3.7
LABEL maintainer="Vincent FRICOU <vincent@fricouv.eu>"

ENV H5_VERSION=0.29.0
ENV H5_ARTIFACT=h5ai-${H5_VERSION}.zip \
    H5_URL=https://release.larsjung.de/h5ai/ \
    H5_ROOT=/h5ai

COPY includes/init.sh /init.sh

RUN \
    apk -U upgrade && \
    apk add wget unzip && \
    apk add nginx supervisor && \
    apk add php7-fpm php7-session php7-json && \
    wget ${H5_URL}${H5_ARTIFACT} -O /tmp/${H5_ARTIFACT} && \
    unzip /tmp/${H5_ARTIFACT} -d /tmp/ && \
    mv /tmp/_h5ai ${H5_ROOT} && \
    rm /etc/php7/php-fpm.d/www.conf && \
    mkdir /run/nginx/ && \
    chmod +x /init.sh

COPY includes/nginx.conf /etc/nginx/conf.d/default.conf 
COPY includes/php7-fpm.conf /etc/php7/php-fpm.d/h5ai.conf
COPY includes/supervisord.conf /usr/local/etc/supervisord.conf

ENTRYPOINT [ "/init.sh" ]