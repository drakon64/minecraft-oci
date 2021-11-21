#!/bin/sh

UNAME=$(uname)

if [ "$UNAME" = "Darwin" ]
then
	./phantom-macos -server {{ server }}
elif [ "$UNAME" = "Linux" ]
then
	./phantom-linux -server {{ server }}
else
	echo "Unknown uname"
	exit 1
fi
