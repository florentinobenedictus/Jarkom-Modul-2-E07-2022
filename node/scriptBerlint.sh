echo '#nameserver 10.25.2.2 # IP WISE
#nameserver 10.25.3.2 # IP Berlint
nameserver 192.168.122.1' > /etc/resolv.conf

apt-get update &
wait
apt-get install bind9 -y &
wait

echo 'zone "operation.wise.E07.com" {
    type master;
    file "/etc/bind/operation/operation.wise.E07.com";
};

zone "wise.E07.com" {
    type slave;
    masters { 10.25.2.2; }; // IP WISE
    file "/var/lib/bind/wise.E07.com";
};' > /etc/bind/named.conf.local

echo 'options {

        forwarders {
             10.25.2.2;
        };

        //dnssec-validation auto;
        allow-query{any;};

        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};' > /etc/bind/named.conf.options

mkdir /etc/bind/operation
cp /etc/bind/db.local /etc/bind/operation/operation.wise.E07.com
echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     operation.wise.E07.com. root.operation.wise.E07.com. (
                     2022102501         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      operation.wise.E07.com.
@       IN      A       10.25.3.3       ; IP Eden
strix   IN      A       10.25.3.3       ; IP Eden
www     IN      CNAME   operation.wise.E07.com.
www.strix       IN      CNAME   strix.operation.wise.E07.com.' > /etc/bind/operation/operation.wise.E07.com

service bind9 restart
# rndc: connect failed: 127.0.0.1#953: connection refused ketika restart?
# buka /etc/bind/named.conf.local remove endline paling terakhir, penyakit memang
service bind9 restart