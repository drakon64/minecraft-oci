#!/bin/sh

BUILD=$(curl --silent https://papermc.io/api/v2/projects/paper/versions/$1 | jq ".builds | max")
curl https://papermc.io/api/v2/projects/paper/versions/$1/builds/$BUILD/downloads/paper-$1-$BUILD.jar -o server.jar
