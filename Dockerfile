FROM alpine:3.18

# Install necessary build dependencies
RUN apk --update --no-cache add \
    curl ca-certificates build-base autoconf bison re2c libxml2-dev \
    oniguruma-dev libpng-dev libjpeg-turbo-dev freetype-dev bzip2-dev \
    libzip-dev zlib-dev sqlite-dev gmp-dev icu-dev openssl-dev \
    && rm -rf /var/cache/apk/*

# Define PHP version and checksum
ENV PHP_VERSION=8.4.1
ENV PHP_SHA256=c3d1ce4157463ea43004289c01172deb54ce9c5894d8722f4e805461bf9feaec

# Download, verify, and install PHP
RUN curl -o php.tar.xz https://www.php.net/distributions/php-${PHP_VERSION}.tar.xz \
    && echo "${PHP_SHA256}  php.tar.xz" | sha256sum -c - \
    && mkdir -p /usr/src/php \
    && tar -xJf php.tar.xz -C /usr/src/php --strip-components=1 \
    && rm php.tar.xz \
    && cd /usr/src/php \
    && ./configure --prefix=/usr/local --with-config-file-path=/usr/local/etc \
        --disable-cgi --enable-mbstring --with-openssl --enable-bcmath \
        --enable-pdo --with-pdo-mysql --with-pdo-sqlite --with-zlib \
        --enable-soap --with-bz2 --enable-intl --with-curl --with-libdir=/lib \
    && make -j"$(nproc)" \
    && make install \
    && make clean \
    && cp php.ini-production /usr/local/etc/php.ini \
    && rm -rf /usr/src/php

# Add a non-root user
RUN adduser -D -h /home/container -s /bin/ash container
USER container
ENV USER=container
ENV HOME=/home/container

# Set the working directory
WORKDIR /home/container

# Copy the entrypoint script
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Define default command
CMD ["/bin/ash", "/entrypoint.sh"]
