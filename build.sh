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
        status_row=$(tput lines)
    }
    trap update_size WINCH
    update_size

    start_sec=$(date +%s)
    start_nsec=$(date +%N)

    run_pdflatex_raw() {
        pdflatex main.tex 2>&1 \
            | grep -v "/usr/share/tex" \
            | grep -v "^\[debug\]"
    }

    draw_status() {
        color="$1"
        msg="$2"
        tput cup $((status_row - 1)) 0
        printf "%b%s%b" "$color" "$msg" "$RESET"
        printf "\033[K\n"
    }

    run_and_display() {
        color="$1"
        msg="$2"

        while IFS= read -r ln; do
            update_size

            tput cup $((status_row - 2)) 0
            printf "\033[J"

            printf "%s\n" "$ln"

            draw_status "$color" "$msg"
        done
    }

    while true; do
        out="$(run_pdflatex_raw \
               | run_and_display "$RED" "Running Latex..." \
               | tee /dev/tty)"

        if printf "%s\n" "$out" | grep -q "Please (re)run Biber"; then
            biber main | run_and_display "$BLU" "Running Biber..."
        else
            break
        fi
    done

    while true; do
        out="$(run_pdflatex_raw | run_and_display "$PUR" "Running Latex...")"

        if printf "%s\n" "$out" | grep -qi "Rerun LaTeX."; then
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

    draw_status "$GRE" "Done. Total compilation time: ${elapsed} s"

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
