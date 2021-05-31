#!/bin/sh

check_ip() {
	if [ -z "$2" ] ; then
		echo "You must specify an IP address or DNS name"
		exit 1
	fi
}

check_edition() {
	if [ -z "$3" ] || [ "$3" != "bedrock" ] && [ "$3" != "java" ] ; then
		echo "You must specify one of the following arguments: bedrock	java"
		exit 1
	fi
}

while getopts :inbp arg ; do
	case ${arg} in
		i)
			check_ip "$@"
			check_edition "$@"

			if [ "$3" = "bedrock" ] ; then
				echo "$2 edition=bedrock command='/home/minecraft/bedrock/bedrock_server' new_server=false restore_backup=false" > ansible/inventory
			elif [ "$3" = "java" ] ; then
				echo "$3 edition=java command='/usr/bin/java -Xmx1024M -Xms1024M -jar server.jar nogui' new_server=false restore_backup=false" > ansible/inventory
			fi
			;;
		n)
			check_ip "$@"
			check_edition "$@"

			if [ "$3" = "bedrock" ] ; then
				echo "$2 edition=bedrock command='/home/minecraft/bedrock/bedrock_server' new_server=true restore_backup=false" > ansible/inventory
			elif [ "$3" = "java" ] ; then
				echo "$3 edition=java command='/usr/bin/java -Xmx1024M -Xms1024M -jar server.jar nogui' new_server=true restore_backup=false" > ansible/inventory
			fi
			;;
		b)
			check_ip "$@"
			check_edition "$@"

			if [ "$3" = "bedrock" ] ; then
				echo "$2 edition=bedrock command='/home/minecraft/bedrock/bedrock_server' new_server=true restore_backup=true" > ansible/inventory
			elif [ "$3" = "java" ] ; then
				echo "$2 edition=java command='/usr/bin/java -Xmx1024M -Xms1024M -jar server.jar nogui' new_server=true restore_backup=true" > ansible/inventory
			fi
			;;
		p)
			ansible-playbook --diff --inventory ansible/inventory --user ubuntu --become ansible/minecraft.yml
			;;
		*)
	esac
done
