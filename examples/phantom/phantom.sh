#!/bin/sh

TEMP=$(mktemp -d)

RELEASES=$(curl --silent "https://api.github.com/repos/jhead/phantom/releases" | jq -r '.[0].assets[]')
LINUX_ARM8=$(echo "$RELEASES" | jq -r 'select(.name == "phantom-linux-arm8") | .browser_download_url')
LINUX_ARM7=$(echo "$RELEASES" | jq -r 'select(.name == "phantom-linux-arm7") | .browser_download_url')
LINUX_ARM6=$(echo "$RELEASES" | jq -r 'select(.name == "phantom-linux-arm6") | .browser_download_url')
LINUX_ARM5=$(echo "$RELEASES" | jq -r 'select(.name == "phantom-linux-arm5") | .browser_download_url')
LINUX=$(echo "$RELEASES" | jq -r 'select(.name == "phantom-linux") | .browser_download_url')
MAC_ARM=$(echo "$RELEASES" | jq -r 'select(.name == "phantom-macos-arm8") | .browser_download_url')
MAC=$(echo "$RELEASES" | jq -r 'select(.name == "phantom-macos") | .browser_download_url')

curl "$LINUX_ARM8" -L -o "$TEMP"/phantom-linux-arm8
curl "$LINUX_ARM7" -L -o "$TEMP"/phantom-linux-arm7
curl "$LINUX_ARM6" -L -o "$TEMP"/phantom-linux-arm6
curl "$LINUX_ARM5" -L -o "$TEMP"/phantom-linux-arm5
curl "$LINUX" -L -o "$TEMP"/phantom-linux
curl "$MAC_ARM" -L -o "$TEMP"/phantom-macos-arm8
curl "$MAC" -L -o "$TEMP"/phantom-macos

for i in "$TEMP"/phantom-linux-arm8 "$TEMP"/phantom-linux-arm7 "$TEMP"/phantom-linux-arm6 "$TEMP"/phantom-linux-arm5 "$TEMP"/phantom-linux "$TEMP"/phantom-macos-arm8 "$TEMP"/phantom-macos
do
	chmod +x "$i"
done

zip -j9 phantom "$TEMP"/phantom-linux-arm8 "$TEMP"/phantom-linux-arm7 "$TEMP"/phantom-linux-arm6 "$TEMP"/phantom-linux-arm5 "$TEMP"/phantom-linux "$TEMP"/phantom-macos-arm8 "$TEMP"/phantom-macos "$(dirname "$0")"/files/*

rm "$TEMP"/phantom-linux-arm8 "$TEMP"/phantom-linux-arm7 "$TEMP"/phantom-linux-arm6 "$TEMP"/phantom-linux-arm5 "$TEMP"/phantom-linux "$TEMP"/phantom-macos-arm8 "$TEMP"/phantom-macos
rmdir "$TEMP"
