FROM php:8.2-apache

WORKDIR /var/www/html
COPY . .

RUN apt update && \
    apt install -y libpng-dev libpq-dev && \
    docker-php-ext-install pdo pdo_pgsql gd

EXPOSE 80
EXPOSE 443

CMD ["apache2-foreground"]
