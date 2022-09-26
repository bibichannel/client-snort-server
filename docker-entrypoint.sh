#!/bin/bash

#if which ifconfig 2> /dev/null; then 
#        echo "==> ifconfig is already installed"
#else apt update &&  apt install net-tools -y; fi

/sbin/ldconfig -v

mkdir -p /etc/snort/rules
mkdir -p /var/log/snort
mkdir -p /usr/local/lib/snort_dynamicrules

touch /etc/snort/rules/white_list.rules
touch /etc/snort/rules/black_list.rules
touch /etc/snort/rules/local.rules

echo 'alert icmp any any -> $HOME_NET any (msg:"ICMP test"; sid:10000001; rev:1;)' >> /etc/snort/rules/local.rules
 
cp /snort_src/snort-2.9.20/etc/*.conf* /etc/snort
cp /snort_src/snort-2.9.20/etc/*.map /etc/snort

rm /etc/snort/snort.conf
mv /etc/snort/snort.config /etc/snort/snort.conf

#wget https://snort.org/downloads/community/community-rules.tar.gz
#tar -xvf community-rules.tar.gz
#cp community-rules/* /etc/snort/rules

#ifconfig eth0 promisc

/bin/bash
exec "$@"
