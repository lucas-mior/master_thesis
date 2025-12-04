#!/bin/sh

RED="\033[01;38;2;255;000;000m"
GRE="\033[01;38;2;000;255;000m"
BLU="\033[01;38;2;000;000;255m"
RESET="\033[0m"

START_TIME=$(date +%s)

while pdflatex -halt-on-error -interaction=nonstopmode main.tex \
      | tee /dev/tty | grep "Please (re)run Biber"; do
    printf "%b" "$BLU"
    biber main
    printf "%b" "$RED"
done

printf "%b" "$GRE"
pdflatex -halt-on-error -interaction=nonstopmode main.tex

END_TIME=$(date +%s)

ELAPSED=$((END_TIME - START_TIME))

printf "%b" "$RESET"
echo "Total compilation time: ${ELAPSED} seconds"
