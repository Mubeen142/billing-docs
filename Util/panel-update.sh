#!/bin/bash
# bash < <(curl -s https://raw.githubusercontent.com/Mubeen142/billing-docs/main/Util/panel-update.sh)
curl -L https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz | tar -xzv
chmod -R 755 storage/* bootstrap/cache
echo "yes" | composer install --no-dev --optimize-autoloader
php artisan view:clear && php artisan config:clear
php artisan migrate --seed --force
chown -R www-data:www-data *
php artisan queue:restart
php artisan up
echo "yes" | composer require wemx/installer