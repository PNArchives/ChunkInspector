#!/usr/bin/env bash
set -eu

declare -r pack_dir="$HOME/Downloads/ChunkInspector"
declare -r work_dir='/tmp/prepare-mcpack'
declare -r output_dir="./debug-pack"

if [[ ! -e "$pack_dir" ]]; then exit 1; fi
if [[ -e "$work_dir" ]]; then rm -rf "$work_dir"; fi
if [[ -e "$output_dir" ]]; then rm -rf "$output_dir"; fi

cp -r "$pack_dir" "$work_dir"

find "$work_dir" -type f -name '*.jsonc' | while read -r jsonc_file; do
  json_output="${jsonc_file%?}"
  if ! grep -v '//' "$jsonc_file" > "$json_output"; then
    echo '' > "$json_output"
  fi
  rm "$jsonc_file"
done

rm -rf "$work_dir"/.git
rm "$work_dir"/.mcattributes
rm "$work_dir"/*.vectornator

mv "$work_dir" "$output_dir"
