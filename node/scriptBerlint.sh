echo 'nameserver 10.25.2.2 # IP WISE
nameserver 10.25.3.2 # IP Berlint
nameserver 192.168.122.1' > /etc/resolv.conf

apt-get update
apt-get install bind9 -y

echo 'zone "wise.E07.com" {
    type slave;
    masters { 10.25.2.2; }; // IP WISE
    file "/var/lib/bind/wise.E07.com";
};' > /etc/bind/named.conf.local

service bind9 restart
# rndc: connect failed: 127.0.0.1#953: connection refused ketika restart?
# buka /etc/bind/named.conf.local remove endline paling terakhir, penyakit memang
service bind9 restart