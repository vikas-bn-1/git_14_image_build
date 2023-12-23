#!/bin/bash


echo "ClientAliveInterval 60" >> /etc/ssh/sshd_config
systemctl restart sshd.service

yum install httpd php -y

cp -r /tmp/website/* /var/www/html/
chown -R apache:apache /var/www/html/*
rm -rf /tmp/website

systemctl restart httpd.service php-fpm.service
systemctl enable httpd.service php-fpm.service 
