FROM debian:buster

RUN apt -y update -y && apt install wget -y && apt install php php-mysql  -y

COPY ./tools/adminer.sh /

RUN chmod +x adminer.sh

ENTRYPOINT ["/adminer.sh"]

CMD [ "php", "-S", "0.0.0.0:80" ]