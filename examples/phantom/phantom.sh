#!/bin/sh

TEMP=$(mktemp -d)

RELEASES=$(curl --silent "https://api.github.com/repos/jhead/phantom/releases" | jq -r '.[0].assets[]')
LINUX=$(echo "$RELEASES" | jq -r 'select(.name == "phantom-linux") | .browser_download_url')
MAC_ARM=$(echo "$RELEASES" | jq -r 'select(.name == "phantom-macos-arm8") | .browser_download_url')
MAC=$(echo "$RELEASES" | jq -r 'select(.name == "phantom-macos") | .browser_download_url')
WINDOWS=$(echo "$RELEASES" | jq -r 'select(.name == "phantom-windows.exe") | .browser_download_url')

curl "$LINUX" -o "$TEMP"/phantom-linux
curl "$MAC_ARM" -o "$TEMP"/phantom-macos-arm8
curl "$MAC" -o "$TEMP"/phantom-macos
curl "$WINDOWS" -o "$TEMP"/phantom-windows.exe

for i in "$TEMP"/phantom-linux "$TEMP"/phantom-macos-arm8 "$TEMP"/phantom-macos
do
	chmod +x "$i"
done

zip -j9 phantom "$TEMP"/phantom-linux "$TEMP"/phantom-macos-arm8 "$TEMP"/phantom-macos "$TEMP"/phantom-windows.exe "$(dirname $0)"/files/*

rm "$TEMP"/phantom-linux "$TEMP"/phantom-macos-arm8 "$TEMP"/phantom-macos "$TEMP"/phantom-windows.exe
rmdir "$TEMP"
