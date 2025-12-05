#!/bin/sh

RED="\033[01;38;2;255;000;000m"
GRE="\033[01;38;2;000;255;000m"
BLU="\033[01;38;2;000;000;255m"
RESET="\033[0m"

start_sec=$(date +%s)
start_nsec=$(date +%N)

while pdflatex -halt-on-error -interaction=nonstopmode main.tex \
      2>&1 | grep -v "/usr/share/tex" | tee /dev/tty \
      | grep "Please (re)run Biber"; do
    printf "%b" "$BLU"
    biber main
    printf "%b" "$RED"
done

printf "%b" "$GRE"
pdflatex -halt-on-error -interaction=nonstopmode main.tex

end_sec=$(date +%s)
end_nsec=$(date +%N)

elapsed=$(awk -v s1="$start_sec" -v n1="$start_nsec" \
              -v s2="$end_sec" -v n2="$end_nsec" \
          'BEGIN { printf "%.3f\n", (s2 - s1) + (n2 - n1)/1000000000 }')

printf "%b" "$RESET"
echo "Total compilation time: ${elapsed} s"
