#!/bin/bash

apt-get update -y
apt-get install -y nginx
systemctl start nginx
systemctl enable nginx

echo "server {
    listen 80;

    location / {
        proxy_pass http://fabibucket-terraform-static.s3-website-sa-east-1.amazonaws.com;
    }

}" > default/etc/nginx/sites-available/