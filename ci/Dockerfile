FROM mrjoops/ppm:7.3.2

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HTACCESS_PROTECT 0
ENV COMPOSER_MEMORY_LIMIT -1

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN apt-get update \
 && apt-get install -y git libzip-dev unzip zlib1g-dev \
 && apt-get clean \
 && docker-php-ext-install -j$(nproc) zip
