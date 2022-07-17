#!/bin/bash

if [ -s "$1"/stop ]
then
	tmux send-keys -t minecraft-"$1" kick SPACE @p SPACE "$(< "$1"/stop)" ENTER
fi

tmux send-keys -t minecraft-"$1" stop ENTER

while tmux list-sessions | grep -q minecraft-"$1"
do
	sleep 1
done
