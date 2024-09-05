FROM	debian:buster

RUN		apt -y update && apt upgrade -y && apt install -y nginx openssl
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/default.conf /etc/nginx/conf.d
COPY ./tools/nginx.sh .
RUN chmod +x nginx.sh

EXPOSE	443

ENTRYPOINT ["./nginx.sh"]

CMD [ "nginx -g "daemon off;"" ]
