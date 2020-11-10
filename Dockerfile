FROM php:7.4.11-fpm-buster

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -

# update and install some requirements for Laravel 8 and PostgresSQL
RUN apt-get update && apt-get install -y --no-install-recommends \
    libssl-dev \
    libxml2-dev \
    libpq-dev \
    zip \
    unzip \
    curl \
    libonig-dev \
    nodejs

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install bcmath pdo_pgsql pgsql

# Configure pgsql (PostresSQL)
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Accept connection from all the network
RUN sed -e 's/127.0.0.1:9000/9000/' -e '/allowed_clients/d'

# Set working directory
WORKDIR /var/www

# Copy the app inside the container
COPY . /var/www

# Install packages required
RUN composer install

# Install packages required
RUN npm install
RUN npm run prod

# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Copy existing application directory permissions
COPY --chown=www:www . /var/www

# Change current user to www
USER www

# Expose the port for php-fpm service
EXPOSE 9000
CMD ["php-fpm"]

