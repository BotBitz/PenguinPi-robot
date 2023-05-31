#!/bin/bash

#Check if we are running with sudo
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

apt install dnsmasq hostapd
systemctl unmask hostapd

echo "Enabling PenguinPi Static Hotspot"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd ) #Find dir of this script

#Copy files
cp $SCRIPT_DIR/setup-pi-network /etc/init.d/  #Copy initial setup script
cp $SCRIPT_DIR/hostapd.conf /etc/hostapd/ #Copy hostapd config
cp $SCRIPT_DIR/penguin.conf /etc/dnsmasq.d/ #Copy dnsmasq config
cp $SCRIPT_DIR/hotspot /etc/network/interfaces.d/ #Copy interfaces.d
cp $SCRIPT_DIR/70-persistent-net.rules /etc/udev/rules.d/

ln -sf /lib/systemd/resolv.conf /etc/resolv.conf

service hostapd stop 
service dnsmasq stop

systemctl enable setup-pi-network

sed -i 's/raspberrypi/PenguinPi/g' /etc/hosts
echo 'PenguinPi' > /etc/hostname

hostname PenguinPi

echo '192.168.50.1  PenguinPi' > /etc/hosts.dnsmasq

echo 'DAEMON_CONF="/etc/hostapd/hostapd.conf"' > /etc/default/hostapd
sed -i -r 's/#(conf-dir=\/etc\/dnsmasq.d\/,\*.conf)/\1/g' /etc/dnsmasq.conf

service dnsmasq start
service hostapd start

echo "Enabled"