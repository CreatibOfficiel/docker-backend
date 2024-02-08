FROM php:8.2-apache

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Install dependencies
RUN apt-get update && \
    apt-get install -y libzip-dev git wget libicu-dev --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install PHP extensions
RUN docker-php-ext-install pdo mysqli pdo_mysql zip intl

# Install Composer
RUN wget https://getcomposer.org/download/2.6.6/composer.phar && \
    mv composer.phar /usr/bin/composer && \
    chmod +x /usr/bin/composer

# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs
RUN curl -qL https://www.npmjs.com/install.sh | sh
RUN npm -v

# Copy configuration files
COPY docker/apache.conf /etc/apache2/sites-enabled/000-default.conf
COPY docker/entrypoint.sh /entrypoint.sh
COPY . /var/www

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN chmod +x /entrypoint.sh

CMD ["apache2-foreground"]

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]