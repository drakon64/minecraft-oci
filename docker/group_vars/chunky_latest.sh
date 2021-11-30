#!/bin/sh

BUILD=$(curl --silent https://ci.codemc.io/job/pop4959/job/Chunky/lastSuccessfulBuild/api/json | jq -r '.artifacts[0].fileName')
curl https://ci.codemc.io/view/Author/job/pop4959/job/Chunky/lastSuccessfulBuild/artifact/bukkit/build/libs/$BUILD -o Chunky.jar
