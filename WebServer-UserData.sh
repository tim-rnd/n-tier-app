#!/bin/bash 
yum update -y &&
amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2 &&
yum install -y httpd &&
systemctl enable httpd.service
systemctl start httpd
cd /var/www/html
wget  https://us-west-2-tcprod.s3.amazonaws.com/courses/ILT-TF-200-ARCHIT/v7.3.2.prod-6d2a9850/lab-2-VPC/scripts/instanceData.zip
unzip instanceData.zip