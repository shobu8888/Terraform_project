#!/bin/bash
apt-get update -y
apt-get install -y apache2
systemctl start apache2
systemctl enable apache2
echo "hi there tf is awesome" | sudo tee /var/www/html/index.html