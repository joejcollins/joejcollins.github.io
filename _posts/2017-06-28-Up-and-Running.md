---
layout: post
title: Raspberry Pi Zero Print Server for Laserjet 1005
---

# Setup the Pi Zero

1. Image a micro SD card with the Raspbian (Stretch) OS image using Etcher.

1. Manually configure your WiFi from another computer. In another computer running Linux you could edit the following file: sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
And add the following where you enter your WiFi network SSID and password details:

ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
    ssid="Your SSID Here"
    proto=RSN
    key_mgmt=WPA-PSK
    pairwise=CCMP TKIP
    group=CCMP TKIP
    psk="YourPresharedKeyHere"
}

1. Enable SSH on the Pi from another computer. Create a file on the /boot partition named “ssh”.

1. start and find the IP on the router

# Then set up CUPS

You should be able to use PUTTY to connect to the device.
	Host: pi@192.168.1.8 (I got the IP from the router)
	Password: raspberry

1. sudo apt-get update ()

1. sudo apt-get install hplip

sudo hp-setup -i (interactive mode)

1. sudo apt-get install cups ()

1. sudo usermod -a -G lpadmin pi (to get the pi user in the printer admin group)

1. cupsctl --remote-admin (to allow remote admin)

1. sudo reboot (to get the services up and running)

1. http://192.168.1.8:631/


# Google CUPS cloug server

sudo apt-get install golang (so you can compile it)

sudo apt-get install build-essential libcups2-dev libavahi-client-dev git bzr (dev tools needed)

sudo reboot 

export GOPATH="$HOME/" (go requires this)

go get github.com/google/cloud-print-connector/...  (to get and compile, no feedback)


From https://github.com/google/cloud-print-connector/wiki/Installing-on-Raspberry-Pi-Raspbian-Jessie

sudo mv ./bin/gcp-cups-connector /opt/cloud-print-connector (move the binaries that have just been created)

sudo mv ./bin/gcp-connector-util /opt/cloud-print-connector

sudo chmod 755 /opt/cloud-print-connector/gcp-cups-connector

sudo chmod 755 /opt/cloud-print-connector/gcp-connector-util


From https://github.com/google/cloud-print-connector/wiki/Installing-on-Raspberry-Pi-Raspbian-Jessie

1. sudo useradd -s /usr/sbin/nologin -r -M cloud-print-connector

# Install the Driver for Lj1005


sudo apt-get install hplip

1. wget -O foo2zjs.tar.gz http://foo2zjs.rkkda.com/foo2zjs.tar.gz

1. tar zxf foo2zjs.tar.gz

1. cd foo2zjs

1. make (to make it, this might take some time)

1. ./getweb 1005 (get the specifid files for the laser jet 1005)

1. sudo make install (install the driver)

1. sudo make cups (restart the spooler)

Not going to use Windows to print so SAMBA is not required.

