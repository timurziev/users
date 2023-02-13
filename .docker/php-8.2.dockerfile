FROM php:8.2-fpm-alpine
# Set working directory
WORKDIR /app

# Stuff we need
RUN apk update && apk add --no-cache ca-certificates supervisor git
# Build deps
RUN apk update && apk add --no-cache --virtual .build-deps pcre-dev ${PHPIZE_DEPS}

# Enable pre-compiled extenstions for base-laravel
RUN docker-php-ext-enable opcache sodium
# Install extensions needed for base-laravel
RUN docker-php-ext-install bcmath pdo pdo_mysql
# Integrated extensions
RUN apk add zlib-dev libpng-dev freetype-dev libjpeg-turbo-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg && docker-php-ext-install -j$(nproc) gd \
    && apk add libzip-dev \
    && docker-php-ext-install zip

# Install XDebug
# Note: XDebug seems to cause compile issues. We'll keep this disabled for now.
#RUN pecl install xdebug \
#    && rm -rf /tmp/pear \
#    && docker-php-ext-enable xdebug \
#    && php -m | grep xdebug

# Install igbinary
RUN pecl install igbinary \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable igbinary \
    && php -m | grep igbinary

# Install redis
RUN pecl install redis \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis \
    && php -m | grep redis

# Install redis driver
#RUN mkdir -p /tmp/pear \
#    && cd /tmp/pear \
#    && pecl bundle redis \
#    && cd redis \
#    && phpize . \
#    && ./configure --enable-redis-igbinary \
#    && make \
#    && make install \
#    && cd ~ \
#    && rm -rf /tmp/pear \
#    && docker-php-ext-enable redis \
#    && php -m | grep redis

# Add composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Remove build-only packages
# Remove builddeps
RUN apk del .build-deps
# Remove Caches
RUN rm -rf /var/cache/apk/* \
    && rm -rf /tmp/pear

# Use the default production configuration ($PHP_INI_DIR variable already set by the default image)
RUN cp "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Copy supervisor config
COPY ./supervisord.conf /etc/supervisord.conf
# Write CRONTAB rule for Laravel scheduler
RUN echo "* * * * * php /app/artisan schedule:run >> /dev/null 2>&1" >> /etc/crontabs/root
# Copy artisan helper script to VM executable folder
COPY ./php/artisan /usr/local/bin

# Start Supervisor, it manages the other stuff for us.
CMD supervisord -c /etc/supervisord.conf
