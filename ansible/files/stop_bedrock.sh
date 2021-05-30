#!/bin/sh

tmux send-keys -t minecraft-bedrock stop ENTER

while tmux list-sessions | grep --quiet minecraft-bedrock ; do
	sleep 1
done
