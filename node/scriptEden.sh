echo 'nameserver 192.168.122.1
nameserver 10.25.2.2 # IP WISE
nameserver 10.25.3.2 # IP Berlint' > /etc/resolv.conf

apt-get update
apt-get install apache2 -y

echo 'nameserver 10.25.2.2 # IP WISE
# nameserver 10.25.3.2 # IP Berlint
nameserver 192.168.122.1' > /etc/resolv.conf

