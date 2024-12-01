# ใช้ Alpine Linux รุ่น edge เป็น base image
FROM alpine:edge

# ติดตั้ง Curl และ CA Certificates
RUN apk --update --no-cache add \
    curl \
    ca-certificates \
    nginx

# ติดตั้ง PHP84 และ modules
RUN apk --update --no-cache add \
    php84 \
    php84-fpm \
    php84-session \
    php84-json \
    php84-openssl \
    php84-pdo \
    php84-pdo_mysql \
    php84-pdo_sqlite \
    php84-mysqli \
    php84-mbstring \
    php84-curl \
    php84-xml \
    php84-dom \
    php84-ctype \
    php84-simplexml \
    php84-tokenizer \
    php84-fileinfo

# เพิ่ม Composer จาก image composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# กำหนด directory และ permissions
WORKDIR /home/container
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# คำสั่งเริ่มต้นเมื่อ container ทำงาน
CMD ["/bin/ash", "/entrypoint.sh"]
