#!/bin/bash

#Check if we are running with sudo
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "Disabling PenguinPi Static Hotspot"

systemctl stop hostapd
systemctl stop dnsmasq

sed -i 's/PenguinPi/raspberrypi/g' /etc/hosts
echo 'raspberrypi' > /etc/hostname

hostname raspberrypi

sed -i -r 's/192.168.50.1  PenguinPi//g' /etc/hosts.dnsmasq

sed -i -r 's/DAEMON_CONF="\/etc\/hostapd\/hostapd.conf"//g' /etc/default/hostapd
sed -i -r 's/(conf-dir=\/etc\/dnsmasq.d\/,\*.conf)/#\1/g' /etc/dnsmasq.conf

ln -s /dev/null /etc/systemd/system/hostapd.service
systemctl start hostapd
systemctl start dnsmasq

echo "Removed!"