#!/usr/bin/env bash
set -e

OUTFILE=Solution_Tags_Index.md
echo "# LeetCode Tag Index" > "$OUTFILE"
echo ""        >> "$OUTFILE"

# 1. Gather every file and its tag list
declare -A file_tags

# List of folders and extensions to check
declare -a folders=("python" "cpp")
declare -A exts=( ["python"]="py" ["cpp"]="cpp" )

# 1. Gather every file and its tag list
for lang in "${folders[@]}"; do
  ext="${exts[$lang]}"
  for file in "$lang"/*."$ext"; do
    # If no files match the glob, skip the iteration
    [[ -e "$file" ]] || continue

    # Extract Tags line
    if tags_line=$(sed -nE 's/^[[:space:]]*(#|\/\/)?[[:space:]]*Tags:[[:space:]]*(.*)/\2/p' "$file"); then
      IFS=',' read -ra raw_tags <<< "$tags_line"
      for t in "${raw_tags[@]}"; do
        tag=$(echo "$t" | sed 's/^\s*//;s/\s*$//')
        file_tags["$file"]+="$tag "
      done
    fi
  done
done

# 2. Build global sorted list of unique tags
all_tags=()
for tags in "${file_tags[@]}"; do
  for tag in $tags; do
    all_tags+=("$tag")
  done
done
# dedupe & sort
mapfile -t uniq_tags < <(printf "%s\n" "${all_tags[@]}" | sort -u)

# 3. Emit Markdown grouped by tag
for tag in "${uniq_tags[@]}"; do
  echo "## $tag" >> "$OUTFILE"
  echo ""        >> "$OUTFILE"
  # For each file that has this tag, group by language
  for lang in python cpp; do
    # collect files in this lang with the tag
    matches=()
    for file in "${!file_tags[@]}"; do
      if [[ "$file" == $lang/* ]] && [[ " ${file_tags[$file]} " == *" $tag "* ]]; then
        matches+=("$(basename "$file")")
      fi
    done
    if (( ${#matches[@]} )); then
      echo "### ${lang^}" >> "$OUTFILE"   # capitalize lang
      for fn in "${matches[@]}"; do
        echo " - [$fn]($lang/$fn)" >> "$OUTFILE"
      done
      echo "" >> "$OUTFILE"
    fi
  done
done

echo "Generated $OUTFILE"

