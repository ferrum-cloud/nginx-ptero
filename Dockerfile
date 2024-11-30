FROM alpine:latest

# Add edge/testing repository for newer packages
RUN echo "@testing https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# Update and install system dependencies
RUN apk update && \
    apk add --no-cache \
    curl \
    ca-certificates \
    nginx

# Install PHP 8.4 (if available in testing) with all extensions
RUN apk add --no-cache \
    php8.4@testing \
    php8.4-xml@testing \
    php8.4-exif@testing \
    php8.4-fpm@testing \
    php8.4-session@testing \
    php8.4-soap@testing \
    php8.4-openssl@testing \
    php8.4-gmp@testing \
    php8.4-pdo_odbc@testing \
    php8.4-json@testing \
    php8.4-dom@testing \
    php8.4-pdo@testing \
    php8.4-zip@testing \
    php8.4-mysqli@testing \
    php8.4-sqlite3@testing \
    php8.4-pdo_pgsql@testing \
    php8.4-bcmath@testing \
    php8.4-gd@testing \
    php8.4-odbc@testing \
    php8.4-pdo_mysql@testing \
    php8.4-pdo_sqlite@testing \
    php8.4-gettext@testing \
    php8.4-xmlreader@testing \
    php8.4-bz2@testing \
    php8.4-iconv@testing \
    php8.4-pdo_dblib@testing \
    php8.4-curl@testing \
    php8.4-ctype@testing \
    php8.4-phar@testing \
    php8.4-fileinfo@testing \
    php8.4-mbstring@testing \
    php8.4-tokenizer@testing \
    php8.4-simplexml@testing \
    && rm -rf /var/cache/apk/*

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

USER container
ENV  USER container
ENV HOME /home/container

WORKDIR /home/container
COPY ./entrypoint.sh /entrypoint.sh


CMD ["/bin/ash", "/entrypoint.sh"]
