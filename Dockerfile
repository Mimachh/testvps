FROM ghcr.io/mimachh/php-laravel-11:latest

WORKDIR /var/www

# Installer les dépendances Composer
COPY composer.json /var/www/

RUN ls -l /var/www && cat /var/www/composer.json && cat /var/www/composer.lock

RUN composer install --no-interaction --optimize-autoloader --no-dev

# Installer les dépendances NPM
COPY package.json package-lock.json /var/www/
RUN npm install && npm run build

# Copier le reste du code source
COPY . /var/www

# Assurer les bonnes permissions
RUN chown -R www-data:www-data /var/www

COPY entrypoint.sh /

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Specify the entrypoint
ENTRYPOINT ["sh", "/entrypoint.sh"]
