# Use Alpine edge for PHP 8.3
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
    php83 \
    php83-fpm \
    php83-curl \
    php83-dom \
    php83-fileinfo \
    php83-gd \
    php83-json \
    php83-mbstring \
    php83-mysqli \
    php83-openssl \
    php83-pdo \
    php83-pdo_mysql \
    php83-phar \
    php83-session \
    php83-simplexml \
    php83-tokenizer \
    php83-xml \
    php83-zip

# Set working directory
WORKDIR /home/container

# Copy start and entrypoint scripts BEFORE chmod
COPY start.sh /start.sh
COPY entrypoint.sh /entrypoint.sh

# Set executable permissions
RUN chmod +x /start.sh /entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]