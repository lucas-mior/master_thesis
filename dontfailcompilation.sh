#!/bin/sh

ncommits="$(wc -l "commits.txt")"
i=0

RED="\033[01;38;2;255;000;000m"
GRE="\033[01;38;2;000;255;000m"
RESET="\033[0m"

while read -r commit; do
    rm main.pdf
    set -x
    git checkout -f "$commit" || exit
    set +x
    make clean
    make veryclean
    rm main.pdf
    if ! ./build.sh 2>&1 | grep -v "/usr/share/tex" | grep -v "^\[debug\]"; then
        printf "%b" "$RED"
        echo "commit $commit fails to compile" | tee -a "wrong-commits.txt"
        printf "%b" "$RESET"
        exit 1
    fi
    printf "%b" "$GRE"
    i=$((i+1))
    echo "$i / $ncommits"
    printf "%b" "$RESET"
done < commits.txt
git checkout master
