FROM php:7.0-apache

LABEL maintainer="io@becopay.com"
LABEL version="3.0.2.0"
LABEL description="OpenCart with becopay plugin Docker"

ENV OPENCART_VERSION 3.0.2.0
ENV BECOPAY_VERSION master

ENV INSTALL_DIR /var/www/html

RUN requirements="zip curl libpng-dev zlib1g-dev libfreetype6-dev libjpeg62-turbo-dev" \
    && apt-get update -y \
    && apt-get install -y $requirements

RUN docker-php-ext-install  mysqli
RUN docker-php-ext-install zip

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/  &&  \
    docker-php-ext-install gd

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

RUN chsh -s /bin/bash www-data

RUN cd /tmp && \ 
  curl https://codeload.github.com/opencart/opencart/tar.gz/$OPENCART_VERSION -o $OPENCART_VERSION.tar.gz && \
  tar xvf $OPENCART_VERSION.tar.gz

RUN cd /tmp/opencart-$OPENCART_VERSION && rm composer.lock && composer install && \
  mv upload/* $INSTALL_DIR/

RUN cd /tmp && \
  curl https://codeload.github.com/becopay/Opencart-Becopay-Gateway/tar.gz/$BECOPAY_VERSION -o $BECOPAY_VERSION.tar.gz && \
  tar xvf $BECOPAY_VERSION.tar.gz && \
  cp -r Opencart-Becopay-Gateway-$BECOPAY_VERSION/upload/*  $INSTALL_DIR/

RUN cd $INSTALL_DIR \
    && mv config-dist.php config.php \
    && mv admin/config-dist.php admin/config.php

RUN chown -R www-data:www-data /var/www

COPY ./install-opencart /usr/local/bin/install-opencart
RUN chmod +x /usr/local/bin/install-opencart

RUN cd $INSTALL_DIR \
    && find . -type d -exec chmod 770 {} \; \
    && find . -type f -exec chmod 660 {} \;

RUN rm -rf /tmp/*

WORKDIR $INSTALL_DIR
EXPOSE 80 443

WORKDIR /var/www/html
VOLUME ["/var/htdocs", "/var/logs"]

