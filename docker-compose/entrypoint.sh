#!/bin/sh

# Créer les répertoires nécessaires
mkdir -p /var/www/storage/framework/cache
mkdir -p /var/www/storage/framework/sessions
mkdir -p /var/www/storage/framework/views

# # Donner les permissions appropriées
chown -R www-data:www-data /var/www/storage 
# /var/www/bootstrap/cache

# Générer la clé de l'application si elle n'existe pas
if ! grep -q "^APP_KEY=" .env || [ -z "$(grep "^APP_KEY=" .env | cut -d '=' -f2)" ]; then
    php artisan key:generate
fi

# Exécuter les migrations
php artisan migrate --force

# Démarrer PHP-FPM
# php artisan serve --host=0.0.0.0 --port=8085


exec php-fpm