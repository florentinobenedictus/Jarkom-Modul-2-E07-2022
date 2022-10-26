echo 'nameserver 192.168.122.1
nameserver 10.25.2.2 # IP WISE
nameserver 10.25.3.2 # IP Berlint' > /etc/resolv.conf

apt-get update &
wait
apt-get install apache2 -y &
wait
apt-get install php -y &
wait
apt-get install wget -y &
wait
apt-get install unzip -y &
wait
apt-get install libapache2-mod-php7.0 -y &
wait



cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/wise.E07.com.conf

echo '<VirtualHost *:80>

        ServerName wise.E07.com
        ServerAlias www.wise.E07.com
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/wise.E07.com

        Alias "/home" "/var/www/wise.E07.com/index.php/home"

        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn
        
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet' > /etc/apache2/sites-available/wise.E07.com.conf

echo '# If you just change the port or add more ports here, you will likely also
# have to change the VirtualHost statement in
# /etc/apache2/sites-enabled/000-default.conf

Listen 80
Listen 15000
Listen 15500

<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet' > /etc/apache2/ports.conf

wget --no-check-certificate "https://drive.google.com/uc?export=download&id=1S0XhL9ViYN7TyCj2W66BNEXQD2AAAw2e" -O wise.zip &
wait $!
unzip /root/wise.zip -d /var/www &
wait $!
mv /var/www/wise /var/www/wise.E07.com
rm wise.zip



wget --no-check-certificate "https://drive.google.com/uc?id=1q9g6nM85bW5T9f5yoyXtDqonUKKCHOTV" -O eden.wise.zip &
wait $!
unzip /root/eden.wise.zip -d /var/www &
wait $!
mv /var/www/eden.wise /var/www/eden.wise.E07.com
rm eden.wise.zip

echo '<VirtualHost *:80>

        ServerName eden.wise.E07.com
        ServerAlias www.eden.wise.E07.com
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/eden.wise.E07.com

        <Directory /var/www/eden.wise.E07.com>
                Options +FollowSymLinks -Multiviews
                AllowOverride All
        </Directory>

        <Directory /var/www/eden.wise.E07.com/public>
                Options +Indexes
        </Directory>

        # <Directory /var/www/eden.wise.E07.com/public/*>
        #         Options -Indexes
        # </Directory>

        ErrorDocument 404 /error/404.html

        Alias "/js" "/var/www/eden.wise.E07.com/public/js"

        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn
        
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet' > /etc/apache2/sites-available/eden.wise.E07.com.conf


wget --no-check-certificate "https://drive.google.com/uc?export=download&id=1bgd3B6VtDtVv2ouqyM8wLyZGzK5C9maT" -O strix.operation.wise.zip &
wait $!
unzip /root/strix.operation.wise.zip -d /var/www &
wait $!
mv /var/www/strix.operation.wise /var/www/strix.operation.wise.E07.com
rm strix.operation.wise.zip

echo '<VirtualHost *:15000 *:15500>

        ServerName strix.operation.wise.E07.com
        ServerAlias www.strix.operation.wise.E07.com
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/strix.operation.wise.E07.com

        <Directory /var/www/strix.operation.wise.E07.com>
                AuthType Basic
                AuthName "Restricted Files"
                AuthUserFile /etc/apache2/.htpasswd
                Require valid-user
        </Directory>

        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn
        
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet' > /etc/apache2/sites-available/strix.operation.wise.E07.com.conf


htpasswd -cb /etc/apache2/.htpasswd Twilight opStrix


echo '<VirtualHost *:80>

        ServerName http://10.25.3.3
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/eden.wise.E07.com

        Redirect 301 / http://www.wise.E07.com

        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn
        
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet' > /etc/apache2/sites-available/ip.redirect.conf

echo 'RewriteEngine On
RewriteBase /
RewriteCond %{REQUEST_URI} !=/public/images/eden.png
RewriteRule (.*eden.*)\.(png|jpg|gif)$ http://eden.wise.E07.com/public/images/eden.png [L,R=301]' > /var/www/eden.wise.E07.com/.htaccess


a2dissite 000-default.conf 
a2ensite wise.E07.com.conf
a2ensite eden.wise.E07.com.conf
a2ensite strix.operation.wise.E07.com.conf
a2ensite ip.redirect.conf

a2enmod rewrite

service apache2 restart




echo 'nameserver 10.25.2.2 # IP WISE
nameserver 10.25.3.2 # IP Berlint
nameserver 192.168.122.1' > /etc/resolv.conf