#!/bin/sh

SRC=$(readlink -f "$1")
DST="fig/$(basename "$1")"

if [ -z "$SRC" ] || [ -z "$DST" ]; then
    echo "Usage: $0 SOURCE"
    exit 1
fi

if [ ! -f "$SRC" ]; then
    echo "Source file does not exist: $SRC"
    exit 1
fi

git wip
rm -rf .git-rewrite

FILTER_BRANCH_SQUELCH_WARNING=1 \
git filter-branch -f --tree-filter "
if [ ! -f \"$DST\" ]; then
    mkdir -p \"\$(dirname \"$DST\")\"
    cp \"$SRC\" \"$DST\"
fi
" -- --all
