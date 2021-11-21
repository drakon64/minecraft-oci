#!/bin/sh

ARCHITECTURE=$(uname -m)
RELEASES=$(curl --silent "https://api.github.com/repos/jhead/phantom/releases" | jq -r '.[0].assets[]')

if [ "$ARCHITECTURE" = "aarch64" ]
then
	curl "$(echo "$RELEASES" | jq -r 'select(.name == "phantom-linux-arm8") | .browser_download_url')" -L -o /phantom/phantom-linux
elif [ "$ARCHITECTURE" = "armv7l" ]
then
	curl "$(echo "$RELEASES" | jq -r 'select(.name == "phantom-linux-arm7") | .browser_download_url')" -L -o /phantom/phantom-linux
elif [ "$ARCHITECTURE" = "armv6l" ]
then
	curl "$(echo "$RELEASES" | jq -r 'select(.name == "phantom-linux-arm6") | .browser_download_url')" -L -o /phantom/phantom-linux
elif [ "$ARCHITECTURE" = "armv5l" ]
then
	curl "$(echo "$RELEASES" | jq -r 'select(.name == "phantom-linux-arm5") | .browser_download_url')" -L -o /phantom/phantom-linux
elif [ "$ARCHITECTURE" = "x86_64" ]
then
	curl "$(echo "$RELEASES" | jq -r 'select(.name == "phantom-linux") | .browser_download_url')" -L -o /phantom/phantom-linux
else
	echo "Unknown uname"
	exit 1
fi

chmod +x /phantom/phantom-linux
