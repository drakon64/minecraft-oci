#!/bin/bash

if [ -s stop ]
then
	tmux send-keys -t minecraft kick SPACE @p SPACE "$(< stop)" ENTER
fi
systemctl stop minecraft
