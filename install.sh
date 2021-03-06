#!/bin/bash

# Script by Joodle // Joodle.nl
# If you need help please contact me at joodle at joodle dot nl
# Tested on Debian 7 64 bit only


if [ $USER != 'root' ]; then
  echo "Please login as the root user!"
  exit
fi

{
  echo "Hiawatha + MariaDB + PHP5-FPM + SQLBuddy Installer"
  read -n1 -r -p "Are you ready? Press any key to start installing!"
}

# Updating + Upgrading the system and adding repository
apt-get update;apt-get upgrade -y;apt-get install python-software-properties -y
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db && add-apt-repository 'deb http://nwps.ws/pub/mariadb/repo/5.5/debian wheezy main'
apt-get update

# Installing MariaDB Server + Hiawatha + PHP5-FPM
apt-get install mariadb-server -y;apt-get install libxslt1.1 -y;wget http://files.tuxhelp.org/hiawatha/hiawatha_9.13_amd64.deb;dpkg -i hiawatha_9.13_amd64.deb;apt-get install php5 php-pear php5-common php5-curl php5-mysql php5-fpm php5-gd -y;apt-get install unzip -y
apt-get install -f

# We're going to download the PHP-FPM php.ini file now
rm /etc/php5/fpm/php.ini;wget --no-check-certificate -O /etc/php5/fpm/php.ini https://raw.githubusercontent.com/joodle/Hiawatha-MariaDB-PHP5-FPM-SQLBuddy/master/php.ini

# We're going to download the PHP-FPM config file (php-fpm.conf) now
rm /etc/php5/fpm/php-fpm.conf;wget --no-check-certificate -O /etc/php5/fpm/php-fpm.conf https://raw.githubusercontent.com/joodle/Hiawatha-MariaDB-PHP5-FPM-SQLBuddy/master/php-fpm.conf

# We're going to download the Hiawatha config file (hiawatha.conf) now
rm /etc/hiawatha/hiawatha.conf;wget --no-check-certificate -O /etc/hiawatha/hiawatha.conf https://raw.githubusercontent.com/joodle/Hiawatha-MariaDB-PHP5-FPM-SQLBuddy/master/hiawatha.conf

# Creating folder for the Hiawatha webserver
mkdir /var/www/first-site

# Restarting Hiawatha and PHP-FPM
service hiawatha restart;service php5-fpm restart

# Downloading and unzipping SQLBuddy
wget --no-check-certificate -O /var/www/hiawatha/sqlbuddy.zip https://github.com/calvinlough/sqlbuddy/raw/gh-pages/sqlbuddy.zip && unzip -d /var/www/hiawatha /var/www/hiawatha/sqlbuddy.zip && rm /var/www/hiawatha/sqlbuddy.zip


{
  echo "Done installing Hiawatha + MariaDB + PHP5-FPM + SQLBuddy"
  echo "You can access SQLBuddy using http://YOURIP/sqlbuddy/"
  echo "You can add websites using the hiawatha.conf file located at /etc/hiawatha/hiawatha.conf"
  echo "Simply copy and paste the content that is between # Modify thisto match your own website and # END and modify it to your liking"
  echo "To use SSL uncomment the lines between # SSL and # END SSL"
  echo "To apply the changes for the Hiawatha config type service hiawatha restart"
}
