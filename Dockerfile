FROM alpine:latest

# Update the package index and install required dependencies
RUN apk --no-cache update && \
    apk --no-cache add curl ca-certificates nginx && \
    apk --no-cache add php84 php84-xml php84-exif php84-fpm php84-session \
                       php84-soap php84-openssl php84-gmp php84-pdo_odbc \
                       php84-json php84-dom php84-pdo php84-zip php84-mysqli \
                       php84-sqlite3 php84-pdo_pgsql php84-bcmath php84-gd \
                       php84-odbc php84-pdo_mysql php84-pdo_sqlite php84-gettext \
                       php84-xmlreader php84-bz2 php84-iconv php84-pdo_dblib \
                       php84-curl php84-ctype php84-phar php84-fileinfo \
                       php84-mbstring php84-tokenizer php84-simplexml

# Add composer from the latest official image
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create and configure the container user
RUN adduser -D -u 1000 container && \
    mkdir -p /home/container && \
    chown -R container:container /home/container

USER container
ENV USER=container
ENV HOME=/home/container

WORKDIR /home/container

# Copy entrypoint script
COPY ./entrypoint.sh /entrypoint.sh

# Ensure the entrypoint script has execute permissions
RUN chmod +x /entrypoint.sh

# Define the default command
CMD ["/bin/ash", "/entrypoint.sh"]
