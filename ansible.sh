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

check_bucket_name() {
	if [ -z "$5" ] ; then
		echo "You must specify the name of the bucket to restore from"
		exit 1
	fi
}

while getopts :inbpc arg ; do
	case ${arg} in
		i)
			check_ip "$@"
			check_eula "$@"
			check_bucket_name "$@"

			if [ "$3" = "bedrock" ] ; then
				echo "$2 edition=bedrock type=bedrock command='/home/minecraft/bedrock/bedrock_server' new_server=false restore_backup=false bucket_name=$5 timezone=$6 geyser_config=false" > ansible/inventory
			elif [ "$3" = "java" ] || [ "$3" = "paper" ] || [ "$3" = "geyser" ] ; then
				echo "$2 edition=$3 type=java command='/usr/bin/java -Xmx1024M -Xms1024M -jar server.jar nogui' eula=$EULA new_server=false restore_backup=false bucket_name=$5 timezone=$6 geyser_config=false" > ansible/inventory
			else
				echo "You must specify one of the following arguments: bedrock	java	paper	geyser"
				exit 1
			fi
			;;
		n)
			check_ip "$@"
			check_eula "$@"
			check_bucket_name "$@"

			if [ "$3" = "bedrock" ] ; then
				echo "$2 edition=bedrock type=bedrock command='/home/minecraft/bedrock/bedrock_server' new_server=true restore_backup=false bucket_name=$5 timezone=$6 geyser_config=false" > ansible/inventory
			elif [ "$3" = "java" ] || [ "$3" = "paper" ] || [ "$3" = "geyser" ] ; then
				echo "$2 edition=$3 type=java command='/usr/bin/java -Xmx1024M -Xms1024M -jar server.jar nogui' eula=$EULA new_server=true restore_backup=false bucket_name=$5 timezone=$6 geyser_config=false" > ansible/inventory
			else
				echo "You must specify one of the following arguments: bedrock	java	paper	geyser"
				exit 1
			fi
			;;
		b)
			check_ip "$@"
			check_eula "$@"
			check_bucket_name "$@"

			if [ "$3" = "bedrock" ] ; then
				echo "$2 edition=bedrock type=bedrock command='/home/minecraft/bedrock/bedrock_server' new_server=true restore_backup=true bucket_name=$5 timezone=$6 geyser_config=false" > ansible/inventory
			elif [ "$3" = "java" ] || [ "$3" = "paper" ] || [ "$3" = "geyser" ] ; then
				echo "$2 edition=$3 type=java command='/usr/bin/java -Xmx1024M -Xms1024M -jar server.jar nogui' eula=$EULA new_server=true restore_backup=true bucket_name=$5 timezone=$6 geyser_config=false" > ansible/inventory
			else
				echo "You must specify one of the following arguments: bedrock	java	paper	geyser"
				exit 1
			fi
			;;
		p)
			ansible-playbook --diff --inventory ansible/inventory --user ubuntu --become ansible/minecraft.yml
			;;
		c)
			ansible-playbook --diff --inventory ansible/inventory --user ubuntu --become ansible/minecraft.yml --extra-vars "geyser_config=true" --tags geyser-config
			;;
		*)
	esac
done
