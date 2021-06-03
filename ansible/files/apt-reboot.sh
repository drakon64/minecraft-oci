#!/bin/sh

apt update
apt -y upgrade

if [ -f /var/run/reboot-required ] ; do
	reboot
fi
