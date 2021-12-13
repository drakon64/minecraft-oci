#!/bin/sh

tmux send-keys -t minecraft stop ENTER

while tmux list-sessions | grep --quiet minecraft ; do
	sleep 1
done
