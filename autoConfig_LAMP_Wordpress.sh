# Amazon EC2 Auto-Config
# LAMP Stack Setup
# RONGXIN LIU
# 2019

# Install System Updates
read -p "Perform System Update?" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  apt-get update && apt-get -y upgrade
fi

# Install System Utilities
read -p "Install System Utilities?" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  apt-get install -y vim nano curl unzip
fi

# Install and Configure Firewall
read -p "Install and Configure Firewall (ufw)?" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  apt-get install ufw
  ufw allow ssh
  ufw enable
  service ufw start && ufw status
fi

# Install Apache Server
read -p "Install Apache Server?" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  apt-get install -y apache2
  ufw app list
  ufw allow 'Apache'
  # Enable Rewrite Module
  a2enmod rewrite
  systemctl start apache2
  systemctl enable apache2
  apache2ctl configtest
fi

# Install MySQL Database
read -p "Install MySQL Database?" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  apt-get -y install mysql-server
  ufw allow mysql
  systemctl start mysql
  systemctl enable mysql
fi

# Install PHP
read -p "Install PHP?" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  apt-get install -y php libapache2-mod-php
  apt-get install -y php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip
fi

# Install phpMyAdmin
read -p "Install phpMyAdmin?" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  apt-get install -y phpmyadmin
  # Restart Apache Server
  systemctl restart apache2
fi

# Install Wordpress
read -p "Install Wordpress?" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  cd /var/www
  curl -O https://wordpress.org/latest.tar.gz
  tar xzvf latest.tar.gz
  rm -r html
  mv wordpress html
  chmod -R 777 html
fi

# Process finishes
echo Successfully install Apache, MySQL, phpMyAdmin, Wordpress
echo Next, please modify apache2.conf, which is located in /etc/apache2
