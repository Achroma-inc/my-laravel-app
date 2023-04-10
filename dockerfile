FROM php:8.1-fpm-alpine

# Install dependencies
RUN apk add --no-cache \
    build-base \
    shadow \
    openssl-dev \
    autoconf \
    zlib-dev \
    libzip-dev \
    libpng-dev \
    oniguruma-dev

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl gd

# Install Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy files
COPY . /var/www/html

# Change user and group ownership
RUN chown -R www-data:www-data /var/www/html

# Expose port
EXPOSE 9000

CMD ["php-fpm"]
