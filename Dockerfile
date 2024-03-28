FROM php:8.2-fpm-alpine3.16

WORKDIR /var/www

ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apk update && apk add --no-cache bash \
    autoconf \
    build-base \
    shadow \
    curl \
    zlib-dev \
    zip \
    libzip-dev \
    bzip2 \
    bzip2-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    freetds-dev \
    unixodbc-dev \
    php8 \
    php8-common \
    php8-fpm \
    php8-pdo \
    php8-opcache \
    php8-zip \
    php8-phar \
    php8-iconv \
    php8-cli \
    php8-curl \
    php8-openssl \
    php8-mbstring \
    php8-tokenizer \
    php8-fileinfo \
    php8-json \
    php8-xml \
    php8-xmlwriter \
    php8-simplexml \
    php8-dom \
    php8-pdo_mysql \
    php8-pdo_sqlite \
    php8-tokenizer \
    php8-pecl-redis \
    supervisor \
    tzdata

RUN docker-php-ext-configure pdo \
    && pecl install zip redis \
    && docker-php-ext-enable redis \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip bz2

RUN rm -rf /var/cache/apk/*

COPY config/pool.conf /usr/local/etc/php-fpm.d/pool.conf

EXPOSE 9000

CMD [ "php-fpm"]
