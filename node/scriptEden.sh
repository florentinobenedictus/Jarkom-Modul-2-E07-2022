echo 'nameserver 192.168.122.1
nameserver 10.25.2.2 # IP WISE
nameserver 10.25.3.2 # IP Berlint' > /etc/resolv.conf

apt-get update
apt-get install apache2 -y
apt-get install php -y
apt-get install wget -y
apt-get install unzip -y



cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/wise.E07.com.conf

echo '<VirtualHost *:80>

        ServerName wise.E07.com   
        ServerAlias www.wise.E07.com
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/wise.E07.com

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

wget --no-check-certificate "https://drive.google.com/uc?export=download&id=1S0XhL9ViYN7TyCj2W66BNEXQD2AAAw2e" -O wise.zip 
unzip /root/wise.zip -d /var/www
mv /var/www/wise /var/www/wise.E07.com
rm wise.zip

a2dissite 000-default.conf 
a2ensite wise.E07.com.conf
service apache2 restart




echo 'nameserver 10.25.2.2 # IP WISE
nameserver 10.25.3.2 # IP Berlint
nameserver 192.168.122.1' > /etc/resolv.conf