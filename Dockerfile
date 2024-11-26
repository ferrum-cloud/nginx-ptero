# Use Alpine edge for PHP 8.4
FROM alpine:edge

# Add community and testing repositories
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# Install necessary packages
RUN apk update && \
    apk add --no-cache \
    bash \
    nginx \
    curl \
    php84 \
    php84-fpm \
    php84-curl \
    php84-dom \
    php84-fileinfo \
    php84-gd \
    php84-json \
    php84-mbstring \
    php84-mysqli \
    php84-openssl \
    php84-pdo \
    php84-pdo_mysql \
    php84-phar \
    php84-session \
    php84-simplexml \
    php84-tokenizer \
    php84-xml \
    php84-zip

# Create entrypoint script
RUN echo '#!/bin/ash' > /entrypoint.sh && \
    echo 'exec "$@"' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

USER container
ENV USER=container
ENV HOME=/home/container
    
WORKDIR /home/container
    
CMD ["/bin/ash", "/entrypoint.sh"]