#!/bin/sh

if [ -z "$1" ] ; then
	echo "You must specify an IP address or DNS name"
	exit 1
fi

if [ -z "$2" ] || [ "$2" != "bedrock" ] && [ "$2" != "java" ] ; then
	echo "You must specify one of the following arguments: bedrock	java"
	exit 1
elif [ "$2" = "bedrock" ] ; then
	ansible-playbook --diff --inventory "$1", --user ubuntu --become ansible/minecraft.yml --extra-vars edition=bedrock
elif [ "$2" = "java" ] ; then
	ansible-playbook --diff --inventory "$1", --user ubuntu --become ansible/minecraft.yml --extra-vars edition=java
fi
