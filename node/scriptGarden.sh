# IP Ping tidak sesuai? nano /etc/resolv.conf langsung tutup lagi

echo 'nameserver 10.25.2.2 # IP WISE
nameserver 10.25.3.2 # IP Berlint
nameserver 192.168.122.1' > /etc/resolv.conf

apt-get update &
wait
apt-get install dnsutils -y &
wait
apt-get install lynx -y &
wait
