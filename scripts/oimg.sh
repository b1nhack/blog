#!/usr/bin/env bash

# ./oimg.sh <png>

set -e

if [[ -z "$1" ]]; then
	echo "./oimg.sh <png>"
	exit 1
fi

png="$1"

oxipng -o max -z --fast -s "$png"
cwebp -z 9 -mt "$png" -o "${png%.png}.webp"
