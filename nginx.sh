#! /bin/bash

sleep 30 

# Update packages and install Nginx server with Unzip
sudo apt update
sudo apt install nginx -y
sudo apt install unzip -y

# Unzip htmls files
cd /home/ubuntu/
sudo unzip html_files.zip

# Remove default nginx html file 
sudo rm /var/www/html/index.nginx-debian.html

# Copy new html files
sudo cp /home/ubuntu/html_files/index.nginx-debian.html /var/www/html/
sudo cp /home/ubuntu/html_files/nginx.png /var/www/html/

# Add hostname of instance to html file
var_hostname="$(hostname -f)"
sudo sed -i 's/var_hostname/'$var_hostname'/' /var/www/html/index.nginx-debian.html
