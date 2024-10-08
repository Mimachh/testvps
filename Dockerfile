FROM ghcr.io/mimachh/php-laravel-11:latest

WORKDIR /var/www

COPY . /var/www

RUN composer install --no-interaction --optimize-autoloader --no-dev

COPY package.json package-lock.json /var/www/

RUN npm install 

RUN mkdir -p /var/www/public/build && \
    chown -R www-data:www-data /var/www/public /var/www/storage
    
RUN npm run build

# Copier le reste du code source
# COPY . /var/www

# Assurer les bonnes permissions
RUN chown -R www-data:www-data /var/www

COPY entrypoint.sh /

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Specify the entrypoint
ENTRYPOINT ["sh", "/entrypoint.sh"]
