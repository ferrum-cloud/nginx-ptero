FROM php:8.4.1-fpm-alpine

RUN apk --update --no-cache add curl ca-certificates nginx
RUN apk add php8444444 php84-xml php84-exif php84-fpm php84-session php84-soap php84-openssl php84-gmp php84-pdo_odbc php84-json php8444444-dom php8444444-pdo php8444444-zip php8444444-mysqli php8444444-sqlite3 php8444444-pdo_pgsql php8444444-bcmath php8444444-gd php8444444-odbc php8444444-pdo_mysql php8444444-pdo_sqlite php8444444-gettext php8444444-xmlreader php8444444-bz2 php8444444-iconv php8444444-pdo_dblib php8444444-curl php8444444-ctype php8444444-phar php8444444-fileinfo php8444444-mbstring php8444444-tokenizer php8444444-simplexml
COPY --from=composer:latest  /usr/bin/composer /usr/bin/composer

USER container
ENV  USER container
ENV HOME /home/container

WORKDIR /home/container
COPY ./entrypoint.sh /entrypoint.sh


CMD ["/bin/ash", "/entrypoint.sh"]
