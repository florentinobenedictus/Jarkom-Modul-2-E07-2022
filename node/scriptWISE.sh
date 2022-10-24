echo 'nameserver 192.168.122.1' > /etc/resolv.conf

apt-get update
apt-get install bind9 -y

echo 'zone "wise.E07.com" {
    type master;
    notify yes;
    also-notify { 10.25.3.2; }; // IP Berlint
    allow-transfer { 10.25.3.2; }; // IP Berlint
    file "/etc/bind/wise/wise.E07.com";
};

zone "2.25.10.in-addr.arpa" {
    type master;
    file "/etc/bind/wise/2.25.10.in-addr.arpa";
};' > /etc/bind/named.conf.local

mkdir /etc/bind/wise
cp /etc/bind/db.local /etc/bind/wise/wise.E07.com


echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     wise.E07.com. root.wise.E07.com. (
                     2022102401         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      wise.E07.com.
@       IN      A       10.25.2.2       ; # IP BIND
www     IN      CNAME   wise.E07.com.
eden    IN      A       10.25.3.3       ; # IP Eden
www.eden        IN      CNAME   eden.wise.E07.com.
ns1     IN      A       10.25.3.2       ; # IP Berlint
operation       IN      NS      ns1
@       IN      AAAA    ::1' > /etc/bind/wise/wise.E07.com



cp /etc/bind/db.local /etc/bind/wise/2.25.10.in-addr.arpa


echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     wise.E07.com. root.wise.E07.com. (
                     2022102401         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
2.25.10.in-addr.arpa.   IN      NS      wise.E07.com.
2                       IN      PTR     wise.E07.com. ; # Byte ke-4 WISE
' > /etc/bind/wise/2.25.10.in-addr.arpa



echo 'options {
        directory "/var/cache/bind";

        forwarders {
                192.168.122.1;
        };
        
        //dnssec-validation auto;
        allow-query{any;};

        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};' > /etc/bind/named.conf.options

service bind9 restart
# rndc: connect failed: 127.0.0.1#953: connection refused ketika restart?
# buka /etc/bind/wise/wise.E07.com remove endline paling terakhir, penyakit memang
service bind9 restart