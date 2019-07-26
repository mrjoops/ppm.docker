# mrjoops/ppm

This is a base image for creating Symfony or Laravel-based PHP services using PHP-PM.

The main difference with the phppm/standalone image is the use of the official Docker PHP image as a base.
The other notable difference is the use of the PORT environment variable to make it suitable for hosting with Heroku.

## Usage

The usage is the same as phppm/standalone.

## Extending

You can use it as is if the PHP modules mentionned below fit your needs or use it as a base.
Here is an example with composer added:

```
FROM mrjoops/ppm

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN apt-get update \
 && apt-get install -y git libzip-dev unzip zlib1g-dev \
 && apt-get clean \
 && docker-php-ext-install -j$(nproc) zip
```

## PHP Modules

* Core
* ctype
* curl
* date
* dom
* fileinfo
* filter
* ftp
* hash
* iconv
* json
* libxml
* mbstring
* mysqlnd
* openssl
* pcntl
* pcre
* PDO
* pdo_sqlite
* Phar
* posix
* readline
* Reflection
* session
* SimpleXML
* sodium
* SPL
* sqlite3
* standard
* tokenizer
* xml
* xmlreader
* xmlwriter
* zlib

