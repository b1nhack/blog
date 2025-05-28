#!/usr/bin/env bash

# ./oimg.sh <png>

set -e

if [[ -z "$1" ]]; then
	echo "./oimg.sh <png>"
	exit 1
fi

png="$1"

oxipng -o max -s -a "$png"
cwebp -mt "$png" -o "${png%.png}.webp"
rm -f "$png"
