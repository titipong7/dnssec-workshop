
docker run --rm -d -h grp1-soa --name=grp1-soa --net=wsnet --ip=10.0.0.66 --dns=203.159.70.209 --dns=203.159.77.77 -e TZ=UTC -p 31053:53 -p 31053:53/udp ubuntu/bind9:9.18-22.04_beta
docker exec -it grp1-soa /bin/bash


docker run --rm -d -h grp1-ns1 --name=grp1-ns1 --net=wsnet --ip=10.0.0.30 --dns=203.159.70.209 --dns=203.159.77.77 -e TZ=UTC -p 30053:53 -p 30053:53/udp ubuntu/bind9:9.18-22.04_beta

docker exec -it grp1-ns1 /bin/bash

mkdir -p /etc/bind/zones
touch /etc/bind/zones/db.grp1.secondary

zone "grp1.th.te-labs.training" {
    type secondary;
    file "/etc/bind/zones/db.grp1.secondary";
    masters { 10.0.0.66; };
};

docker run \
        --name=grp1-ns2 \
        --restart=always \
        --net=wsnet \
        --ip=10.0.0.131 \
        --dns=203.159.70.209 \
        --dns=203.159.77.77  \
        internetsystemsconsortium/bind9:9.20

docker run --rm -d -h ns1.mailthai.in.th --net=wsnet --ip=10.0.0.53 --dns=203.159.70.209 --dns=203.159.77.77 --name=ns1 thnicf/wsdns:latest


dnssec-keygen -a RSASHA256 -b 2048 -n ZONE grp1.th.te-labs.training
dnssec-keygen -f KSK -a RSASHA256 -b 2048 -n ZONE grp1.th.te-labs.training

chown -R bind:bind /etc/bind/keys
chown -R bind:bind /etc/bind/zones

cd /etc/bind/

dnssec-signzone -S -K keys/ -o grp1.th.te-labs.training zones/db.grp1

dig @localhost soa grp1.th.te-labs.training. +dnssec

dig DNSKEY grp1.th.te-labs.training. @10.0.0.30
dig DNSKEY grp1.th.te-labs.training. @10.0.0.30 +dnssec +multi
dig SOA grp1.th.te-labs.training. @10.0.0.30 +dnssec +multi

 rndc reconfig 

rndc signing -list grp1.th.te-labs.training


