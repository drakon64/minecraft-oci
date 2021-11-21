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
WINDOWS=$(echo "$RELEASES" | jq -r 'select(.name == "phantom-windows.exe") | .browser_download_url')
WINDOWS_32=$(echo "$RELEASES" | jq -r 'select(.name == "phantom-windows-32bit.exe") | .browser_download_url')

curl "$LINUX_ARM8" -o "$TEMP"/phantom-linux-arm8
curl "$LINUX_ARM7" -o "$TEMP"/phantom-linux-arm7
curl "$LINUX_ARM6" -o "$TEMP"/phantom-linux-arm6
curl "$LINUX_ARM5" -o "$TEMP"/phantom-linux-arm5
curl "$LINUX" -o "$TEMP"/phantom-linux
curl "$MAC_ARM" -o "$TEMP"/phantom-macos-arm8
curl "$MAC" -o "$TEMP"/phantom-macos
curl "$WINDOWS" -o "$TEMP"/phantom-windows.exe
curl "$WINDOWS_32" -o "$TEMP"/phantom-windows-32bit.exe

for i in "$TEMP"/phantom-linux-arm8 "$TEMP"/phantom-linux-arm7 "$TEMP"/phantom-linux-arm6 "$TEMP"/phantom-linux-arm5 "$TEMP"/phantom-linux "$TEMP"/phantom-macos-arm8 "$TEMP"/phantom-macos
do
	chmod +x "$i"
done

zip -j9 phantom "$TEMP"/phantom-linux-arm8 "$TEMP"/phantom-linux-arm7 "$TEMP"/phantom-linux-arm6 "$TEMP"/phantom-linux-arm5 "$TEMP"/phantom-linux "$TEMP"/phantom-macos-arm8 "$TEMP"/phantom-macos "$TEMP"/phantom-windows.exe "$TEMP"/phantom-windows-32bit.exe "$(dirname $0)"/files/*

rm "$TEMP"/phantom-linux-arm8 "$TEMP"/phantom-linux-arm7 "$TEMP"/phantom-linux-arm6 "$TEMP"/phantom-linux-arm5 "$TEMP"/phantom-linux "$TEMP"/phantom-macos-arm8 "$TEMP"/phantom-macos "$TEMP"/phantom-windows.exe "$TEMP"/phantom-windows-32bit.exe
rmdir "$TEMP"
