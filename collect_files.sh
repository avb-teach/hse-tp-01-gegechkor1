#!/bin/bash

if [ "$#" -lt 2 ]; then
    exit 1
fi

input_dir="$1"
output_dir="$2"

mkdir -p "$output_dir"

find "$input_dir" -type f | while read -r file; do
    cp --backup=numbered "$file" "$output_dir"
done
