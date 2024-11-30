FROM alpine:latest

RUN apk update && apk --no-cache add curl ca-certificates nginx
RUN apk add php8.4 php8.4-xml php8.4-exif php8.4-fpm php8.4-session php8.4-soap php8.4-openssl php8.4-gmp php8.4-pdo_odbc php8.4-json php8.4-dom php8.4-pdo php8.4-zip php8.4-mysqli php8.4-sqlite3 php8.4-pdo_pgsql php8.4-bcmath php8.4-gd php8.4-odbc php8.4-pdo_mysql php8.4-pdo_sqlite php8.4-gettext php8.4-xmlreader php8.4-bz2 php8.4-iconv php8.4-pdo_dblib php8.4-curl php8.4-ctype php8.4-phar php8.4-fileinfo php8.4-mbstring php8.4-tokenizer php8.4-simplexml && rm -rf /var/cache/apk/*

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

USER container
ENV USER container
ENV HOME /home/container

WORKDIR /home/container
COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/ash", "/entrypoint.sh"]
