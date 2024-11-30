FROM alpine:latest

# Install build dependencies
RUN apk add --no-cache \
    alpine-sdk \
    autoconf \
    automake \
    bash \
    bison \
    build-base \
    curl \
    ca-certificates \
    nginx \
    re2c \
    libxml2-dev \
    sqlite-dev \
    openssl-dev \
    libzip-dev \
    curl-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libxslt-dev \
    postgresql-dev \
    oniguruma-dev \
    gettext-dev \
    icu-dev

# Download and verify PHP 8.4.1
RUN cd /tmp && \
    curl -L https://www.php.net/distributions/php-8.4.1.tar.gz -o php-8.4.1.tar.gz && \
    echo "c3d1ce4157463ea43004289c01172deb54ce9c5894d8722f4e805461bf9feaec  php-8.4.1.tar.gz" | sha256sum -c - && \
    tar -xzf php-8.4.1.tar.gz && \
    cd php-8.4.1 && \
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc/php \
        --with-config-file-path=/etc/php \
        --with-config-file-scan-dir=/etc/php/conf.d \
        --enable-fpm \
        --with-fpm-user=container \
        --with-fpm-group=container \
        --disable-debug \
        --enable-intl \
        --enable-mbstring \
        --enable-soap \
        --enable-sockets \
        --with-curl \
        --with-iconv \
        --with-openssl \
        --with-sqlite3 \
        --with-pdo-sqlite \
        --with-pdo-mysql \
        --with-pdo-pgsql \
        --with-mysqli \
        --with-zlib \
        --with-zip \
        --with-gd \
        --with-jpeg \
        --with-freetype \
        --enable-bcmath \
        --enable-exif && \
    make -j$(nproc) && \
    make install && \
    cd .. && \
    rm -rf php-8.4.1*

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

USER container
ENV  USER container
ENV HOME /home/container

WORKDIR /home/container
COPY ./entrypoint.sh /entrypoint.sh


CMD ["/bin/ash", "/entrypoint.sh"]
