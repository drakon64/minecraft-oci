#!/bin/bash

UNAME=$(uname)
ARCHITECTURE=$(uname -m)

SERVER=$(< phantom.txt)

if [ "$UNAME" = "Darwin" ] && [ "$ARCHITECTURE" = "arm64" ]
then
	./phantom-macos-arm8 -server "$SERVER"
elif [ "$UNAME" = "Darwin" ] && [ "$ARCHITECTURE" = "x86_64" ]
then
	./phantom-macos -server "$SERVER"
elif [ "$UNAME" = "Linux" ] && [ "$ARCHITECTURE" = "aarch64" ]
then
	./phantom-linux-arm8 -server "$SERVER"
elif [ "$UNAME" = "Linux" ] && [ "$ARCHITECTURE" = "armv7l" ]
then
	./phantom-linux-arm7 -server "$SERVER"
elif [ "$UNAME" = "Linux" ] && [ "$ARCHITECTURE" = "armv6l" ]
then
	./phantom-linux-arm6 -server "$SERVER"
elif [ "$UNAME" = "Linux" ] && [ "$ARCHITECTURE" = "armv5l" ]
then
	./phantom-linux-arm5 -server "$SERVER"
elif [ "$UNAME" = "Linux" ] && [ "$ARCHITECTURE" = "x86_64" ]
then
	./phantom-linux -server "$SERVER"
else
	echo "Unknown uname"
	exit 1
fi
