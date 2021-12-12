FROM mediawiki:latest

LABEL maintainer="bob@brez.io"

EXPOSE 80

ADD ./LocalSettings.php /var/www/html/LocalSettings.php
ADD ./php /usr/local/etc/php