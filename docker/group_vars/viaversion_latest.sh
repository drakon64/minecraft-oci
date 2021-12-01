#!/bin/sh

BUILD=$(curl --silent "https://api.github.com/repos/ViaVersion/ViaVersion/releases/latest" | jq -r '.assets[].browser_download_url')
curl -L $BUILD -o ViaVersion.jar
