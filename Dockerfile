FROM php:7.4-fpm

RUN ["apt-get", "update"]
RUN ["apt-get", "-y", "install", "nginx"]
RUN ["apt-get", "-y", "install", "supervisor"]
RUN ["apt-get", "-y", "install", "wget"]
RUN ["apt-get", "-y", "install", "git"]

RUN mkdir -p /run/nginx

COPY docker/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /app
COPY . /app

RUN sh -c "wget http://getcomposer.org/composer.phar && chmod a+x composer.phar && mv composer.phar /usr/local/bin/composer"
RUN cd /app && \
    /usr/local/bin/composer install --no-dev

RUN chown -R www-data: /app

CMD sh /app/docker/startup.sh
