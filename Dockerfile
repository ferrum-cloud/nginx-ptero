# Use the latest Alpine base image
FROM alpine:latest

# Update the package index and install necessary packages
RUN apk update && apk add --no-cache \
    php84 \
    php84-xml \
    php84-fpm \
    php84-session \
    php84-soap \
    php84-openssl \
    php84-gmp \
    php84-pdo_odbc \
    php84-json \
    php84-dom \
    php84-pdo \
    php84-zip \
    php84-mysqli \
    php84-sqlite3 \
    php84-pdo_pgsql \
    php84-bcmath \
    php84-gd \
    php84-odbc \
    php84-pdo_mysql \
    php84-pdo_sqlite \
    php84-gettext \
    php84-xmlreader \
    php84-bz2 \
    php84-iconv \
    php84-pdo_dblib \
    php84-curl \
    php84-ctype \
    php84-phar \
    php84-fileinfo \
    php84-mbstring \
    php84-tokenizer \
    php84-simplexml

# Clean up APK cache to reduce image size
RUN rm -rf /var/cache/apk/*

# Set the command to run your application or PHP-FPM
CMD ["php-fpm84", "-F"]
