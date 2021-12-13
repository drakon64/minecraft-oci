#!/bin/sh

dnf check-update
if [ "$?" = "100" ] ; then
	systemctl stop minecraft
	dnf -y update

	if [ ! "$(dnf needs-restarting -r)" ] ; then
		reboot
	else
		SERVICES=$(dnf needs-restarting -s)
		if $SERVICES ; then
			systemctl restart "$SERVICES"
		fi
		systemctl start minecraft
	fi
fi
