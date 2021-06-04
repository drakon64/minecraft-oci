#!/bin/sh

check_ip() {
	if [ -z "$2" ] ; then
		echo "You must specify an IP address or DNS name"
		exit 1
	fi
}

check_eula() {
	if [ -z "$4" ] || [ "$4" = "no" ] || [ "$4" = "false" ] ; then
		EULA="false"
	elif [ "$4" = "yes" ] || [ "$4" = "true" ] ; then
		EULA="true"
	else
		echo "You must specify one of the following arguments: yes	no"
		exit 1
	fi
}

while getopts :inbp arg ; do
	case ${arg} in
		i)
			check_ip "$@"
			check_eula "$@"

			if [ "$3" = "bedrock" ] ; then
				echo "$2 edition=bedrock command='/home/minecraft/bedrock/bedrock_server' new_server=false restore_backup=false" > ansible/inventory
			elif [ "$3" = "java" ] || [ "$3" = "paper" ] || [ "$3" = "geyser" ] ; then
				echo "$2 edition=$3 command='/usr/bin/java -Xmx1024M -Xms1024M -jar server.jar nogui' eula=$EULA new_server=false restore_backup=false" > ansible/inventory
			fi
			;;
		n)
			check_ip "$@"
			check_eula "$@"

			if [ "$3" = "bedrock" ] ; then
				echo "$2 edition=bedrock command='/home/minecraft/bedrock/bedrock_server' new_server=true restore_backup=false" > ansible/inventory
			elif [ "$3" = "java" ] || [ "$3" = "paper" ] || [ "$3" = "geyser" ] ; then
				echo "$2 edition=$3 command='/usr/bin/java -Xmx1024M -Xms1024M -jar server.jar nogui' eula=$EULA new_server=true restore_backup=false" > ansible/inventory
			else
				echo "You must specify one of the following arguments: bedrock	java	paper	geyser"
				exit 1
			fi
			;;
		b)
			check_ip "$@"
			check_eula "$@"

			if [ "$3" = "bedrock" ] ; then
				echo "$2 edition=bedrock command='/home/minecraft/bedrock/bedrock_server' new_server=true restore_backup=true" > ansible/inventory
			elif [ "$3" = "java" ] || [ "$3" = "paper" ] || [ "$3" = "geyser" ] ; then
				echo "$2 edition=java command='/usr/bin/java -Xmx1024M -Xms1024M -jar server.jar nogui' eula=$EULA new_server=true restore_backup=true" > ansible/inventory
			else
				echo "You must specify one of the following arguments: bedrock	java	paper	geyser"
				exit 1
			fi
			;;
		p)
			ansible-playbook --diff --inventory ansible/inventory --user ubuntu --become ansible/minecraft.yml
			;;
		*)
	esac
done
