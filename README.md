# Jarkom-Modul-2-E07-2022
| Nama                        | NRP        |
|:---------------------------:|:----------:|
| Arya Nur Razzaq             | 5025201102 |
| Florentino Benedictus       | 5025201222 |
| Muhammad Zufarrifqi Prakoso | 5025201276 |

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
6. Coba `ping www.wise.E07.com` atau `host -t CNAME www.wise.E07.com` pada client
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
### Jawaban

## Soal 6
### Jawaban
## Soal 7
### Jawaban

## Soal 8
### Jawaban

## Soal 9
### Jawaban

## Soal 10
### Jawaban

## Soal 11
### Jawaban

## Soal 12
### Jawaban

## Soal 13
### Jawaban

## Soal 14
### Jawaban

## Soal 15
### Jawaban

## Soal 16
### Jawaban

## Soal 17
### Jawaban
