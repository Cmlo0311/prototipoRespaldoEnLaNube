#!/bin/bash

organizar_archivos() {
  echo "-> Organizando archivos en $BASE"
  find "$BASE" -type d | while read -r dir; do
    find "$dir" -maxdepth 1 -type f | while read -r file; do
      ext="${file##*.}"
      if [[ "$file" != *.* ]]; then
        ext="sin_extension"
      else
        ext="${ext,,}"
      fi
      parent="$(basename "$(dirname "$file")")"
      [[ "$parent" == "$ext" ]] && continue
      target_dir="$dir/$ext"
      mkdir -p "$target_dir"
      mv "$file" "$target_dir/"
    done
  done
  echo "-> Organización completada"
}
