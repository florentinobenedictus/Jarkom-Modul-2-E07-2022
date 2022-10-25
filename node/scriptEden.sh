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

echo '<VirtualHost *:8080>

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
Listen 8080

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

a2dissite 000-default.conf 
a2ensite wise.E07.com.conf
service apache2 restart




echo 'nameserver 10.25.2.2 # IP WISE
nameserver 10.25.3.2 # IP Berlint
nameserver 192.168.122.1' > /etc/resolv.conf