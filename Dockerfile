FROM alpine:edge

RUN apk --update --no-cache add curl ca-certificates nginx
RUN apk add php84 php84-xml php84-exif php84-fpm php84-session php84-soap php84-openssl php84-gmp php84-pdo_odbc php84-json php84-dom php84-pdo php84-zip php84-mysqli php84-sqlite3 php84-pdo_pgsql php84-bcmath php84-gd php84-odbc php84-pdo_mysql php84-pdo_sqlite php84-gettext php84-xmlreader php84-bz2 php84-iconv php84-pdo_dblib php84-curl php84-ctype php84-phar php84-fileinfo php84-mbstring php84-tokenizer php84-simplexml php84-opcache php84-snmp php84-posix php84-sockets php84-sodium php84-shmop php84-sysvmsg php84-sysvsem php84-sysvshm php84-embed php84-dba php84-dbg php84-dev php84-enchant php84-ldap php84-litespeed php84-pear php84-tidy php84-xsl php84-xmlwriter
COPY --from=composer:latest  /usr/bin/composer /usr/bin/composer

USER container
ENV  USER container
ENV HOME /home/container

WORKDIR /home/container
COPY ./entrypoint.sh /entrypoint.sh


CMD ["/bin/ash", "/entrypoint.sh"]
