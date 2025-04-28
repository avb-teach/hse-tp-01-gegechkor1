#!/bin/bash

[ "$#" -lt 2 ] && exit 1

input="$1"
output="$2"
shift 2

depth=""
if [ "$#" -ge 2 ] && [ "$1" = "--max_depth" ]; then
    depth="-maxdepth $2"
fi

mkdir -p "$output"

cd "$input" || exit 1

find . $depth -type f | while read -r file; do
    dir=$(dirname "$file")
    mkdir -p "$output/$dir"
    cp "$file" "$output/$file"
done
