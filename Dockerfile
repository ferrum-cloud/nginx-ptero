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
    icu-dev \
    wget

# Download and verify PHP 8.4.1
RUN mkdir -p /tmp/php-build && cd /tmp/php-build \
    && wget https://github.com/php/php-src/archive/refs/tags/php-8.4.1.tar.gz \
    && tar -xzf php-8.4.1.tar.gz \
    && cd php-src-php-8.4.1 \
    && ./buildconf --force \
    && ./configure \
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
    && make -j$(nproc) \
    && make install \
    && cd / \
    && rm -rf /tmp/php-build

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create non-root user
RUN adduser -D -u 1000 container

# Set user and environment
USER container
ENV USER=container
ENV HOME=/home/container

# Set working directory
WORKDIR /home/container

# Copy entrypoint script
COPY ./entrypoint.sh /entrypoint.sh

# Set entrypoint
CMD ["/bin/ash", "/entrypoint.sh"]
