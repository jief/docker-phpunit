FROM composer

FROM php:8.1-cli

LABEL org.opencontainers.image.authors=jf.monfort@gmail.com

RUN apt-get update && apt-get install -y \
    unzip \
    git \
    wget \
    libzip-dev \
    zlib1g-dev \
    libpng-dev \
    libicu-dev \
    libxslt-dev \
    libpq-dev 
    
RUN docker-php-ext-install \
    zip \
    intl \ 
    gd \ 
    xsl \
    bcmath \
    pdo_mysql \
    pdo_pgsql \ 
    pgsql

COPY php.ini $PHP_INI_DIR/conf.d/

# Set timezone
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Brussels /etc/localtime

# Composer
COPY --from=composer /usr/bin/composer /usr/local/bin/composer

# Chrome & Chromedriver for Panther
RUN apt-get install -y \
    fonts-liberation \
    libasound2 \
    libatk1.0-0 \
    libatspi2.0-0 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxkbcommon0 \
    libxrandr2 \
    xdg-utils
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb
