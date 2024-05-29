FROM debian:buster

RUN apt-get update && apt-get -y install \
	 curl \
	 bash \
	 php \
	 php-cgi \
	 php-mysql \
	 php-fpm \
	 php-pdo \
	 php-gd php-cli \
	 php-mbstring \
	 redis \
	 php-redis \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /etc/php/7.3/fpm/pool.d/www.conf \
	&& mkdir  -p /run/php

COPY ./conf/wordpress.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY ./tools/wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wordpress.sh

ENTRYPOINT ["/usr/local/bin/wordpress.sh"]

WORKDIR /var/www/html/

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.3", "-F"]
