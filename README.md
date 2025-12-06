# Template para TCC/Dissertação/Tese UFSC
Baseado em
[UFSC/ufscthesisx](https://github.com/UFSC/ufscthesisx).
Vários erros foram corrigidos, e foi feita uma refatoração completa
da estrutura do projeto e dos arquivos `.tex` e `.cls`.
Avisos emitidos pela ferramentas `chktex` foram corrigidos.
Deve ser mais fácil fazer a manutenção deste template do que do original.

## Como utilizar (linux nativo)
```sh
# download do repositório, por exemplo usando git:
git clone https://github.com/lucas-mior/master_thesis

# compilar usando o script
./build.sh

# compilar usando make, alternativamente
make

# limpar todo o cache
make clean
```

## Como utilizar (Overleaf/crixet)
*Atenção:* O plano gratuito do Overleaf requer que a compilação termine em até
10 segundos, o que não é suficiente para este template.
No github do projeto, clique em `Code`, depois em `Download ZIP`.
No overleaf/crixet, carregue o arquivo `.zip`.
