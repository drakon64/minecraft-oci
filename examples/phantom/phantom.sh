#!/bin/sh

TEMP=$(mktemp -d)

RELEASES=$(curl --silent "https://api.github.com/repos/jhead/phantom/releases" | jq -r '.[0].assets[]')
LINUX=$(echo "$RELEASES" | jq -r 'select(.name == "phantom-linux") | .browser_download_url')
MAC=$(echo "$RELEASES" | jq -r 'select(.name == "phantom-macos") | .browser_download_url')
WINDOWS=$(echo "$RELEASES" | jq -r 'select(.name == "phantom-windows.exe") | .browser_download_url')

curl "$MAC" -o "$TEMP"/phantom-macos
curl "$LINUX" -o "$TEMP"/phanton-linux
curl "$WINDOWS" -o "$TEMP"/phantom-windows.exe

zip -j9 phantom "$TEMP"/phanton-linux "$TEMP"/phantom-macos "$TEMP"/phantom-windows.exe "$(dirname $0)"/files/*

rm "$TEMP"/phanton-linux "$TEMP"/phantom-macos "$TEMP"/phantom-windows.exe
rmdir "$TEMP"
