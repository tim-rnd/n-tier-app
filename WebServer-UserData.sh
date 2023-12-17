#!/bin/bash 
dnf update -y  && 
dnf install -y httpd && 
systemctl enable httpd.service  
systemctl start httpd  
cd /var/www/html 
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id > instance_id.txt
instance_id=`cat instance_id.txt`
random_color=$(($RANDOM + $RANDOM*100 + $RANDOM * 10))
echo "<html><body><h1><span style="color:$random_color">Hello from EC2 web instance $instance_id</span></h1><p>This server acts as an N-Tier-Application Apache http server</p></body></html>" > index.html 