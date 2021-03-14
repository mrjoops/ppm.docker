FROM mrjoops/ppm:7.4.16

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HTACCESS_PROTECT 0
ENV COMPOSER_MEMORY_LIMIT -1

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN apt-get update && apt-get install -y git libzip-dev nodejs npm unzip zlib1g-dev && apt-get clean \
 && cp $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini \
 && curl https://get.symfony.com/cli/installer | bash && mv /root/.symfony/bin/symfony /usr/local/bin/symfony \
 && docker-php-ext-install -j$(nproc) zip \
 && pecl install xdebug-3.0.3 \
 && docker-php-ext-enable xdebug \
 && /ppm/vendor/bin/ppm config --app-env=dev --config=/ppm/ppm.json --debug=1
