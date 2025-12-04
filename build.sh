#!/bin/sh

while pdflatex -interaction=nonstopmode main.tex \
      | grep "Please (re)run Biber"; do
    biber main
done
pdflatex -interaction=nonstopmode main.tex
