#!/bin/sh

set -e
set -x

while read -r pair; do
     old=$(echo "$pair" | awk '{print $1}')
     new=$(echo "$pair" | awk '{print $2}')
     echo "old=$old"
     echo "new=$new"
     for f in **/*.cls *.tex; do
         sed -Ei 's/\{'$old'\>/{'$new'/g' "$f"
     done
done < renames
