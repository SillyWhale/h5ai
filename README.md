# Supported tags and respective `Dockerfile` links

- [`latest` (*latest/Dockerfile*)](https://github.com/SillyWhale/h5ai/blob/master/Dockerfile)

# Quick reference

- **Where to file issues**:  
  [https://github.com/SillyWhale/h5ai/issues](https://github.com/h5ai/privatebin/issues)

- **Maintained by**:  
  [SillyWhale](https://github.com/SillyWhale/h5ai)

- **Source of this description**:  
  [docs repo's directory](https://github.com/SillyWhale/_documentation)

- **Supported Docker versions**:  
  [the latest release](https://github.com/docker/docker-ce/releases/latest)

# What is privatebin ?

[h5ai](https://larsjung.de/h5ai/) description.  

# How to use this image

## Usage

Use like you would any other base image:

```dockerfile
FROM alpine:3.7
LABEL maintainer="SillyWhale <contact@sillywhale.wtf>"

ENV H5_VERSION=0.29.0
ENV H5_ARTIFACT=h5ai-${H5_VERSION}.zip \
    H5_URL=https://release.larsjung.de/h5ai/ \
    H5_ROOT=/h5ai/_h5ai \
    H5_BASE=/h5ai/

COPY includes/ /includes

RUN \
    apk -U --no-cache upgrade && \
    apk add --no-cache wget unzip \
                        nginx supervisor \
                        php7-fpm php7-session php7-json && \
    wget ${H5_URL}${H5_ARTIFACT} -O /tmp/${H5_ARTIFACT} && \
    unzip /tmp/${H5_ARTIFACT} -d /tmp/ && \
    mkdir ${H5_BASE} && \
    mv /tmp/_h5ai ${H5_ROOT} && \
    rm /etc/php7/php-fpm.d/www.conf && \
    mkdir /run/nginx/ && \
    cp /includes/nginx.conf /etc/nginx/conf.d/default.conf && \
    cp /includes/php7-fpm.conf /etc/php7/php-fpm.d/h5ai.conf && \
    cp /includes/supervisord.conf /usr/local/supervisord.conf && \
    cp /includes/init.sh /init.sh && \
    rm -rf /includes && \
    echo 'daemon off;' >> /etc/nginx/nginx.conf && \
    apk del wget unzip && \
    chmod +x /init.sh

ENTRYPOINT [ "/init.sh" ]
```

This yields us a virtual image size of about 62.3MB image.

## Documentation

This image is well documented. [Check out the documentation at Viewdocs](http://docs.sillywhale.wtf/h5ai/).

# License

View [license information](https://github.com/lrsjng/h5ai) on README for the software contained in this image.

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.