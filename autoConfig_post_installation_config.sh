# Amazon EC2 Auto-Config
# RONGXIN LIU
# 2019

# Install WordPress
read -p "Post-configuration for WordPress?" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  cd /var/www/html
  sed -i "/^define( 'DB_COLLATE', '' );.*/a\ \n/** This function allows the current user to edit or install files in your folder. **/\ndefine('FS_METHOD', 'direct');\n" wp-config.php
  echo "# BEGIN WordPress" > .htaccess
  sed -i "$ a <IfModule mod_rewrite.c>" .htaccess
  sed -i "$ a RewriteEngine On" .htaccess
  sed -i "$ a RewriteBase /" .htaccess
  sed -i "$ a RewriteRule ^index\\\.php$ - [L]" .htaccess
  sed -i "$ a RewriteCond %{REQUEST_FILENAME} \!-f" .htaccess
  sed -i "$ a RewriteCond %{REQUEST_FILENAME} \!-d" .htaccess
  sed -i "$ a RewriteRule . /index.php [L]" .htaccess
  sed -i "$ a </IfModule>" .htaccess
  sed -i "$ a # END WordPress" .htaccess
  systemctl restart apache2
fi
