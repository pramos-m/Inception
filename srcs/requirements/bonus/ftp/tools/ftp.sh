#!/bin/bash

service vsftpd start

adduser $FTP_USR --disabled-password

echo "$FTP_USR:$FTP_PWD" | /usr/sbin/chpasswd
echo "$FTP_USR" | tee -a /etc/vsftpd.userlist
mkdir -p /var/www/html/ftp
chown $FTP_USR:$FTP_USR /var/www/html/ftp
chmod 777 /var/www/html/ftp
sed -i -r "s/#write_enable=YES/write_enable=YES/1"   /etc/vsftpd.conf
sed -i -r "s/#chroot_local_user=YES/chroot_local_user=YES/1"   /etc/vsftpd.conf

echo "
local_enable=YES
allow_writeable_chroot=YES
pasv_enable=YES
local_root=/var/www/html/ftp
pasv_min_port=40000
pasv_max_port=40005
userlist_file=/etc/vsftpd.userlist" >> /etc/vsftpd.conf

service vsftpd stop

exec "$@"
