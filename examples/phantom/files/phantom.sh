#!/bin/bash

UNAME=$(uname)
ARCHITECTURE=$(uname -m)

SERVER=$(< phantom.txt)

if [ "$UNAME" = "Darwin" ] ; then
	if [ "$ARCHITECTURE" = "arm64" ] ; then
		./phantom-macos-arm8 -server "$SERVER"
	elif [ "$ARCHITECTURE" = "x86_64" ] ; then
		./phantom-macos -server "$SERVER"
	else
		echo "Unknown architecture"
		exit 1
	fi
elif [ "$UNAME" = "Linux" ] ; then
	if [ "$ARCHITECTURE" = "aarch64" ] ; then
		./phantom-linux-arm8 -server "$SERVER"
	elif [ "$ARCHITECTURE" = "armv7l" ] ; then
		./phantom-linux-arm7 -server "$SERVER"
	elif [ "$ARCHITECTURE" = "armv6l" ] ; then
		./phantom-linux-arm6 -server "$SERVER"
	elif [ "$ARCHITECTURE" = "armv5l" ] ; then
		./phantom-linux-arm5 -server "$SERVER"
	elif [ "$ARCHITECTURE" = "x86_64" ] ; then
		./phantom-linux -server "$SERVER"
	else
		echo "Unknown architecture"
		exit 1
	fi
else
	echo "Unknown OS"
	exit 1
fi
