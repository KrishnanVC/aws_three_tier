#!/bin/bash
# Install and start Nginx
# sudo yum update -y
# sudo yum install -y nginx
# sudo service nginx start
cd ~
curl -o index.html $APP_SERVER_URL
python3 -m http.server 80