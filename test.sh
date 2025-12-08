#!/usr/bin/env bash

RED="\033[0;38;2;255;000;000m"
RESET="\033[0m"
total=100000
count=0

tput civis

cleanup() {
    tput cnorm
    echo
}
trap cleanup EXIT

update_size() {
    rows=$(tput lines)
    progress_row=$rows
}
trap update_size SIGWINCH
update_size
i=0

while read -r line; do
    count=$((count + 1))

    echo "Processing: $line"

    update_size

    i=$((i+1))
    j=$(echo "$i % 100" | bc)
    # if [ "$j" -eq 0 ]; then
      tput cup $((progress_row - 1)) 0
      printf "$RED Progress: %d/%d (%.2f%%) $RESET" \
          "$count" "$total" "$(awk "BEGIN{print $count*100/$total}")"
      tput cup $((rows - 2)) 0
    # fi

done < <(seq "$total")
