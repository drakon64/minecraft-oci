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
elif [ "$UNAME" = "Linux" ]
then
	./phantom-linux -server "$SERVER"
else
	echo "Unknown uname"
	exit 1
fi
