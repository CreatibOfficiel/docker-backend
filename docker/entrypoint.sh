#!/usr/bin/env bash

# Install composer dependencies
composer install -n
#composer install --no-dev --optimize-autoloader

# Create database
bin/console d:s:u -f --no-interaction

# Clear cache
bin/console cache:clear

exec "$@"