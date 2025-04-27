#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 /path/to/input_dir /path/to/output_dir [--max_depth N]"
    exit 1
fi

input_dir="$1"
output_dir="$2"
max_depth=""

if [ "$3" == "--max_depth" ] && [ -n "$4" ]; then
    max_depth="-maxdepth $4"
fi

if [ ! -d "$input_dir" ]; then
    echo "Error: Input directory '$input_dir' does not exist."
    exit 1
fi

mkdir -p "$output_dir"

copy_with_rename() {
    local src_file="$1"
    local dest_dir="$2"
    local base_name=$(basename "$src_file")
    local dest_file="$dest_dir/$base_name"
    local counter=1

    while [ -e "$dest_file" ]; do
        dest_file="$dest_dir/${base_name%.*}_$counter.${base_name##*.}"
        ((counter++))
    done

    cp "$src_file" "$dest_file"
}
find "$input_dir" $max_depth -type f | while read -r file; do
    copy_with_rename "$file" "$output_dir"
done

echo "Files have been successfully collected in '$output_dir'."
