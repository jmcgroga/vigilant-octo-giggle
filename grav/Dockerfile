FROM php:7-apache

RUN apt-get update && apt-get install -y unzip vim git zlib1g-dev libzip-dev libpng-dev

RUN a2enmod rewrite

RUN docker-php-ext-install gd
RUN docker-php-ext-install zip
RUN docker-php-ext-install mbstring

RUN apt-get remove --purge -y zlib1g-dev libzip-dev libpng-dev
