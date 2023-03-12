#!/bin/bash 
yum update -y 
yum –y install httpd
amazon-linux-extras install -y php7.2 
cd /tmp 
wget https://us-west-2-tcprod.s3.us-west-2.amazonaws.com/courses/ILT-TF-200-ARCHIT/v7.3.2.prod-6d2a9850/lab-4-HA/scripts/inventory-app.zip  
unzip inventory-app.zip -d /var/www/html/  
wget https://github.com/aws/aws-sdk-php/releases/download/3.62.3/aws.zip  
unzip -q aws.zip -d /var/www/html  
echo "<html><body><h1><span style='color:#FFB570'>Hello from EC2 web instance `curl http://169.254.169.254/latest/meta-data/instance-id`</span></h1><p>This server acts as an Apache nginx server</p></body></html>" > index.html 
mv index.html /var/www/html
systemctl start httpd.service  
systemctl enable httpd.service 