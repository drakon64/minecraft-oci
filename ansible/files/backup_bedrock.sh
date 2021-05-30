#!/bin/sh

BACKUP=~/bedrock.tar.gz

tar cfO - ~/bedrock | gzip --best > "$BACKUP"
oci os object put --auth instance_principal --bucket-name minecraft-backup --file "$BACKUP"
rm "$BACKUP"
