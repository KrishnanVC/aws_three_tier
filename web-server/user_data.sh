#!/bin/bash
# Install and start Nginx
# sudo yum update -y
# sudo yum install -y nginx
# sudo service nginx start
cd ~
echo "Hello World" > index.html
python3 -m http.server 80