#!/bin/sh

dnf check-update
if [ "$?" = "100" ] ; then

	printf "Server closed for updates." > server/stop
	systemctl stop minecraft
	rm server/stop

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
