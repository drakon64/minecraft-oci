#!/bin/sh -e

RELEASES=$(curl --silent https://api.github.com/repos/jhead/phantom/releases | jq -r '.[0].assets[]')
ARM8=$(echo "$RELEASES" | jq -r 'select(.name == "phantom-linux-arm8") | .browser_download_url')
AMD64=$(echo "$RELEASES" | jq -r 'select(.name == "phantom-linux") | .browser_download_url')

docker buildx build --platform linux/arm64,linux/amd64 --push -t socminarch/phantom:latest --build-arg ARM8="$ARM8" --build-arg AMD64="$AMD64" "$(dirname "$0")"
