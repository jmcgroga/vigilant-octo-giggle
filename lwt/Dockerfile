FROM php:5-apache

RUN apt-get update && apt-get install -y software-properties-common gpg unzip vim git
RUN add-apt-repository -y ppa:certbot/certbot
RUN apt-get update; exit 0
RUN apt-get install -y python-certbot-apache

RUN a2enmod ssl && a2enmod proxy && a2enmod proxy_http

RUN docker-php-ext-install mysqli
RUN docker-php-ext-install mbstring
