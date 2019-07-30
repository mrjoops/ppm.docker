FROM php:7.3.2-cli
# see https://github.com/php-pm/php-pm/issues/461

ARG ppm_http_version=^2.0
ARG ppm_version=^2.0

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HTACCESS_PROTECT 0
ENV COMPOSER_MEMORY_LIMIT -1

COPY --from=composer /usr/bin/composer /usr/bin/composer

WORKDIR /ppm

RUN apt-get update \
 && apt-get install -y git libzip-dev unzip zlib1g-dev \
 && docker-php-ext-install -j$(nproc) zip \
 && composer require -on --prefer-dist --sort-packages php-pm/php-pm:${ppm_version} php-pm/httpkernel-adapter:${ppm_http_version}

FROM php:7.3.2-cli

ENV PORT 80

COPY --from=0 /ppm /ppm
COPY php.ini /usr/local/etc/php/conf.d/config.ini
COPY run.sh /etc/app/run.sh

RUN docker-php-ext-install -j$(nproc) pcntl \
 && mv $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini \
 && /ppm/vendor/bin/ppm config --app-env=prod --config=/ppm/ppm.json --debug=0 --host=0.0.0.0

WORKDIR /app

EXPOSE $PORT

ENTRYPOINT [ "/etc/app/run.sh" ]

CMD [ "/app" ]
