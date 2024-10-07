# Use the official PHP image as a base image
FROM php:8.3-fpm-alpine

ARG user
ARG uid

# Install system dependencies
RUN apk add --no-cache \
    curl \
    libxml2-dev \
    php-soap \
    libzip-dev \
    unzip \
    zip \
    libpng \
    libpng-dev \
    jpeg-dev \
    oniguruma-dev \
    curl-dev \
    freetype-dev \
    libpq-dev \
    git \
    nodejs \
    npm


# RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pgsql pdo pdo_mysql pdo_pgsql bcmath mbstring zip exif pcntl

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer



RUN adduser -D -u $uid -g www-data $user

COPY . /var/www

# Installer les dépendances NPM et compiler les assets
RUN npm install
RUN npm run build

COPY --chown=$user:www-data . /var/www

USER $user

EXPOSE 9000

# CMD ["php-fpm"]





ENTRYPOINT ["sh", "./docker-compose/entrypoint.sh"]