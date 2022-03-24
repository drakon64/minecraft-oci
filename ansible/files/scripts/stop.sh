#!/bin/bash

if [ -s "$1"/stop ]
then
	sudo -u minecraft tmux send-keys -t minecraft-"$1" kick SPACE @p SPACE "$(< "$1"/stop)" ENTER
fi

sudo -u minecraft tmux send-keys -t minecraft-"$1" stop ENTER

while sudo -u minecraft tmux list-sessions | grep -q minecraft-"$1"
do
	sleep 1
done
