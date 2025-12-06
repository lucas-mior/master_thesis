#!/bin/sh

git filter-branch --tree-filter '
if [ ! -f fig/UFSC_sigla_fundo_claro.png ]; then
    mkdir -p fig
    cp /home/lucas/docs/UFSC_mestrado/thesis/UFSC_sigla_fundo_claro \
      fig/UFSC_sigla_fundo_claro.png
fi' -- --all
