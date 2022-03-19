#!/bin/sh -e

FILES=$(ls "$1"/server-icons)
OLD_SERVER_ICON="$1/server/server-icon.png"
OLD_SERVER_ICON_HASH=$(sha224sum "$OLD_SERVER_ICON" | awk '{ print $1 }')
NEW_SERVER_ICON=$(echo "$FILES" | shuf -n 1)
NEW_SERVER_ICON_HASH=$(sha224sum "$1"/server-icons/"$NEW_SERVER_ICON" | awk '{ print $1 }')

while true ; do
	if [ "$NEW_SERVER_ICON_HASH" != "$OLD_SERVER_ICON_HASH" ] ; then
		echo "New server icon: $NEW_SERVER_ICON"
		cp "$1"/server-icons/"$NEW_SERVER_ICON" "$OLD_SERVER_ICON"
		exit 0
	else
		NEW_SERVER_ICON=$(echo "$FILES" | shuf -n 1)
		NEW_SERVER_ICON_HASH=$(sha224sum "$1"/server-icons/"$NEW_SERVER_ICON" | awk '{ print $1 }')
	fi
done
