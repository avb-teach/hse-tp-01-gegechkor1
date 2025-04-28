#!/bin/bash

[ "$#" -lt 2 ] && exit 1

input="$1"
output="$2"
shift 2

depth=""
[ "$#" -eq 1 ] && [[ "$1" =~ --max_depth=([0-9]+) ]] && depth="-maxdepth ${BASH_REMATCH[1]}"

mkdir -p "$output"

find "$input" $depth -type f | while read -r file; do
    rel_path="${file#$input/}"
    mkdir -p "$(dirname "$output/$rel_path")"
    cp "$file" "$output/$rel_path"
done
