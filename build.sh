#!/bin/sh

RED="\033[0;38;2;255;000;000m"
GRE="\033[0;38;2;000;255;000m"
BLU="\033[0;38;2;000;000;255m"
PUR="\033[0;38;2;255;000;255m"
RESET="\033[0m"

target="${1:-build}"

alias grep='grep --color=auto'
alias pdflatex='pdflatex -halt-on-error -interaction=nonstopmode'
program=$(basename "$0")

error () {
    >&2 printf "$program" "$@"
    return
}

case $target in
"build")
    tput civis

    cleanup_build() {
        tput cnorm
        tput sgr0
        echo
    }
    trap cleanup_build EXIT

    update_size() {
        rows=$(tput lines)
        status_row=$rows
    }
    trap update_size WINCH

    start_sec=$(date +%s)
    start_nsec=$(date +%N)

    run_pdflatex() {
        pdflatex main.tex 2>&1 | grep -v "/usr/share/tex" | grep -v "^\[debug\]"
    }

    print_status() {
        tput cup $((status_row - 1)) 0
        printf "%b" "$1"
        printf "%s" "$2"
        printf "%b" "$RESET"
        printf "\n"
    }

    while true; do
        out="$(run_pdflatex)"
        echo "$out"

        print_status "$BLU" "Running Biber..."
        if echo "$out" | grep -q "Please (re)run Biber"; then
            biber main
        else
            break
        fi
    done

    while true; do
        out="$(run_pdflatex)"
        echo "$out"

        print_status "$PUR" "Rerunning LaTeX..."
        if echo "$out" | grep -qi "Rerun LaTeX."; then
            continue
        else
            break
        fi
    done

    end_sec=$(date +%s)
    end_nsec=$(date +%N)

    elapsed=$(awk -v s1="$start_sec" -v n1="$start_nsec" \
                  -v s2="$end_sec" -v n2="$end_nsec" \
        'BEGIN { printf "%.3f\n", (s2 - s1) + (n2 - n1)/1000000000 }')

    print_status "$GRE" "Done. Total compilation time: ${elapsed} s"

    if [ ! -e "main.pdf" ]; then
        error "Error compiling main.tex"
        exit 1
    fi
    ;;
"check")
    chktex -n17 -n8 -n9 -n10 -n44 "main.tex"
    ;;
"clear"|"clean")
    set -e
    if [ ! -f .gitignore ]; then
        error ".gitignore not found"
        exit 1
    fi

    git ls-files -i -o --exclude-from=.gitignore -z \
        | xargs -0 rm -vrf --
    ;;
*)
    echo "usage: $(basename "$0") <build|check>"
    ;;
esac
