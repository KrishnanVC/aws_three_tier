#!/bin/bash
cd ~
echo "Hello world from app server" > index.html
sudo python3 -m http.server 80 