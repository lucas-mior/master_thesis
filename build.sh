#!/bin/sh

RED="\033[01;38;2;255;000;000m"
GRE="\033[01;38;2;000;255;000m"
BLU="\033[01;38;2;000;000;255m"
RESET="\033[0m"

start_sec=$(date +%s)
start_nsec=$(date +%N)

while pdflatex -halt-on-error -interaction=nonstopmode main.tex \
      | tee /dev/tty | grep "Please (re)run Biber"; do
    printf "%b" "$BLU"
    biber main
    printf "%b" "$RED"
done

printf "%b" "$GRE"
pdflatex -halt-on-error -interaction=nonstopmode main.tex

end_sec=$(date +%s)
end_nsec=$(date +%N)

elapsed_ms=$(( (end_sec - start_sec) * 1000 + (end_nsec / 1000000 - start_nsec / 1000000) ))

printf "%b" "$RESET"
echo "Total compilation time: ${elapsed_ms} ms"
