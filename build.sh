#!/bin/sh

RED="\033[01;38;2;255;000;000m"
GRE="\033[01;38;2;000;255;000m"
BLU="\033[01;38;2;000;000;255m"

while pdflatex -halt-on-error -interaction=nonstopmode main.tex \
      | tee /dev/tty | grep "Please (re)run Biber"; do
    echo "$BLU"
    biber main
    echo "$RED"
done

echo "$GRE"
pdflatex -halt-on-error -interaction=nonstopmode main.tex
