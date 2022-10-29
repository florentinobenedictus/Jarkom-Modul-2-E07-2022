# Jarkom-Modul-2-E07-2022
| Nama                        | NRP        |
|:---------------------------:|:----------:|
| Arya Nur Razzaq             | 5025201102 |
| Florentino Benedictus       | 5025201222 |
| Muhammad Zufarrifqi Prakoso | 5025201276 |


#### [Konfigurasi Topologi](configure)
#### [Script Node](node)
#### [Script Router](router)
#### [Resources Google Drive](zip)
#### [Soal](soal)
- [Soal 1](#soal-1)
- [Soal 2](#soal-2)
- [Soal 3](#soal-3)
- [Soal 4](#soal-4)
- [Soal 5](#soal-5)
- [Soal 6](#soal-6)
- [Soal 7](#soal-7)
- [Soal 8](#soal-8)
- [Soal 9](#soal-9)
- [Soal 10](#soal-10)
- [Soal 11](#soal-11)
- [Soal 12](#soal-12)
- [Soal 13](#soal-13)
- [Soal 14](#soal-14)
- [Soal 15](#soal-15)
- [Soal 16](#soal-16)
- [Soal 17](#soal-17)
#### [Menjalankan Script](#menjalankan-script-1)
#### [Pembagian Tugas](#pembagian-tugas-1)
#### [Revisi](#revisi-1)
#### [Kendala](#kendala-1)

## Soal 1
WISE akan dijadikan sebagai DNS Master, Berlint akan dijadikan DNS Slave, dan Eden akan digunakan sebagai Web Server. Terdapat 2 Client yaitu SSS, dan Garden. Semua node terhubung pada router Ostania, sehingga dapat mengakses internet
### Jawaban
1. Buat Topologi dengan router Ostania dan node yang terdiri dari SSS, Garden, Berlint, dan Eden
![image](https://user-images.githubusercontent.com/85059763/198821212-9de55a05-d77b-4dfe-bd59-6e9526db3054.png)
2. Lakukan konfigurasi network dengan feature ```Edit network configuration``` untuk tiap router dan network dengan ketentuan sebagai berikut :
- Ostania
```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
	address 10.25.1.1
	netmask 255.255.255.0

auto eth2
iface eth2 inet static
	address 10.25.2.1
	netmask 255.255.255.0

auto eth3
iface eth3 inet static
	address 10.25.3.1
	netmask 255.255.255.0
```
- WISE
```
auto eth0
iface eth0 inet static
	address 10.25.2.2
	netmask 255.255.255.0
	gateway 10.25.2.1
```
- SSS
```
auto eth0
iface eth0 inet static
	address 10.25.1.2
	netmask 255.255.255.0
	gateway 10.25.1.1
```
- Garden
```
auto eth0
iface eth0 inet static
	address 10.25.1.3
	netmask 255.255.255.0
	gateway 10.25.1.1
```
- Berlint
```
auto eth0
iface eth0 inet static
	address 10.25.3.2
	netmask 255.255.255.0
	gateway 10.25.3.1
```
- Eden
```
auto eth0
iface eth0 inet static
	address 10.25.3.3
	netmask 255.255.255.0
	gateway 10.25.3.1
```
3. Lakukan `iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.25.0.0/16` pada router
4. Lakukan `echo nameserver 192.168.122.1 > /etc/resolv.conf` pada node selain router

## Soal 2
Untuk mempermudah mendapatkan informasi mengenai misi dari Handler, bantulah Loid membuat website utama dengan akses wise.yyy.com dengan alias www.wise.yyy.com pada folder wise
### Jawaban
1. Buka webconsole pada WISE & Berlint dan install bind karena kedua node akan dijadikan DNS Server
```
apt-get update
apt-get install bind9 -y
```
2. Lakukan konfigurasi pada `/etc/bind/wise/wise.E07.com` pada WISE
![Untitled](https://user-images.githubusercontent.com/85059763/198822645-199a9670-c819-46b6-ada5-68ae9a0a6c7e.jpg)
3. Lakukan konfigurasi pada `/etc/bind/named.conf.local` pada WISE
![Untitled](https://user-images.githubusercontent.com/85059763/198822777-cf23cae4-74fb-425e-82bf-110090e99cf4.jpg)
4. Konfigurasi `/etc/resolv.conf` client dengan urutan sebagai berikut
```
nameserver 10.25.2.2 # IP WISE
nameserver 10.25.3.2 # IP Berlint
nameserver 192.168.122.1
```
5. Restart bind dengan `service bind9 restart` pada WISE
6. Install dnsutils pada client
```
apt-get install dnsutils -y &
```
7. Coba `ping www.wise.E07.com` atau `host -t CNAME www.wise.E07.com` pada client
![Untitled](https://user-images.githubusercontent.com/85059763/198822866-fd2a627f-f1c5-4833-a581-8f5287170d43.jpg)

## Soal 3
Setelah itu ia juga ingin membuat subdomain eden.wise.yyy.com dengan alias www.eden.wise.yyy.com yang diatur DNS-nya di WISE dan mengarah ke Eden
### Jawaban
1. Lakukan konfigurasi pada `/etc/bind/wise/wise.E07.com` pada WISE
![Untitled](https://user-images.githubusercontent.com/85059763/198823118-25e052ce-48a6-4018-8629-4b2532910133.jpg)
2. Restart bind dengan `service bind9 restart` pada WISE
3. Coba `ping www.eden.wise.E07.com` atau `host -t CNAME www.eden.wise.E07.com` pada client
![Untitled](https://user-images.githubusercontent.com/85059763/198823190-3f130420-6439-476b-8bb5-3aee5a47bd76.png)

## Soal 4
Buat juga reverse domain untuk domain utama
### Jawaban
1. Lakukan konfigurasi pada `/etc/bind/wise/2.25.10.in-addr.arpa` pada WISE
![Untitled](https://user-images.githubusercontent.com/85059763/198823336-fee1dd75-0dbb-4050-83a9-242bd83a9c7e.png)
2. Lakukan konfigurasi pada `/etc/bind/named.conf.local` pada WISE
![Untitled](https://user-images.githubusercontent.com/85059763/198823385-b43d0e74-a95b-474a-83c8-ab011fa24194.png)
3. Restart bind dengan `service bind9 restart` pada WISE
4. `host -t PTR 10.25.2.2` pada client <br>
![Untitled](https://user-images.githubusercontent.com/85059763/198823411-f711171e-e7a9-4199-b1ea-2f61e8c55f0f.png)

## Soal 5
Agar dapat tetap dihubungi jika server WISE bermasalah, buatlah juga Berlint sebagai DNS Slave untuk domain utama
### Jawaban
1. Konfigurasi `also-notify` dan `allow-transfer` ke IP Berlint pada `/etc/bind/named.conf.local` WISE
![Untitled](https://user-images.githubusercontent.com/85059763/198825525-9d48ee03-44e0-4968-8dd8-5a78f346a131.png)
2. Konfigurasi `/etc/bind/named.conf.local` pada Berlint
![Untitled](https://user-images.githubusercontent.com/85059763/198825581-84bda6f4-694a-4716-bb85-191d0f465a7b.png)
3. Restart bind pada Berlint dengan `service bind9 restart`, lalu stop bind pada WISE dengan `service bind9 stop`
4. Coba `ping www.wise.E07.com` pada client <br>
![Untitled](https://user-images.githubusercontent.com/85059763/198825713-a21e6ac8-7d1a-45b2-8c69-88205ce58f22.png)

## Soal 6
Karena banyak informasi dari Handler, buatlah subdomain yang khusus untuk operation yaitu operation.wise.yyy.com dengan alias www.operation.wise.yyy.com yang didelegasikan dari WISE ke Berlint dengan IP menuju ke Eden dalam folder operation
### Jawaban
1. Konfigurasi `/etc/bind/wise/wise.E07.com` pada WISE
![Untitled](https://user-images.githubusercontent.com/85059763/198825796-45e34674-15c9-42ed-95ab-1881d8639599.png)
2. Konfigurasi `/etc/bind/named.conf.options` pada WISE (tambahkan forwarder ke Berlint dan Router, comment dnssec-validation auto, tambahkan `allow-query{any;};`)
![Untitled](https://user-images.githubusercontent.com/85059763/198825843-981db919-417f-484f-9435-cd8322e302ad.png)
3. Konfigurasi `/etc/bind/operation/operation.wise.E07.com` pada Berlint
![Untitled](https://user-images.githubusercontent.com/85059763/198825904-b99acbbf-0d75-4f97-8780-e503347e2d12.png)
4. Konfigurasi `/etc/bind/named.conf.options` pada Berlint (tambahkan forwarder ke WISE, comment dnssec-validation auto, tambahkan `allow-query{any;};`)
![Untitled](https://user-images.githubusercontent.com/85059763/198825940-6fe37999-38bc-4af5-a208-283878600242.png)
5. Restart bind pada WISE dan Berlint dengan `service bind9 restart`
6. Coba `ping www.operation.wise.E07.com` atau `host -t CNAME www.operation.wise.E07.com` pada client <br>
![Untitled](https://user-images.githubusercontent.com/85059763/198826263-e0667676-d17e-4565-933e-0994566ff2e7.png)

## Soal 7
Untuk informasi yang lebih spesifik mengenai Operation Strix, buatlah subdomain melalui Berlint dengan akses strix.operation.wise.yyy.com dengan alias www.strix.operation.wise.yyy.com yang mengarah ke Eden
### Jawaban
1. Konfigurasi `/etc/bind/operation/operation.wise.E07.com` pada Berlint
![Untitled](https://user-images.githubusercontent.com/85059763/198826124-1bd25000-1ebf-4c9b-875a-6a7792554e58.png)
2. Restart bind pada WISE dan Berlint dengan `service bind9 restart`
3. Coba `ping www.strix.operation.wise.E07.com` atau `host -t CNAME www.strix.operation.wise.E07.com` pada client <br>
![Untitled](https://user-images.githubusercontent.com/85059763/198826242-320eecc3-60ba-47be-859f-6c9c67046cff.png)

## Soal 8
Setelah melakukan konfigurasi server, maka dilakukan konfigurasi Webserver. Pertama dengan webserver www.wise.yyy.com. Pertama, Loid membutuhkan webserver dengan DocumentRoot pada /var/www/wise.yyy.com
### Jawaban
1. Instalasi pada Eden
```
apt-get update
apt-get install apache2 -y
apt-get install php -y
apt-get install wget -y
apt-get install unzip -y
apt-get install libapache2-mod-php7.0 -y
```
2. Instalasi lynx pada client
```
apt-get install lynx -y
```
3. Download file `wise.zip` dari google drive, unzip, lalu rename dan pindahkan directory ke path `/var/www/wise.E07.com` pada Eden
```
wget --no-check-certificate "https://drive.google.com/uc?export=download&id=1S0XhL9ViYN7TyCj2W66BNEXQD2AAAw2e" -O wise.zip
unzip /root/wise.zip -d /var/www
mv /var/www/wise /var/www/wise.E07.com
rm wise.zip
```
4. Buat konfigurasi `/etc/apache2/sites-available/wise.E07.com.conf` pada Eden
```
<VirtualHost *:80>
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
# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
```
5. Disable konfigurasi default dan enable konfigurasi `wise.E07.com.conf` pada Eden
```
a2dissite 000-default.conf
a2ensite wise.E07.com.conf
```
6. Restart apache2 pada Eden dengan `service apache2 restart`
7. `lynx www.wise.E07.com` pada client
![Untitled](https://user-images.githubusercontent.com/85059763/198826601-894184f6-7028-4705-8759-dde3b2b7807b.png)

## Soal 9
Setelah itu, Loid juga membutuhkan agar url www.wise.yyy.com/index.php/home dapat menjadi menjadi www.wise.yyy.com/home
### Jawaban
1. Tambahkan `Alias "/home" "/var/www/wise.E07.com/index.php/home"` pada `/etc/apache2/sites-available/wise.E07.com.conf` pada Eden sehingga menjadi
```
<VirtualHost *:80>
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
# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
```
2. Restart apache2 pada Eden dengan `service apache2 restart`
3. `lynx www.wise.E07.com/home` atau `lynx www.wise.E07.com/index.php/home` pada client akan menuju halaman yang sama
![Untitled](https://user-images.githubusercontent.com/85059763/198826885-4a418575-bb23-48f0-9d86-1e940535e75b.png)


## Soal 10
Setelah itu, pada subdomain www.eden.wise.yyy.com, Loid membutuhkan penyimpanan aset yang memiliki DocumentRoot pada /var/www/eden.wise.yyy.com
### Jawaban
1. Download file `eden.wise.zip` dari google drive, unzip, lalu rename dan pindahkan directory ke path `/var/www/eden.wise.E07.com` pada Eden
```
wget --no-check-certificate "https://drive.google.com/uc?id=1q9g6nM85bW5T9f5yoyXtDqonUKKCHOTV" -O eden.wise.zip
unzip /root/eden.wise.zip -d /var/www
mv /var/www/eden.wise /var/www/eden.wise.E07.com
rm eden.wise.zip
```
2. Buat konfigurasi `/etc/apache2/sites-available/eden.wise.E07.com.conf` pada Eden
```
<VirtualHost *:80>
        ServerName eden.wise.E07.com
        ServerAlias www.eden.wise.E07.com
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/eden.wise.E07.com
	
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
# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
```
3. Enable konfigurasi `wise.E07.com.conf` pada Eden
```
a2ensite eden.wise.E07.com.conf
```
4. Restart apache2 pada Eden dengan `service apache2 restart`
5. `lynx www.eden.wise.E07.com` pada client
![Untitled](https://user-images.githubusercontent.com/85059763/198827139-2bcbc331-21eb-448a-951b-b0a290c900ed.png)

## Soal 11
Akan tetapi, pada folder /public, Loid ingin hanya dapat melakukan directory listing saja
### Jawaban
1. Tambahkan tag Directory pada `/etc/apache2/sites-available/eden.wise.E07.com.conf` Eden
```
<Directory /var/www/eden.wise.E07.com/public>
        Options +Indexes
</Directory>
```
Sehingga konfigurasinya menjadi:
```
<VirtualHost *:80>
        ServerName eden.wise.E07.com
        ServerAlias www.eden.wise.E07.com
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/eden.wise.E07.com
	
	<Directory /var/www/eden.wise.E07.com/public>
		Options +Indexes
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
# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
```
2. Restart apache2 pada Eden dengan `service apache2 restart` 
3. `lynx www.eden.wise.E07.com/public` pada client, terlihat dapat dilakukan directory listing
![Untitled](https://user-images.githubusercontent.com/85059763/198827381-f3608349-c8b1-48cf-9651-a103fbb26912.png)

## Soal 12
Tidak hanya itu, Loid juga ingin menyiapkan error file 404.html pada folder /error untuk mengganti error kode pada apache
### Jawaban
1. Tambahkan `ErrorDocument 404 /error/404.html` pada `/etc/apache2/sites-available/eden.wise.E07.com.conf` Eden sehingga konfigurasinya menjadi
```
<VirtualHost *:80>
        ServerName eden.wise.E07.com
        ServerAlias www.eden.wise.E07.com
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/eden.wise.E07.com
	
	<Directory /var/www/eden.wise.E07.com/public>
		Options +Indexes
	</Directory>
	
	ErrorDocument 404 /error/404.html
	
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
# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
```
2. Restart apache2 pada Eden dengan `service apache2 restart` 
3. `lynx www.eden.wise.E07.com/test` pada client, maka akan menampilkan error 404 not found yang telah menggunakan `/error.404.html`
![Untitled](https://user-images.githubusercontent.com/85059763/198827561-42ae8e16-77a2-4628-a3c3-bee4a76ac47e.png)

## Soal 13
Loid juga meminta Franky untuk dibuatkan konfigurasi virtual host. Virtual host ini bertujuan untuk dapat mengakses file asset www.eden.wise.yyy.com/public/js menjadi www.eden.wise.yyy.com/js
### Jawaban
1. Tambahkan `Alias "/js" "/var/www/eden.wise.E07.com/public/js"` pada `/etc/apache2/sites-available/eden.wise.E07.com.conf` Eden sehingga konfigurasinya menjadi
```
<VirtualHost *:80>
        ServerName eden.wise.E07.com
        ServerAlias www.eden.wise.E07.com
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/eden.wise.E07.com
	
	<Directory /var/www/eden.wise.E07.com/public>
		Options +Indexes
	</Directory>
	
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
# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
```
2. Restart apache2 pada Eden dengan `service apache2 restart` 
3. `lynx www.eden.wise.E07.com/js` pada client, maka akan menampilkan halaman `eden.wise.E07.com/public/js`
![Untitled](https://user-images.githubusercontent.com/85059763/198827651-bafd9712-1a20-486d-b6d3-7c0ce932bdf3.png)

## Soal 14
Loid meminta agar www.strix.operation.wise.yyy.com hanya bisa diakses dengan port 15000 dan port 15500
### Jawaban
1. Download file `strix.operation.wise.zip` dari google drive, unzip, lalu rename dan pindahkan directory ke path `/var/www/eden.wise.E07.com` pada Eden
```
wget --no-check-certificate "https://drive.google.com/uc?export=download&id=1bgd3B6VtDtVv2ouqyM8wLyZGzK5C9maT" -O strix.operation.wise.zip
unzip /root/strix.operation.wise.zip -d /var/www
mv /var/www/strix.operation.wise /var/www/strix.operation.wise.E07.com
rm strix.operation.wise.zip
```
2. Buat konfigurasi `/etc/apache2/sites-available/strix.operation.wise.E07.com.conf` pada Eden dengan `<VirtualHost *:15000 *:15500>`
```
<VirtualHost *:15000 *:15500>
        ServerName strix.operation.wise.E07.com
        ServerAlias www.strix.operation.wise.E07.com
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/strix.operation.wise.E07.com
	
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
# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
```
3. Tambahkan `Listen 15000` dan  `Listen 15500` pada `/etc/apache2/ports.conf` Eden
```
# If you just change the port or add more ports here, you will likely also
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
# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
```
4. Enable konfigurasi `strix.operation.E07.com.conf` pada Eden
```
a2ensite strix.operation.wise.E07.com.conf
```
5. Restart apache2 pada Eden dengan `service apache2 restart`
6. `lynx www.strix.operation.wise.E07.com:15000` atau lynx `www.strix.operation.wise.E07.com:15500` pada client
![Untitled](https://user-images.githubusercontent.com/85059763/198828163-6f114773-292b-4639-9dc8-0b0c1c2f6bcd.png)

## Soal 15
dengan autentikasi username Twilight dan password opStrix dan file di /var/www/strix.operation.wise.yyy
### Jawaban
1. Tambahkan tag directory pada `/etc/apache2/sites-available/strix.operation.wise.E07.com.conf`
```
<Directory /var/www/strix.operation.wise.E07.com>
        AuthType Basic
        AuthName "Restricted Files"
        AuthUserFile /etc/apache2/.htpasswd
        Require valid-user
</Directory>
```
Sehingga konfigurasinya menjadi:
```
<VirtualHost *:15000 *:15500>
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
# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
```
2. `htpasswd -cb /etc/apache2/.htpasswd Twilight opStrix` pada Eden untuk konfigurasi autentikasi username Twilight dan password opStrix
3. Restart apache2 pada Eden dengan `service apache2 restart`
4. `lynx www.strix.operation.wise.E07.com:15000` atau lynx `www.strix.operation.wise.E07.com:15500` pada client, maka sekarang client akan diminta memasukkan username dan password yang sesuai
![Untitled](https://user-images.githubusercontent.com/85059763/198828530-e60bb8b4-96be-4368-a7d3-dd2a773e1ac6.png)

## Soal 16
dan setiap kali mengakses IP Eden akan dialihkan secara otomatis ke www.wise.yyy.com
### Jawaban
1. Buat konfigurasi `/etc/apache2/sites-available/ip.redirect.conf` pada Eden dengan `Redirect 301 / http://www.wise.E07.com`
```
<VirtualHost *:80>
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
# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
```
2. Enable konfigurasi `a2ensite ip.redirect.conf` pada Eden
3. Restart apache2 pada Eden dengan `service apache2 restart`
4. `hostname -I` pada Eden untuk mengetahui IP Eden <br>
![Untitled](https://user-images.githubusercontent.com/85059763/198828676-8a8f806d-648d-4eb7-9a2e-017d92cbf7d4.png) <br>
5. `lynx 10.25.3.3` pada client, maka akan diarahkan ke `www.wise.E07.com`
![Untitled](https://user-images.githubusercontent.com/85059763/198828732-30ee0ae0-81f8-4296-8959-61e0c4077f20.png)

## Soal 17
Karena website www.eden.wise.yyy.com semakin banyak pengunjung dan banyak modifikasi sehingga banyak gambar-gambar yang random, maka Loid ingin mengubah request gambar yang memiliki substring “eden” akan diarahkan menuju eden.png. Bantulah Agent Twilight dan Organisasi WISE menjaga perdamaian!
### Jawaban
1. Tambahkan tag directory pada `/etc/apache2/sites-available/eden.wise.E07.com.conf`
```
<Directory /var/www/eden.wise.E07.com>
        Options +FollowSymLinks -Multiviews
        AllowOverride All
</Directory>
```
Sehingga konfigurasinya menjadi:
```
<VirtualHost *:80>
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
# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
```
2. Edit isi `/var/www/eden.wise.E07.com/.htaccess` sehingga akan mengecek regular expression dan akan mengarahkan gambar dengan substring eden menuju `eden.wise.E07.com/public/images/eden.png`. `!=/public/images/eden.png` digunakan agar ketika mengakses file `eden.wise.E07.com/public/images/eden.png` sendiri maka tidak akan diredirect. `!=` dan absolute path digunakan karena kemungkinan adanya file dengan nama yang sama (eden.png) tetapi diletakkan pada directory lain tidak diredirect ke `eden.png` yang sebenarnya.
```
RewriteEngine On
RewriteBase /
RewriteCond %{REQUEST_URI} !=/public/images/eden.png
RewriteRule (.*eden.*)\.(png|jpg|gif)$ http://eden.wise.E07.com/public/images/eden.png [L,R=301]
```
3. Aktifkan modul rewrite pada Eden
```
a2enmod rewrite
```
4. Restart apache2 pada Eden dengan `service apache2 restart`
5. `lynx www.eden.wise.E07.com/public/images` pada client, lalu tes redirection ketika memilih suatu file.
![Untitled](https://user-images.githubusercontent.com/85059763/198829447-24db0c1e-a192-435a-9502-1647b4378b10.png)
![Untitled](https://user-images.githubusercontent.com/85059763/198829496-caf02129-5f62-44a2-9b00-e0486f61b893.png)

## Menjalankan Script
1. Import Project GNS3
2. Start project
3. Restart seluruh node
4. `bash ./script.sh` pada seluruh node dimulai dari router (agar node lainnya dapat terhubung ke internet)
5. Seluruh fungsionalitas sudah dapat digunakan

## Pembagian Tugas
| Nama                        | Nomor      |
|:---------------------------:|:----------:|
| Arya Nur Razzaq             | 6 - 11     |
| Florentino Benedictus       | 12 - 17    |
| Muhammad Zufarrifqi Prakoso | 1 - 5      |

## Revisi
Tidak ada

## Kendala
Tidak ada