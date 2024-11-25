# Base Alpine image
FROM alpine:latest

# Add edge repositories for PHP 8.4 and update apk
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk update && apk upgrade --no-cache

# Install base dependencies
RUN apk --no-cache add \
    curl \
    ca-certificates \
    nginx

# Install PHP 8.4 and required extensions in smaller groups
RUN apk --no-cache add \
    php84 php84-fpm php84-json php84-openssl php84-mbstring php84-ctype php84-tokenizer && \
    apk --no-cache add \
    php84-xml php84-dom php84-soap php84-bcmath php84-pdo php84-pdo_mysql && \
    apk --no-cache add \
    php84-pdo_pgsql php84-curl php84-gd php84-zip php84-sqlite3 php84-gettext

# Copy Composer from the official image
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set environment variables
ENV USER container
ENV HOME /home/container

# Set working directory
WORKDIR /home/container

# Copy the entrypoint script and make it executable
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the default user
USER container

# Define the entrypoint and default command
CMD ["/bin/ash", "/entrypoint.sh"]
