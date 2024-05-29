#!/bin/sh

if [ -f ./wp-config.php ]
then
	echo "wordpress already downloaded"
else
####### MANDATORY PART ##########
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  	chmod +x wp-cli.phar
  	mv wp-cli.phar /usr/local/bin/wp
	#CONFIG
 	wp core download --path=$WP_PATH --allow-root
 	wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb --path=$WP_PATH --skip-check --allow-root
  	wp core install --path=$WP_PATH --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_USER --admin_password=$WP_PASSWORD --admin_email=$WP_EMAIL --skip-email --allow-root
 	wp theme install teluro --path=$WP_PATH --activate --allow-root
  	wp user create correa correa@gmail.com --role=author --path=$WP_PATH --user_pass=$MYSQL_PASSWORD --allow-root
## redis ##
	wp config set WP_REDIS_HOST redis --allow-root
 	wp config set WP_REDIS_PORT 6379 --raw --allow-root
	wp config set WP_REDIS_CLIENT phpredis --allow-root
	wp plugin install redis-cache --activate --allow-root
    wp plugin update --all --allow-root
	wp redis enable --allow-root

fi

exec "$@"
