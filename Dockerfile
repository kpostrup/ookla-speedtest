FROM php:7.0-apache

MAINTAINER Kenneth Østrup

RUN apt-get update \
    && apt-get install -y wget unzip \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://install.speedtest.net/httplegacy/http_legacy_fallback.zip
RUN unzip http_legacy_fallback.zip -d /var/www/html \
    && rm http_legacy_fallback.zip

RUN sed -i "s/^ServerTokens.*/ServerTokens Prod/" \
    /etc/apache2/conf-available/security.conf
RUN sed -i "s/^ServerSignature.*/ServerSignature Off/" \
    /etc/apache2/conf-available/security.conf

EXPOSE 80
