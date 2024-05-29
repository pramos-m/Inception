FROM debian:buster


RUN apt update -y

RUN apt install vsftpd -y

COPY ./tools/ftp.sh /
RUN chmod +x ftp.sh

CMD ["/ftp.sh"]