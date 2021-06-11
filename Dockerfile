FROM php:7.4

RUN apt-get update & apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        zlib1g-dev \
        libxml2-dev \
        libzip-dev \
        lib0nig-dev \
        graphviz \

    && docker-php-extention-configure gd \
    && docker-php-extention-install -j$(nproc) gd \
    && docker-php-extention-install pdo_mysql \
    && docker-php-extention-install mysqli \
    && docker-php-extention-install zip \
    && docker-php-extention-install sockets \
    && docket-php-source delete \
    && curl -sS https://getcomposer.org/installer | php -- \
     --install-dir=/usr/local/bin --filename=composer

WORKDIR /app
COPY . .
RUN composer install

CMD php artisan serve --host=0.0.0.0
EXPOSE 8000
