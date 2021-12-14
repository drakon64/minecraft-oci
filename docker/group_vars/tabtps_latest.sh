#!/bin/sh

BUILD=$(curl --silent "https://api.github.com/repos/jpenilla/TabTPS/releases/latest" | jq -r '.assets[].browser_download_url' | grep spigot)
curl -L $BUILD -o TabTPS.jar
