#!/bin/bash

[ "$#" -lt 2 ] && exit 1
input="$1"; output="$2"; shift 2

max_f=0; max_d=0
if [ "$#" -ge 2 ] && [ "$1" = "--max_depth" ]; then
  max_f=1; max_d="$2"
fi

mkdir -p "$output"

find "$input" -type f | while IFS= read -r file; do
  rel="${file#"$input"/}"

  if [ "$max_f" -eq 1 ]; then
    IFS='/' read -ra parts <<< "$rel"
    depth=${#parts[@]}

    if [ "$depth" -gt "$max_d" ]; then
      cut=$((depth - max_d))
      newparts=( "${parts[@]:cut}" )
      rel="$(IFS=/; echo "${newparts[*]}")"
    fi
  fi

  dest="$output/$rel"
  mkdir -p "$(dirname "$dest")"
  cp "$file" "$dest"
done
