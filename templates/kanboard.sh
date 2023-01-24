#!/bin/bash
sudo apt update -y
sudo apt install -y apache2 libapache2-mod-php php-cli php-mbstring php-sqlite3 php-opcache php-json php-mysql php-pgsql php-ldap php-gd php-xml
php -v
sudo systemctl enable apache2
sudo systemctl restart apache2
cd /tmp
wget -c https://github.com/kanboard/kanboard/archive/refs/tags/v1.2.26.zip
sudo apt install zip -y
sudo unzip v1.2.26.zip -d /var/www/html/
sudo mv /var/www/html/kanboard-1.2.26/ /var/www/html/kanboard
sudo chown -R www-data:www-data /var/www/html/kanboard/
sudo chmod -R 755 /var/www/html/kanboard/
sudo sed -i "s/'DB_DRIVER', 'sqlite'/'DB_DRIVER', 'postgres'/g" /var/www/html/kanboard/config.default.php
sudo sed -i "s/'DB_USERNAME', 'root'/'DB_USERNAME', 'kanban'/g" /var/www/html/kanboard/config.default.php
sudo sed -i "s/'DB_PASSWORD', ''/'DB_PASSWORD', 'mypassword'/g" /var/www/html/kanboard/config.default.php
sudo sed -i "s/'DB_HOSTNAME', 'localhost'/'DB_HOSTNAME', '${private_ip}'/g" /var/www/html/kanboard/config.default.php
sudo sed -i "s/'DB_PORT', 'null'/'DB_PORT', '5432'/g" /var/www/html/kanboard/config.default.php
sudo systemctl restart apache2