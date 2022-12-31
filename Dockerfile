FROM composer:2.5.1 as composer

WORKDIR /app
COPY . /app
RUN composer install

FROM php:apache

EXPOSE 80
COPY --from=composer /app /app
COPY vhost.conf /etc/apache2/sites-available/000-default.conf
RUN chown -R www-data:www-data /app \
    && a2enmod rewrite
