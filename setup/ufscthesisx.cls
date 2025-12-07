% Copyright 2017 Evandro Coan
% Copyright 2012-2016 by abnTeX2 group at https://www.abntex.net.br/
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
% The Current Maintainer of this work is the Evandro Coan.
%
% The last Maintainer of this work was the abnTeX2 team, led
% by Lauro César Araujo. Further information are available on
% https://www.abntex.net.br/
%
% This work consists of the file `abntex2-ufsc.sty` renamed as follows:
% Renamed the `abntex2.cls, v-1.9.6 laurocesar` to `setup/ufscthesisx.sty`
%

% Define versão necessária do LaTeX
\NeedsTeXFormat{LaTeX2e}

% q/missing-number-treated-as-zero-what-is-wrong-in-here
\errorcontextlines 10000

\makeatletter

%-------------------------------------------------------------------------------
%   PACKAGES AND OTHER DOCUMENT CONFIGURATIONS BEFORE LOADING abntex2
%-------------------------------------------------------------------------------

% For web links and paths with \path{..}
% and \url{https://www.python.org/downloads/}
% ftp://tug.ctan.org/pub/tex-archive/macros/latex/contrib/hyperref/doc/options.pdf
% q/forcing-linebreaks-in-url
% q/applying-options-to-already-loaded-package
\PassOptionsToPackage{hyphens}{url}

% Use its macro adjustwidth* to extend tables out of outer text border.
% q/how-to-write-a-table-a-little-larger-than-the-paragraphs-with-centered-columns
\PassOptionsToPackage{strict}{changepage}

% Linked footnotes are not supported inside environment `tabularx', because they
% uses the optional argument of \footnotetext
% http://ctan.sharelatex.com/tex-archive/macros/latex/contrib/hyperref/README.pdf
\PassOptionsToPackage{hyperfootnotes=false}{hyperref}

% The class `abntex2` loads the `enumitem` package with options.
% With the package option shortlabels you can use an enumerate-like syntax,
% where A, a, I, i and 1 stand for \Alph*, \alph*, \Roman*, \roman* and
% \arabic*. This is intended mainly as a sort of compatibility mode with the
% enumerate package, and therefore the following special rule applies: if the
% very first option (at any level) is not recognized as a valid key, then it
% will be considered a label with the enumerate-like syntax.
% q/no-spacing-between-enumerated-items-with-usepackageenumerate
\PassOptionsToPackage{shortlabels}{enumitem}

% Fixes `pdfTeX warning (ext4):
% destination with the same identifier (name{figure.1.1}) has been already used,
% duplicate ignored`.
%
% The `abntex2` package loads the `hyperref` package, however there are several
% packages which are required to be loaded after and before `hyperref`.
%
% q/which-packages-should-be-loaded-after-hyperref-instead-of-before
% q/hyperref-is-loaded-by-the-class-and-i-need-to-load-packages-that-are-supposed-t
% q/using-beforepackage-to-load-a-package-before-hyperref-does-not-work
\RequirePackage{scrlfile}
\AfterClass{memoir}{
  \RequirePackage{float}
}

% The class `abntex2`
% loads the package `enumitem`, but `paralist` must be loaded before it
% q/compilation-error-when-including-enumitem-and-paralist-packages
\AfterClass{memoir}{
  % How to make horizontal lists?
  % q/how-to-make-horizontal-lists
  \RequirePackage{paralist}
}

% q/newline-linebreak-in-message
% q/biblatex-error-incompatible-backref-package
% q/backreferencing-in-classicthesis-package-does-not-work
% q/why-my-biblatex-document-is-not-accepting-utf-8-on-the-bibliography
% q/how-to-print-out-to-log-without-affecting-anything-else-lua-print-equiv
% q/how-to-detect-whether-passoptionstopackage-was-already-called
\ifcsname opt@biblatex.sty\endcsname
  \message{Have options been passed for biblatex? YES!^^J}
\else
  \message{Have options been passed for biblatex? NO!^^J}
  \PassOptionsToPackage{%
    style=abnt,
    backend=biber,
    repeatfields=true,
    backref=true,
    citecounter=true
  }{biblatex}
\fi

\AfterClass{memoir}{
  \RequirePackage{biblatex}
}

% Package longtable must be put before hyperref and arydshln,
% hyperref after arydshln generates an error
% http://ctan.sharelatex.com/tex-archive/macros/latex/contrib/hyperref/README.pdf
\AfterClass{memoir}{
  \RequirePackage{longtable}
}

% q/how-to-silence-memoir-class-warning-against-the-use-of-caption-package
\RequirePackage{silence}
\WarningFilter*{memoir}{You are using the caption package with the memoir class}

% q/can-i-silence-a-warning-which-is-coming-from-a-file-like-bigfoot-sty
\WarningFilter*{hyperref}{Option `hyperfootnotes' has already been used}

% Prove acesso a classe 'ufscthesisx'
\ProvidesClass{setup/ufscthesisx}[2016/11/15 1.0.0 setup/ufscthesisx]

% How can I properly resolve relative paths in `\usepackage`?
% q/how-can-i-properly-resolve-relative-paths-in-usepackage
%
% Commenting this allow to use this as a relative package, with no warnings.
% \ProvidesPackage{ufscthesisx}[2017/08/28 v0.0.1 Evandro]

% Repassa todos os parâmetros a classe abntex2,
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{setup/abntex2}%
}

% https://en.wikibooks.org/wiki/LaTeX/Creating_Packages
% q/processoptions-and-processkeyvaloptions
% q/new-options-and-loaded-class-options-bug
% Now we'll execute any options passed in
\ProcessOptions\relax
\LoadClass{setup/abntex2}

% https://github.com/evandrocoan/ufscthesisx-light/runs/915876094?check_suite_focus=true#step:5:658
\RequirePackage{ifthen} % q/why-is-the-ifthen-package-obsolete
\RequirePackage{ifplatform}
\RequirePackage{shellesc}
\RequirePackage{xstring}

% Custom list throw LaTeX Error: Command \mycustomfiction already defined?
% q/custom-list-throw-latex-error-command-mycustomfiction-already-defined
\RequirePackage{morewrites}

% Package csquotes Warning: Load 'inputenc' before 'csquotes'
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}

% Indent the first section paragraphs
% q/no-indent-in-the-first-paragraph-in-a-section
\RequirePackage{indentfirst}

% Is it possible to keep my translation together with original text?
% q/is-it-possible-to-keep-my-translation-together-with-original-text
\RequirePackage{comment}

% Please tutor the usage of patchcmd and xpatch
% q/please-tutor-the-usage-of-patchcmd-and-xpatch
\RequirePackage{xpatch}

% Why the environment ttfamily is hyphenated,
% but macro ttfamily is not hyphenating?
% q/why-the-environment-ttfamily-is-hyphenated-but-macro-ttfamily-is-not-hyphenatin
\RequirePackage{letltxmacro}

% Theorem packages: which to use, which conflict?
% q/theorem-packages-which-to-use-which-conflict
\RequirePackage{amsthm}

% Why is the ifthen package obsolete? (It is used by the abntex2 class)
% q/why-is-the-ifthen-package-obsolete
\RequirePackage{ifthen}

% How to make section name uppercase in ToC?
% q/how-to-make-section-name-uppercase-in-toc
\RequirePackage{textcase}

% q/how-to-add-babel-captions-to-newfloat-package-environments
\RequirePackage{newfloat}
\RequirePackage{caption}

% How to auto adjust my last table column width,
% and why is there Underfull \vbox badness on this table?
% q/how-to-auto-adjust-my-last-table-column-width-and-why-is-there-underfull-vbox/387251
%
% Why ltablex package breaks the changepage package?
% q/why-ltablex-package-breaks-the-changepage-package
\RequirePackage{ltablex}\keepXColumns

% CONFIGURAÇÕES DE PACOTES
\newcommand{\UFSCifNotEmpty}[2]{\ifthenelse{\not\equal{#1}{}}{#2}{}}
\newcommand{\UFSCifNotDefined}[3]{\ifdefined #1 #3 \else #2 \fi}

% Comandos de dados - programa
\providecommand{\imprimirprograma}{}
\newcommand{\UFSCprograma}[1]{\renewcommand{\imprimirprograma}{#1}}

\providecommand{\imprimirformacao}{}
\newcommand{\UFSCformacao}[1]{\renewcommand{\imprimirformacao}{#1}}

\providecommand{\imprimirarea}{}
\newcommand{\UFSCarea}[1]{\renewcommand{\imprimirarea}{#1}}

\providecommand{\imprimirbiblioteca}{}
\newcommand{\UFSCbiblioteca}[1]{\renewcommand{\imprimirbiblioteca}{#1}}

\providecommand{\abnteximprimirinstituicaosigla}{}
\newcommand{\UFSCinstituicaoSigla}[1]{%
  \renewcommand{\abnteximprimirinstituicaosigla}{#1}
}

\providecommand{\imprimirano}{}
\newcommand{\UFSCano}[1]{\renewcommand{\imprimirano}{#1}}

\newcommand{\UFSCcovername}{Capa}

% Comandos de dados - Coordenador
\newcommand{\UFSCcoordenadorname}{Coordenador}
\providecommand{\imprimircoordenadorRotulo}{}
\providecommand{\imprimircoordenador}{}
\newcommand{\UFSCcoordenador}[2][UFSCcoordenadorname]{%
  \renewcommand{\imprimircoordenadorRotulo}{#1}%
  \renewcommand{\imprimircoordenador}{#2}%
}

% inclui subtitulo na capa, folha de rosto e ficha catalografica
% lrsantos11/abntex2-ufsc/commit/fd30245353dcc49e193d281c78104afe54df9fe7
%
% Cria o comando UFSCsubtitulo.
% A norma define que o TITULO deve ser em caixa alta negrito,
% mas o subtitulo deve ser em caixa baixa.
\providecommand{\imprimirsubtitulo}{}
\newcommand{\UFSCsubtitulo}[1]{\renewcommand{\imprimirsubtitulo}{#1}}

\newcounter{ufscthesisx@assuntos}
\providecommand{\listaassuntos}{}
\providecommand{\imprimirassuntos}{%
  \setcounter{ufscthesisx@assuntos}{1}
  \@for\assunto:={\listaassuntos}\do{%
    \arabic{ufscthesisx@assuntos}.\assunto. %
    \addtocounter{ufscthesisx@assuntos}{1}
  }
}
\newcommand{\UFSCassuntos}[1]{\renewcommand{\listaassuntos}{#1}}

\providecommand{\imprimircentro}{}
\newcommand{\UFSCcentro}[1]{\renewcommand{\imprimircentro}{#1}}

\providecommand{\imprimircampus}{}
\newcommand{\UFSCcampus}[1]{\renewcommand{\imprimircampus}{#1}}

\newtheorem{UFSCaxioma}{Axioma}[chapter]
\newtheorem{UFSCpostulado}{Postulado}[chapter]
\newtheorem{UFSCteorema}{Teorema}[chapter]
\newtheorem{UFSCconjectura}{Conjectura}[chapter]
\newtheorem{UFSCcorolario}[UFSCteorema]{Corol\'ario}
\newtheorem{UFSClema}[UFSCteorema]{Lema}
\newtheorem{UFSCproposicao}[UFSCteorema]{Proposi\c{c}\~ao}

% Commonly used in definitions, conditions, problems and examples.
\theoremstyle{definition}
\newtheorem{UFSCdefinicao}{Defini\c{c}\~ao}[chapter]
\newtheorem{UFSCexemplo}{Exemplo}[section]
\newtheorem{UFSCexercicio}{Exerc\'icio}[section]
\newtheorem{UFSCcondicao}{Condi\c{c}\~ao}[chapter]

\theoremstyle{remark}
\newtheorem{UFSCobservacao}{Observa\c{c}\~ao}

\renewcommand{\qedsymbol}{$\blacksquare$}

% Margens
% q/how-to-set-margins-in-memoir-class
\setlrmarginsandblock{3cm}{2cm}{*}
\setulmarginsandblock{3cm}{2cm}{*}
\checkandfixthelayout

% Fontes dos títulos e seções
% Tamanho da fonte padrão do 'ABNTEX'
% q/set-font-size-and-line-spacing
% Set the default font size as 12pt
% with 1.5cm spacing between lines, 12/2 = 6, 12+6 = 18, i.e., one half spacing
% \renewcommand{\normalsize}{\fontsize{12pt}{16pt}\selectfont}
% \renewcommand{\normalsize}{\fontsize{12.0pt}{18.0pt}\selectfont}

% Caption package and Memoir
% https://groups.google.com/forum/#!topic/comp.text.tex/RzpI2ATMev0
% q/memoir-class-with-subcaption-and-hyperref-packages
\DeclareCaptionFont{small}{\fontsize{10pt}{12pt}\selectfont}
\renewcommand{\footnotesize}{\fontsize{10pt}{12pt}\selectfont}

% Set caption font size in memoir
% q/set-caption-font-size-in-memoir
% q/controlling-the-spacing-between-lines-with-fontsize-selectfont
\newcommand{\UFSCcaptionSize}{\fontsize{10pt}{12pt}\selectfont}

% https://latex.org/forum/viewtopic.php?t=22437
% q/how-does-footnotesep-work-anyway
% q/make-footnotesep-same-as-line-spacing-using-custom-thesis-class
% q/how-can-i-see-the-line-spacing-between-lines
% q/how-to-get-the-normalsize-or-small-font-baselineskip-size
\setlength{\footnotesep}{\f@baselineskip}

% q/how-to-put-figure-caption-on-top
\captionnamefont{\UFSCcaptionSize}
\captiontitlefont{\UFSCcaptionSize}

% Paragraph size is given by
% Default value for UFSC 1.5cm
\setlength{\parindent}{1.5cm}

% Package setspace must be put before hyperref
% http://ctan.sharelatex.com/tex-archive/macros/latex/contrib/hyperref/README.pdf
% q/undefined-control-sequence-on-onehalfspacing
% q/setting-text-in-onehalfspacing-footnotes-singlespacing-with-memoir
\@ifclassloaded{memoir}{}{
  % \SingleSpacing
  \OnehalfSpacing
  % \DoubleSpacing
}

% Set the UFSC epigrafe font size
% Changing font size in an example environment
% q/changing-font-size-in-an-example-environment
\expandafter\def\expandafter\abntexEnvEpigrafe\expandafter{%
  \abntexEnvEpigrafe\UFSCcaptionSize%
}

% Selects a roman (i.e., serifed) font family
% \renewcommand{\rmdefault}{cmr}
% q/renewcommand-familydefault-sfdefault-is-causing-%e2%86%92-to-throw-package-textcomp
\renewcommand{\familydefault}{\sfdefault}

% Fontes padroes de part, chapter, section, subsection e subsubsection
\renewcommand{\ABNTEXfontereduzida}{\fontsize{10pt}{12pt}\selectfont}

\renewcommand{\ABNTEXchapterfont}{%
  \sffamily\fontseries{bx}\fontshape{n}%
  \selectfont%
}
\renewcommand{\ABNTEXchapterfontsize}{%
  \normalsize%
  \selectfont%
}
\renewcommand{\ABNTEXpartfont}{%
  \sffamily\fontseries{bx}\fontshape{n}%
  \selectfont%
}
\renewcommand{\ABNTEXpartfontsize}{%
  \Huge%
  \selectfont%
}
\renewcommand{\ABNTEXsectionfont}{%
  \sffamily\fontseries{m}\fontshape{n}%
  \selectfont%
}
\renewcommand{\ABNTEXsectionfontsize}{%
  \normalsize%
  \selectfont%
}
\renewcommand{\ABNTEXsubsectionfont}{%
  \sffamily\fontseries{b}\fontshape{n}%
  \selectfont%
}
\renewcommand{\ABNTEXsubsectionfontsize}{%
  \normalsize%
  \selectfont%
}
\renewcommand{\ABNTEXsubsubsectionfont}{%
  \sffamily\fontseries{m}\fontshape{n}%
  \selectfont%
}
\renewcommand{\ABNTEXsubsubsectionfontsize}{%
  \normalsize%
  \selectfont%
}
\renewcommand{\ABNTEXsubsubsubsectionfont}{%
  \sffamily\fontseries{m}\fontshape{it}%
  \selectfont%
}
\renewcommand{\ABNTEXsubsubsubsectionfontsize}{%
  \normalsize%
  \selectfont%
}

% Tamanho da fonte para a epígrafe UFSC
\expandafter\def\expandafter\abntexEnvEpigrafe\expandafter{%
  \abntexEnvEpigrafe\ABNTEXfontereduzida%
}

% Comando que simula a finalizacao de uma parte no bookmark e
% adiciona espaco de \part no sumario
\renewcommand{\ABNTEXphantompart}{%
  \bookmarksetup{startatroot}%
  \phantomsection%
  \addtocontents{toc}{\vspace{0em}}
}

% TOC Spacing in Memoir
% q/toc-spacing-in-memoir
\setlength{\cftbeforechapterskip}{12pt}

% Fontes das entradas do sumario
% q/how-to-make-the-table-of-contents-section-title-upper-case-without-messing-with
% q/how-to-make-section-name-uppercase-in-toc
\let\oldcontentsline\contentsline
\def\contentsline#1#2{%
  \expandafter\ifx\csname l@#1\endcsname\l@section
    \expandafter\@firstoftwo
  \else
    \expandafter\@secondoftwo
  \fi
  {%
    \oldcontentsline{#1}{\MakeTextUppercase{#2}}%
  }{%
    \oldcontentsline{#1}{#2}%
  }%
}

% No caso de Sumario (TOC) UFSC
%
% Memoir has another mechanism for the job:
% \cftsetindents{‹kind›}{indent}{numwidth}. Here kind is chapter, section, or
% whatever; the indent specifies the ‘margin’ before the entry starts; and the
% width is of the box into which the number is typeset (so needs to be wide
% enough for the largest number, with the necessary spacing to separate it from
% what comes after it in the line.
% http://www.tex.ac.uk/FAQ-tocloftwrong.html
%
% memoir: indentation of unnumbered sections in table of contents
% q/memoir-indentation-of-unnumbered-sections-in-table-of-contents
%
% Memoir ToC: indent the second line by number+space width
% in the previous line OR set standard
% q/memoir-toc-indent-the-second-line-by-numberspace

% `\cftlastnumwidth` and these `\cftsetindents` are defined by abntex2 class,
% obeying the `ABNTEXsumario-abnt-6027-2012`. \newlength{\cftlastnumwidth}
\setlength{\cftlastnumwidth}{\cftsubsubsectionnumwidth}
\addtolength{\cftlastnumwidth}{1em}

% http://www.tex.ac.uk/FAQ-tocloftwrong.html
% Use \setlength\cftsectionnumwidth{4em} to override all these values
\cftsetindents{part}         {0em}{\cftlastnumwidth}
\cftsetindents{chapter}      {0em}{\cftlastnumwidth}
\cftsetindents{section}      {0em}{\cftlastnumwidth}
\cftsetindents{subsection}   {0em}{\cftlastnumwidth}
\cftsetindents{subsubsection}{0em}{\cftlastnumwidth}
\cftsetindents{paragraph}    {0em}{\cftlastnumwidth}
\cftsetindents{subparagraph} {0em}{\cftlastnumwidth}

\newlength{\cftnumberboxnumberwidth}
\setlength{\cftnumberboxnumberwidth}{2em}
\renewcommand{\ABNTEXtocprintchapter}{%
  \addtocontents{toc}{\cftsetindents{chapter}{0em}{\cftlastnumwidth}}
}

\renewcommand{\ABNTEXtocinnonumchapter}{%
  \addtocontents{toc}{%
    \cftsetindents{chapter}{\cftlastnumwidth}{\cftnumberboxnumberwidth}
  }%
  \cftinserthook{toc}{A}
}
\renewcommand{\ABNTEXtocprintchapternonum}{%
  \addtocontents{toc}{%
    \cftsetindents{chapter}{\cftlastnumwidth}{\cftnumberboxnumberwidth}
  }%
}

\renewcommand{\ABNTEXtocpartapendices}{%
  \addtocontents{toc}{%
    \cftsetindents{chapter}{\cftlastnumwidth}{\cftnumberboxnumberwidth}
  }%
  \cftinserthook{toc}{A}
}

\renewcommand{\ABNTEXtocpartanexos}{%
  \addtocontents{toc}{%
    \cftsetindents{chapter}{\cftlastnumwidth}{\cftnumberboxnumberwidth}
  }%
  \cftinserthook{toc}{A}
}

\renewcommand{\cftpartfont}{\ABNTEXpartfont}
\renewcommand{\cftpartpagefont}{\cftpartfont}

\renewcommand{\cftchapterfont}{\ABNTEXchapterfont}
\renewcommand{\cftchapterpagefont}{\cftchapterfont}

\renewcommand{\cftsectionfont}{\ABNTEXsectionfont}
\renewcommand{\cftsectionpagefont}{\cftsectionfont}

\renewcommand{\cftsubsectionfont}{\ABNTEXsubsectionfont}
\renewcommand{\cftsubsectionpagefont}{\cftsubsectionfont}

\renewcommand{\cftsubsubsectionfont}{\ABNTEXsubsubsectionfont}
\renewcommand{\cftsubsubsectionpagefont}{\cftsubsubsectionfont}

\renewcommand{\cftparagraphfont}{\ABNTEXsubsubsubsectionfont}
\renewcommand{\cftparagraphpagefont}{\cftparagraphfont}

% Ajusta entrada Referencias
\renewcommand{\bibsection}{%
  \chapter*{\bibname}
  \bibmark
  \ifnobibintoc\else
  \phantomsection
  \addcontentsline{toc}{chapter}{\uppercase{\bibname}}
  \fi
  \prebibhook
}

% Espaçamento depois do título
\setlength{\afterchapskip}{0.38cm}

% Controle do espaçamento entre um parágrafo e outro. Tente também \onelineskip
\setlength{\parskip}{0.0cm}

% O tamanho do parágrafo é dado por
\setlength{\parindent}{1.0cm}

% Recuo citação
\setlength{\ABNTEXcitacaorecuo}{3cm} %4, mas abntex2 está somando 1cm

% Comando para inverter sobrenome e nome
\newcommand{\ufscthesisx@inverter}[1]{%
  \StrBehind{#1}{{}},
  \StrBefore{#1}{{}}
}

% Comandos auxiliares
% q/how-can-i-see-the-line-spacing-between-lines
\newcommand{\UFSCshowFont}{%
  (\foreignlanguage{english}
  {%
    encoding: \f@encoding{},
    family: \f@family{},
    series: \f@series{},
    shape: \f@shape{},
    size: \f@size{},
    baseline: \f@baselineskip{},
    linespread: \f@linespread{},
    linespacing: \the\baselineskip{}%
  })%
}

% Comandos auxiliares
\newcommand{\UFSCjustShowFont}{%
  (\foreignlanguage{english}
  {%
    \f@encoding{},
    \f@family{},
    \f@series{},
    \f@shape{},
    \f@size{},
    \f@baselineskip{},%
    \f@linespread{},
    \the\baselineskip{}%
  })%
}

% Numeração dos floats por capítulo
\counterwithin{figure}{chapter}
\counterwithin{table}{chapter}

% Macros for Cross-reference
\newcommand{\figref}[1]{Figura~\ref{#1}}    % Cross-reference of figures
\newcommand{\tabref}[1]{Tabela~\ref{#1}}    % Cross-reference of tables
\newcommand{\eqnref}[1]{\eqref{#1}}         % Cross-reference of equations
\newcommand{\secref}[1]{Seção~\ref{#1}}     % Cross-reference of equations
\newcommand{\defref}[1]{Definição~\ref{#1}} %

\renewenvironment{abntexEnvResumo}[1][\ABNTEXresumoname]{%
  % Fixed double bookmark entries as `\ABNTEXpretextualchapter`
  % bellow is already calling `\ABNTEXPRIVATEbookmarkthis`
  % \ABNTEXPRIVATEbookmarkthis{#1}
  % \renewcommand{\abstractnamefont}{\chaptitlefont}
  % \renewcommand{\abstractname}{\ABNTEXchapterupperifneeded{#1}}
  \ABNTEXpretextualchapter{#1}
}{%
  \ABNTEXPRIVATEclearpageifneeded
}

% Fix the resumo environment, which does not accept paragraphs on ufscthesisx
%
% Changing font size in an example environment
% q/changing-font-size-in-an-example-environment
%
% How to disable automatic indentation on new paragraphs?
% q/how-to-disable-automatic-indentation-on-new-paragraphs
%
% How to disable paragraphs inside my environment with \let\par\relax?
% q/how-to-disable-paragraphs-inside-my-environment-with-let-par-relax
\xapptocmd{\resumo}{%
  \setlength{\parindent}{0pt}\SingleSpacing\let\parOriginal\par\let\par\relax
}{}{}
\xpretocmd{\endresumo}{\endgraf}{}{}

% \UFSCimprimirPalavrasChave{Palavras-chaves}{latex. abntex. editoração de texto.}
\newcommand{\UFSCimprimirPalavrasChave}[2]{%
  \@ifundefined{parOriginal}{}{\parOriginal}\vspace{\onelineskip}\textbf{#1}: #2
}

% Create a list of things like (\usepackage{paralist})
%   \UFSCpalavrasChave{englishkeywordslist}{keyword 1}
%   \UFSCpalavrasChave{englishkeywordslist}{keyword 2}
%   \begin{inparaitem}[]\englishkeywordslist\end{inparaitem}
%   \begin{inparaenum}\englishkeywordslist\end{inparaenum}
%
% q/how-to-define-inparaenum-in-the-preamble
% q/lonely-item-perhaps-a-missing-list-environment-missing-package
% q/how-do-you-define-one-macro-with-arguments-inside-another
% q/defining-macros-with-arguments
% q/macro-defining-macro
% q/removing-a-backslash-when-passing-arguments-to-newcommand
\newcommand{\UFSCpalavrasChave}[2]{%
  \@ifundefined{#1}{%
    \message{^^JNotice palavraschaveufsc: #1 is undefined with '#2'^^J}
    \expandafter\newcommand\csname#1\endcsname{}
  }{\message{^^JNotice palavraschaveufsc: #1 is defined with '#2'^^J}}
  {\expandafter\g@addto@macro\csname#1\endcsname{\item #2. }}

  \@ifundefined{#1comvirgula}{%
    \message{^^JNotice palavraschaveufsc: #1 is undefined with '#2'^^J}
    \expandafter\newcommand\csname#1comvirgula\endcsname{}
  }{\message{^^JNotice palavraschaveufsc: #1 is defined with '#2'^^J}}
  {\expandafter\g@addto@macro\csname#1comvirgula\endcsname{\item #2, }}

  \@ifundefined{#1semitem}{%
    \message{^^JNotice palavraschaveufsc: #1 is undefined with '#2'^^J}
    \expandafter\newcommand\csname#1semitem\endcsname{}
  }{\message{^^JNotice palavraschaveufsc: #1 is defined with '#2'^^J}}
  {\expandafter\g@addto@macro\csname#1semitem\endcsname{#2. }}
}

% ------------------------------------------------------------------------
% Configura layout
% ------------------------------------------------------------------------

% ------------------------------------------------------------------------
% criar um novo estilo incluindo logos da UFSC
% ------------------------------------------------------------------------

% Configura layout para elementos textuais,
% redefining the ABNT command `\ABNTEXtextual`.
% Delete his to restore the ABNT default behavior.
\renewcommand{\ABNTEXtextual}{%
  % Estilo original do Abntex2
  \pagestyle{abntheadings}

  % Remove a numeração das páginas no início dos capítulos.
  % ABNT default value `{chapter}{abntchapfirst}`
  \aliaspagestyle{chapter}{empty}

  \nouppercaseheads
  \bookmarksetup{startatroot}
}

% ------------------------------------------------------------------------
% Comandos e ambientes de editoracao APENDICES e ANEXOS
% ------------------------------------------------------------------------
% Imprime uma pagina de divisao no estilo parte
\renewcommand{\ABNTEXpartpage}{%
  % \phantomsection
  % \addcontentsline{toc}{part}{\appendixtocname}
  \appendixpage*
}

% Impressão da Capa
\renewcommand{\ABNTEXimprimircapa}{%
  \begin{abntexEnvCapa}%

    \center
    {%
      % https://en.wikibooks.org/wiki/LaTeX/Floats,_Figures_and_Captions
      \includegraphics[width=1.84cm,keepaspectratio]{UFSC_sigla_fundo_claro.png}

      {%
        % q/controlling-the-spacing-between-lines-with-fontsize-selectfont
        \OnehalfSpacing
        \MakeTextUppercase{\abnteximprimirinstituicao}\par
        \MakeTextUppercase{\imprimircampus}\par
        \MakeTextUppercase{\imprimirprograma}\par
      }
    }

    \vfill

    \theauthor

    \vfill
    {%
      \center
      {\ABNTEXchapterfont\MakeUppercase{\thetitle}}%
      \UFSCifNotEmpty{\imprimirsubtitulo}{%
        {\ABNTEXchapterfont:} \par \imprimirsubtitulo%
      }
    }
    \vfill

    {%
      \abnteximprimirlocal\par
      \imprimirano\par
    }
    \vspace*{1cm}
  \end{abntexEnvCapa}
}

% Conteúdo padrao da Folha de Rosto
%
% Underfull \hbox (badness 10000) message
% q/underfull-hbox-badness-10000-message
%
% Underfull \hbox (badness …) in paragraph at lines x-y
% q/underfull-hbox-badness-in-paragraph-at-lines-x-y
%
% How to add an empty line between paragraphs?
% q/how-to-add-an-empty-line-between-paragraphs
\renewcommand{\ABNTEXfolhaderostocontent}{%
  \begin{center}
    \theauthor

    \vspace*{\fill}\vspace*{\fill}
    \begin{center}

      {%
        {\ABNTEXchapterfont\MakeUppercase{\thetitle}}%
        \UFSCifNotEmpty{\imprimirsubtitulo}{%
          {\ABNTEXchapterfont:} \par \imprimirsubtitulo%
        }
      }

    \end{center}
    \vspace*{\fill}

    \abntex@UFSCifNotEmpty{\abnteximprimirpreambulo}
    {%
      \hspace{\textwidth}
      \begin{adjustwidth*}{8cm}{}%8.5

        \SingleSpacing
        {\UFSCcaptionSize\abnteximprimirpreambulo}

        \vspace{1em}

        {
          \UFSCcaptionSize\textbf{%
            \abnteximprimirorientadorRotulo:%
          }~\abnteximprimirorientador\par
          \abntex@UFSCifNotEmpty{\abnteximprimircoorientador}
          {
            \textbf{%
              \abnteximprimircoorientadorRotulo:%
            }~\abnteximprimircoorientador%
          }
        }

      \end{adjustwidth*}
    }

    \vspace*{\fill}
    {%
      \abnteximprimirlocal\par
      \imprimirano\par
    }

  \end{center}
}

% If document class is equal to something then do not use package
% q/if-document-class-is-equal-to-something-then-do-not-use-package
\@ifclassloaded{setup/abntex2}{
  % Package hyperref Warning: Token not allowed in a PDF string?
  % q/package-hyperref-warning-token-not-allowed-in-a-pdf-string
  \pdfstringdefDisableCommands{\let\uppercase\relax}
}{}

% Backward compatibility with `abntex2cite` package
% `\citeonline` command with the new `biblatex` package
% q/what-is-the-difference-between-def-and-newcommand
\let\citeonline\textcite

% q/inline-citations-with-only-author-title-and-year
\DeclareCiteCommand{\citeauthortitleyear}{%
  \boolfalse{citetracker}%
  \boolfalse{pagetracker}%
  \usebibmacro{prenote}
}{%
  \ifciteindex{%
    \indexnames{labelname}\indexfield{indextitle}%
  }{}%
  \printfield{labeltitle}%
  \setunit{\addcomma\space}%
  \printtext[bibhyperref]{%
    \printnames{labelname}%
    \space%
    (\printfield{year})%
  }%
}{%
  \multicitedelim%
}{%
  \usebibmacro{postnote}%
}

% q/how-to-appear-subsubsection-in-chapter-in-my-list-of-contents
\setcounter{secnumdepth}{6}
\setcounter{tocdepth}{6}

% README.md
% Copyright 2017 Evandro Coan
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is M. Y. Name.
%
% This work consists of the files:
% 1. `README.md`,
% 2. `basic.tex`,
% 3. `commands.tex`,
% 4. `commands_list.tex`
% 5. `programming.tex`
% 6. `badboxes.tex`

% Please tutor the usage of patchcmd and xpatch
% q/please-tutor-the-usage-of-patchcmd-and-xpatch
\usepackage{xpatch}

% Incompatible color definition when using tikz with color package
% q/incompatible-color-definition-when-using-tikz-with-color-package
\usepackage{xcolor}

% RGB colors in absolute values from 0 to 255 by using `RGB` tag
\definecolor{darkblue}{RGB}{26,13,178}

% RGB colors in percentage notation by using `rgb` tag
\definecolor{darkgreen}{rgb}{0,0.6,0}
\definecolor{gray}{rgb}{0.5,0.5,0.5}
\definecolor{mauve}{rgb}{0.58,0,0.82}

% Increase the space around the hyphen or dash - on the table of contents
% APÊNDICE A –- SOMETHING . . . . . . . . . . . . . . . . . . . . . . . . . . 3
%
% q/how-to-increase-memoir-table-of-contents-spacing-between-appendix-and-its-hyphen
% q/word-appendix-in-toc-with-memoir-class
% q/please-tutor-the-usage-of-patchcmd-and-xpatch
% https://texfaq.org/FAQ-protect
\xpretocmd{\l@appendix}{\def\@chapapp@extrahyphenspaces{~}}{%
  \message{%
    ^^J^^JChapterformat patch 1 for chapternumberline could SUCCESSFULLY!^^J % ^^J^^J^^J
  }
}{%
  \message{%
    ^^J^^JChapterformat patch 1 for chapternumberline could NOT be applied!^^J^^J^^J^^J
  }%
}

\xpretocmd{\l@chapter}{\def\@chapapp@extrahyphenspaces{}}{%
  \message{%
    ^^J^^JChapterformat patch 2 for chapternumberline could SUCCESSFULLY!^^J % ^^J^^J^^J
  }%
}{%
  \message{%
    ^^J^^JChapterformat patch 2 for chapternumberline could NOT be applied!^^J^^J^^J^^J
  }%
}

\patchcmd{\chapternumberline}{\@cftasnum}{%
  \@chapapp@extrahyphenspaces%
  \@chapapp@extrahyphenspaces%
  \@cftasnum%
  \@chapapp@extrahyphenspaces%
}{%
  \message{%
    ^^J^^JChapterformat patch 3 for chapternumberline could SUCCESSFULLY!^^J % ^^J^^J^^J
  }%
}{%
  \message{%
    ^^J^^JChapterformat patch 3 for chapternumberline could NOT be applied!^^J^^J^^J^^J
  }%
}

\patchcmd{\chapternumberline}{\@cftasnumb}{%
  \@cftasnumb%
  \@chapapp@extrahyphenspaces%
}{%
  \message{%
    ^^J^^JChapterformat patch 4 for chapternumberline could SUCCESSFULLY!^^J % ^^J^^J^^J
  }%
}{%
  \message{%
    ^^J^^JChapterformat patch 4 for chapternumberline could NOT be applied!^^J^^J^^J^^J
  }%
}

% q/the-appendix-word-disappears-from-the-table-of-contents-when-using-include
% q/whats-the-difference-between-newcommand-and-newcommand
\@ifclassloaded{setup/abntex2}{
  \renewcommand*{\cftappendixname}{\ABNTEXapendicename\space\space}
}{}

% Allows putting an [H] in \begin{figure}
% to specify the exact location of the figure
% q/force-figure-placement-in-text
%
% Package float must be put before hyperref
% http://ctan.sharelatex.com/tex-archive/macros/latex/contrib/hyperref/README.pdf
\usepackage{float}

% bigfoot.sty:61:
% Package hyperref Warning: Option `hyperfootnotes' has already been used
% q/bigfoot-sty61-package-hyperref-warning-option-hyperfootnotes-has-already-be
\@ifpackageloaded{hyperref}{%
  \hypersetup{hyperfootnotes=false}
}{%
  \PassOptionsToPackage{hyperfootnotes=false}{hyperref}
}
\usepackage{hyperref}

% \lettrine{O}{nce} upon a time...
% \lettrine[findent=2pt]{\fbox{\textbf{T}}}{ }his thesis deals with...
%
% q/starting-a-paragraph-with-a-big-letter
\usepackage{lettrine}

% Allows in-line images such as the example fish picture
\usepackage{wrapfig}

% How to automatically force latex to not justify the text when it is not wise?
% q/how-to-automatically-force-latex-to-not-justify-the-text-when-it-is-not-wise
\usepackage{array,ragged2e}

% Use its macro adjustwidth* to extend tables out of outer text border.
% q/how-to-write-a-table-a-little-larger-than-the-paragraphs-with-centered-columns
%
% The `memoir` class emulates this package,
% so not try to load it when using `memoir`, ifpackageloaded question
% q/ifpackageloaded-question
\@ifpackageloaded{changepage}{}{\usepackage[strict]{changepage}}

% How to make horizontal lists?
% q/how-to-make-horizontal-lists
%
% Compilation error when including enumitem and paralist packages
% q/compilation-error-when-including-enumitem-and-paralist-packages
\usepackage{paralist}

% Replace the `paralist` package implementation of enumerate lists
\usepackage{enumerate}

% With the package option shortlabels you can use an enumerate-like syntax,
% where A, a, I, i and 1 stand for \Alph*, \alph*, \Roman*, \roman* and
% \arabic*. This is intended mainly as a sort of compatibility mode with the
% enumerate package, and therefore the following special rule applies: if the
% very first option (at any level) is not recognized as a valid key, then it
% will be considered a label with the enumerate-like syntax.
%
% No spacing between enumerated items with \usepackage{enumerate}
% q/no-spacing-between-enumerated-items-with-usepackageenumerate
\usepackage[shortlabels]{enumitem}

\usepackage{tabularx}
\usepackage{multirow}

% The package supports the Text Companion fonts,
% which provide many text symbols
% such as % baht, bullet, copyright, musicalnote, onequarter, section, and yen)
% in the TS1 encoding.
%
% `LaTeX Error: Option clash for package textcomp` with the package `mathcomp`,
% it need to be loaded before it.
% q/how-do-you-resolve-the-error-in-latex-option-clash-for-package-inputenc-usepa
% q/setting-familydefault-as-sfdefault-is-causing-the-arrow-character-%e2%86%92-to-throw-p
\usepackage[full,warn]{textcomp}
\usepackage{mathcomp}

% Número da última página
\usepackage{lastpage}

% Tamanho das fontes
\usepackage{anyfontsize}

% Usa a fonte Latin Modern
\usepackage{lmodern}

% q/blank-page-after-titlingpage
\usepackage{atbegshi}

% Selecao de codigos de fonte
% q/why-should-i-use-usepackaget1fontenc
%
% Will allow all displayable utf8 characters to be available as input
% q/utf8x-vs-utf8-inputenc
\usepackage[T1]{fontenc}

% Codificacao do documento (conversão automática dos acentos)
\usepackage[utf8]{inputenc}

\usepackage{graphicx}

\usepackage{pdfpages}
\usepackage{rotating}

% Needs to be loaded after hyperref
% http://ctan.sharelatex.com/tex-archive/macros/latex/contrib/hyperref/README.pdf
%
% Package incompatibilty between alphalph,
% and hyperref with amsmath subequations
% q/package-incompatibilty-between-alphalph-and-hyperref-with-amsmath-subequations
\usepackage{amsmath}
\let\equation\gather
\let\endequation\endgather

\usepackage{amssymb}
\usepackage{mathrsfs}
\usepackage{pdflscape}
\usepackage{epstopdf}
\usepackage{multirow}
\usepackage{listings}

% Para incluir links
\usepackage{url}

% Pacote necessário para a lista de siglas.
\usepackage{nomencl}
\usepackage{booktabs}

% A comprehensive (SI) units package
\usepackage{siunitx}
\sisetup{detect-all}
\sisetup{
  scientific-notation = fixed,
  fixed-exponent = 0,
  round-mode = places,
  round-precision = 2,
  output-decimal-marker = {,}
}
\DeclareSIUnit \VA {VA} % apparent power

% We need to load it after `siunitx` package,
% otherwise it will cause to the package `bigfoot` to throw
% the error `input stack size=5000`
% q/while-loading-fancyvrb-siunitx-and-bigfoot-i-got-input-stack-size-5000-tex-st
\usepackage{fancyvrb}

% gives you the possibility to rotate any object of an arbitrary angle.
\usepackage{rotating}

% Rotação de páginas no documento pdf.
\usepackage{pdflscape}

% Customize the look of the frame
\usepackage{mdframed}

% Pacotes adicionais, usados apenas no âmbito do Modelo Canônico do abnteX2
\usepackage{tablefootnote}
\usepackage{longtable}
\usepackage{tocloft}

% q/how-to-add-a-forced-line-break-inside-a-table-cell
\usepackage{makecell}
\usepackage{pbox}

% LaTeX not hyphenating properly, text running off page
% q/latex-not-hyphenating-properly-text-running-off-page
\usepackage{hyphenat}

% How to use \scalebox around my environment?
% q/how-to-use-scalebox-around-my-environment
\usepackage{verbatimbox}

% LaTeX/Indexing
% https://www.sharelatex.com/learn/Indices
% https://en.wikibooks.org/wiki/LaTeX/Indexing
\usepackage{makeidx}
\makeindex

% Is it possible to keep my translation together with original text?
% q/is-it-possible-to-keep-my-translation-together-with-original-text
\usepackage{comment}

% Scoping \raggedbottom to a single page
% q/scoping-raggedbottom-to-a-single-page
\usepackage{afterpage}

% Logical String Length
% q/logical-string-length
\usepackage{xstring}
\usepackage{xifthen}
\usepackage{ifplatform}
\usepackage{shellesc}

% abntex2
\usepackage{bookmark}
\usepackage{calc}

% cannot use \caption under minipage
% q/cannot-use-caption-under-minipage
\usepackage{capt-of}

% Custom list throw LaTeX Error: Command \mycustomfiction already defined?
% q/custom-list-throw-latex-error-command-mycustomfiction-already-defined
\usepackage{morewrites}

% q/how-to-nameref-multiple-labels-simultaneously
% http://mirror.las.iastate.edu/tex-archive/macros/latex/contrib/l3kernel/expl3.pdf
\ExplSyntaxOn

% #1: variant (cref, Cref, crefs or Crefs)
% #2: reference name (label)
\cs_new_protected:Npn \user_name_cref:nn #1#2
  { \use:c { name #1 } {#2} }

\cs_generate_variant:Nn \user_name_cref:nn { xV }

% #1: boolean expression (true: disable hyperlink)
% #2: reference name (label)
\cs_new_protected:Npn \user_name_ref:nn #1#2
  { \bool_if:nTF {#1} { \nameref* } { \nameref } {#2} }

\cs_generate_variant:Nn \user_name_ref:nn { nV }

\seq_new:N \l__user_name_refs_tmpa_seq
\seq_new:N \l__user_name_refs_tmpb_seq
\int_new:N \l__user_name_refs_nbrefs_int
\tl_new:N \l__user_name_refs_firstref_tl

% #1: boolean expression (true: Does put the label name, i.e., Figure My Figure)
% #2: boolean expression (true: start with capitalized letter, as in \Cref)
% #3: boolean expression (true: disable hyperlinks)
% #4: comma list of refs
\cs_new_protected:Npn \user_name_refs:nnnn #1#2#3#4 {
  \seq_set_from_clist:Nn \l__user_name_refs_tmpa_seq {#4}
  \int_set:Nn \l__user_name_refs_nbrefs_int
    { \seq_count:N \l__user_name_refs_tmpa_seq }
  \seq_get_left:NN \l__user_name_refs_tmpa_seq \l__user_name_refs_firstref_tl

  \bool_if:nTF {#1} {
    % (section, Section, sections or Sections)
    % or (theorem, Theorem, ...)
    % or...
    \user_name_cref:xV
      { \bool_if:nTF {#2} { C } { c }
        ref
        \int_compare:nNnTF { \l__user_name_refs_nbrefs_int } > { 1 } { s } { }
      }
      \l__user_name_refs_firstref_tl
    \nobreakspace
  } {}

  % Now print the references.
  \seq_clear:N \l__user_name_refs_tmpb_seq
  \seq_map_inline:Nn \l__user_name_refs_tmpa_seq {
    \seq_put_right:Nn \l__user_name_refs_tmpb_seq
      { \user_name_ref:nn {#3} {##1} }
  }
  \seq_use:Nnnn \l__user_name_refs_tmpb_seq
    { \crefpairconjunction }
    { \crefmiddleconjunction }
    { \creflastconjunction }
}

\cs_generate_variant:Nn \user_name_refs:nnnn { nx }
\cs_generate_variant:Nn \user_name_refs:nnnn { nnxn }

\cs_new_protected:Npn \__user_name_refs:NNnn #1#2#3#4
  {
    \user_name_refs:nnxn {#1}
      {#2}
      { \IfBooleanTF {#3} { \c_true_bool } { \c_false_bool } }
      {#4}
  }

% “Start in lower case” variant.
% Does put the label name, i.e., Figure My Figure.
% With star: disable hyperlinks.
% #2: comma list of refs
\NewDocumentCommand \namerefs { s m }
  {
    \__user_name_refs:NNnn \c_true_bool \c_false_bool {#1} {#2}
  }

% “Start in upper case” variant.
% Does put the label name, i.e., Figure My Figure.
% With star: disable hyperlinks.
% #2: comma list of refs
\NewDocumentCommand \Namerefs { s m }
  {
    \__user_name_refs:NNnn \c_true_bool \c_true_bool {#1} {#2}
  }

% “Start in lower case” variant.
% Does not put the label name, i.e., My Figure.
% With star: disable hyperlinks.
% #2: comma list of refs
\NewDocumentCommand \nameRefs { s m }
  {
    \__user_name_refs:NNnn \c_false_bool \c_false_bool {#1} {#2}
  }

\ExplSyntaxOff

% q/how-to-make-ref-references-include-the-word-figure
% q/nameref-how-to-display-section-name-and-its-number
% q/several-nameref-and-page-margins
% q/how-can-i-make-hyperref-stop-thinking-there-are-undefined-references
% q/cleveref-capitalise-option-not-working-with-babel-translations
\usepackage[nameinlink,capitalise,noabbrev]{cleveref}
\newcommand*{\typeref}[1]{\Cref{#1}}
\newcommand*{\fullref}[1]{\Cref{#1}: \nameRefs{#1}}

% q/creating-new-captions-and-caption-counters
\def\listofquadrosname{List of Frames}
\def\quadrosname{Frame}

\DeclareFloatingEnvironment[%
  fileext=loq,
  placement={!hbtp},
  name=\quadrosname,
  within=chapter,
  listname=\listofquadrosname
]{quadro}

\@ifpackageloaded{babel}{%
  \@ifpackagewith{babel}{brazil}{%
    \addto\captionsbrazil{%
      \renewcommand{\quadrosname}{Quadro}
    }
  }{}
}{}
\@ifpackageloaded{babel}{%
  \@ifpackagewith{babel}{brazil}{%
    \addto\captionsbrazil{%
      \renewcommand{\listofquadrosname}{Lista de Quadros}
    }
  }{}
}{}

% Create cleveref names for quadro environment captions
% https://github.com/abntex/abntex2/issues/176
% q/how-to-add-babel-translations-to-cleveref-based-cross-references-to-my-custom-fl
% q/here-is-another-example-where-cleveref-does-not-capitalize-when-it-should
\crefname{quadro}{frame}{frames}
\Crefname{quadro}{Frame}{Frames}
\@ifpackageloaded{babel}{%
  \@ifpackagewith{babel}{brazil}{%
    \addto\captionsbrazil{%
      \crefname{quadro}{quadro}{quadros}
    }
  }{}
}{}
\@ifpackageloaded{babel}{%
  \@ifpackagewith{babel}{brazil}{%
    \addto\captionsbrazil{
      \Crefname{quadro}{Quadro}{Quadros}
    }
  }{}
}{}

% fix fig. being used instead of figure
% q/cleveref-capitalise-option-not-working-with-babel-translations
\@ifpackageloaded{babel}{%
  \@ifpackagewith{babel}{brazil}{%
    \addto\captionsbrazil{%
      \crefname{figure}{Figura}{Figuras}
    }
  }{}
}{}
\@ifpackageloaded{babel}{%
  \@ifpackagewith{babel}{brazil}{%
    \addto\captionsbrazil{
      \Crefname{figure}{Figura}{Figuras}
    }
  }{}
}{}

\@ifpackageloaded{babel}{%
  \@ifpackagewith{babel}{english}{%
    \addto\captionsenglish{%
      \crefname{figure}{figure}{figures}
    }
  }{}
}{}
\@ifpackageloaded{babel}{%
  \@ifpackagewith{babel}{english}{%
    \addto\captionsenglish{%
      \Crefname{figure}{Figure}{Figures}
    }
  }{}
}{}

% Caption package and Memoir
% https://groups.google.com/forum/#!topic/comp.text.tex/RzpI2ATMev0
% q/memoir-class-with-subcaption-and-hyperref-packages
%
% \captionsetup[table]{
%   %  name=Tabela,
%   %  listformat=empty,
%   %  justification=justified,
%   %  labelsep=colon,
%   %   position=above,
%   %   skip=\onelineskip,
%   %  width=\linewidth,
%   labelfont={normalsize},
%   textfont={small},
%   font={normalsize}
% }

% Caption package and Memoir
% https://groups.google.com/forum/#!topic/comp.text.tex/RzpI2ATMev0
% q/memoir-class-with-subcaption-and-hyperref-packages
%
% \captionsetup[figure]{
%   %  name=Tabela,
%   %  listformat=empty,
%   %  justification=justified,
%   %  labelsep=colon,
%   %   position=above,
%   %   skip=\onelineskip,
%   %  width=\linewidth,
%   labelfont={normalsize},
%   textfont={small},
%   font={normalsize}
% }

% q/styling-and-spacing-around-float-caption-for-listing
% q/merge-items-in-list-of-floats
% q/how-can-i-reduce-padding-after-figure
% q/package-caption-warning-the-caption-type-was-already-set-to-quadro-on-input
\AtBeginEnvironment{quadro}{
  \captionsetup{skip=5pt,belowskip=0pt}
}

% q/control-spacing-around-table-caption
\captionsetup[figure]{belowskip=5pt,aboveskip=5pt}

\@ifclassloaded{memoir}{%
  % q/remove-list-of-newfloat-from-toc
  \newcommand{\AdjustForMemoir}[1]{%
  \csletcs{kept@listof#1}{listof#1}%
  \csdef{listof#1}{%
    \@ifstar
      {
        \csappto{newfloat@listof#1@hook}{\append@star}%
        \csuse{kept@listof#1}%
      }%
      {\csuse{kept@listof#1}}%
  }
  }
  \def\append@star#1{#1*}
  \AdjustForMemoir{quadro}
  \newlistentry{quadro}{loq}{0}

  % q/how-to-have-a-dynamic-cft-numwidth-i-e-accordingly-to-the-number-size
  \newlength\cftquadrooldnumwidth
  \setlength\cftquadrooldnumwidth{\cftquadronumwidth}

  % Calculate the size of the header
  % q/what-is-the-use-of-percent-signs-at-the-end-of-lines
  \newcommand{\calculatelquadrosheader}{%
    \renewcommand\cftquadropresnum{\quadrosname~}%

    % q/what-is-the-plain-tex-equivalent-of-settowidth
    \newlength\cftquadroinitialnumwidth
    \settowidth\cftquadroinitialnumwidth{%
      \cftquadropresnum\cftquadroaftersnum ab%
    }%
    \setlength\cftquadronumwidth{%
      \dimexpr\cftquadrooldnumwidth+\cftquadroinitialnumwidth%
    }%
    \renewcommand\cftquadroaftersnum{\hfill\textendash\hfill}%
  }

  % q/how-to-automatically-add-text-immediately-after-begindocument
  \AtBeginDocument{\calculatelquadrosheader}

  % q/how-to-have-a-dynamic-cft-numwidth-i-e-accordingly-to-the-number-size
  \newlength\cftfigureoldnumwidth
  \setlength\cftfigureoldnumwidth{\cftfigurenumwidth}

  % Calculate the size of the header
  % q/what-is-the-use-of-percent-signs-at-the-end-of-lines
  % q/list-of-figures-how-to-add-caption-label
  \newcommand{\calculatelfigureheader}{%
    % q/what-is-the-plain-tex-equivalent-of-settowidth
    \newlength\cftfigureinitialnumwidth
    \settowidth\cftfigureinitialnumwidth{%
      \cftfigurepresnum\cftfigureaftersnum a%
    }%
    \setlength\cftfigurenumwidth{%
      \dimexpr\cftfigureoldnumwidth+\cftfigureinitialnumwidth%
    }%
    \renewcommand\cftfigureaftersnum{%
      \hfill\textendash\hfill%
    }%
  }

  % q/how-to-automatically-add-text-immediately-after-begindocument
  \AtBeginDocument{\calculatelfigureheader}

  % q/how-to-have-a-dynamic-cft-numwidth-i-e-accordingly-to-the-number-size
  \newlength\cfttableoldnumwidth
  \setlength\cfttableoldnumwidth{\cfttablenumwidth}

  % Calculate the size of the header
  % q/what-is-the-use-of-percent-signs-at-the-end-of-lines
  \newcommand{\calculateltableheader}{%
    % q/what-is-the-plain-tex-equivalent-of-settowidth
    \newlength\cfttableinitialnumwidth
    \settowidth\cfttableinitialnumwidth{\cfttablepresnum\cfttableaftersnum a}%
    \setlength\cfttablenumwidth{%
      \dimexpr\cfttableoldnumwidth+\cfttableinitialnumwidth%
    }%
    \renewcommand\cfttableaftersnum{\hfill\textendash\hfill}%
  }

  % q/how-to-automatically-add-text-immediately-after-begindocument
  \AtBeginDocument{\calculateltableheader}

  % q/setting-entries-of-list-of-listings-in-latex-package-listings
  % q/you-cant-use-a-prefix-with-charfb-error-when-importing-csv-into-latex
  % q/why-latex-does-not-tell-me-which-command-is-undefined
  \@ifpackageloaded{babel}{%
    \@ifpackagewith{babel}{brazil}{%
      \addto\captionsbrazil{%
        \renewcommand{\lstlistingname}{Código}
      }
    }{}
  }{}
  \@ifpackageloaded{babel}{%
    \@ifpackagewith{babel}{brazil}{%
      \addto\captionsbrazil{%
        \renewcommand{\lstlistlistingname}{Lista de Códigos}
      }
    }{}
  }{}

  \@ifpackageloaded{babel}{%
    \@ifpackagewith{babel}{english}{%
      \addto\captionsenglish{%
        \renewcommand{\lstlistingname}{Code}
      }
    }{}
  }{}
  \@ifpackageloaded{babel}{%
    \@ifpackagewith{babel}{english}{%
      \addto\captionsenglish{%
        \renewcommand{\lstlistlistingname}{List of Codes}
      }
    }{}
  }{}

  \@ifpackageloaded{babel}{%
    \@ifpackagewith{babel}{brazil}{%
      \addto\captionsbrazil{%
        \crefname{listing}{código}{códigos}
      }
    }{}
  }{}
  \@ifpackageloaded{babel}{%
    \@ifpackagewith{babel}{brazil}{%
      \addto\captionsbrazil{%
        \Crefname{listing}{Código}{Códigos}
      }
    }{}
  }{}

  \begingroup
    \let\newcounter\@gobble\let\setcounter\@gobbletwo
    \globaldefs\@ne \let\c@loldepth\@ne
    \newlistof{listings}{lol}{\lstlistlistingname}
    \newlistof{lstlistoflistings}{lol}{\lstlistlistingname}
    \newlistentry{lstlisting}{lol}{0}
  \endgroup

  % q/why-the-empty-space-size-is-increasing-each-call
  \newlength\cftlstlistingoldnumwidth
  \setlength\cftlstlistingoldnumwidth{\cftlstlistingnumwidth}

  % Calculate the size of the header
  % q/what-is-the-use-of-percent-signs-at-the-end-of-lines
  \newcommand{\calculatelstlistingsheader}{%
    \renewcommand\cftlstlistingpresnum{\lstlistingname~}%

    % q/what-is-the-plain-tex-equivalent-of-settowidth
    \newlength\cftlstlistinginitialnumwidth
    \settowidth\cftlstlistinginitialnumwidth{%
      \cftlstlistingpresnum\cftlstlistingaftersnum ab%
    }%
    \setlength\cftlstlistingnumwidth{%
      \dimexpr\cftlstlistingoldnumwidth+\cftlstlistinginitialnumwidth+2pt%
    }%
    \renewcommand\cftlstlistingaftersnum{\hfill\textendash\hfill}%
  }

  % q/how-to-automatically-add-text-immediately-after-begindocument
  \AtBeginDocument{\calculatelstlistingsheader}
}{}

% q/list-of-figures-and-tables-when-there-are-no-figures-or-tables
% q/why-pdfbookmark-keeps-adding-to-the-pdf-bookmarks-while-addcontentslinetoc-d
% q/how-to-stop-newsavebox-giving-me-bad-boxes-warnings-or-how-to-use-better-names
% q/how-memoir-prints-the-titles-of-the-content-pages
\newcommand{\whenlistisnotempty}[3]{
  \setbox0\vbox{#2}%
  \typeout{The height of the list '#1' is '\the\ht0'}%
  \ifdim\ht0>35pt%
    #3%
    \unvbox0%
  \fi%
}

% Memoir class conflict with datetime
% q/memoir-class-conflict-with-datetime
% q/difference-between-let-foo-relax-and-def-foo-for-disabling
\let\ordinal\relax
\usepackage{datetime}

% % 'export' allows adjustbox keys in \includegraphics
% q/includegraphics-maximum-width
\usepackage[export]{adjustbox}

% ufscthesis start, https://github.com/UFSC/ufscthesisx/issues/19
\RequirePackage{helvet}

% q/continuous-numbering-of-figures-and-tables
% q/continuous-v-per-chapter-section-numbering-of-figures-tables-and-other-docume
\usepackage{chngcntr}
\counterwithout{figure}{chapter}
\counterwithout{table}{chapter}
\counterwithout{quadro}{chapter}
\counterwithout{equation}{chapter}

% q/chngcntr-counterwithout-not-working
% q/number-listings-the-same-way-as-figures-and-tables
\AtBeginDocument{\counterwithout{lstlisting}{chapter}}

% Permite tamanhos arbitrários para fontes Computer Modern (math warning)
\RequirePackage{fix-cm}

% Package xkeyval Error: <key> undefined in families `blx@lbx'.
% https://github.com/plk/biblatex/issues/628
\NewBibliographyString{sineloco}
\NewBibliographyString{sinenomine}
\NewBibliographyString{andothers}
\NewBibliographyString{in}

\DefineBibliographyStrings{brazil}{%
  sineloco     = {\mkbibemph{S\adddot l\adddot}},
  sinenomine   = {\mkbibemph{s\adddot n\adddot}},
  andothers    = {\mkbibemph{et\addabbrvspace al\adddot}},
  in           = {\mkbibemph{In:}}
}

% Posiciona figuras e tabelas no topo da página quando adicionadas sozinhas
% em um página em branco. Ver https://github.com/abntex/abntex2/issues/170
\setlength{\@fptop}{5pt} % Set distance from top of page to first float

% q/glossaries-conflict-with-memoir
\let\printglossary\relax
\let\theglossary\relax
\let\endtheglossary\relax

\RequirePackage[%
  subentrycounter,
  seeautonumberlist,
  nonumberlist,
  nogroupskip,
  nomain,
  shortcuts,
  acronym,
  translate=babel, % Faz o papel de \providetranslation
  nopostdot,
]{glossaries}

% Só dá entrada na lista. Ainda não funciona com o limarka
% Retira o espaço do pacote glossaries
\renewcommand{\glossarypreamble}{\vspace{-0.2cm}}

\providecommand{\imprimirnivel}{}
\newcommand{\nivel}[1]{\renewcommand{\imprimirnivel}{#1}}

% Criação de estilo
\newglossarystyle{UFSClong1}{% modificado de a/166209/151962
  \setglossarystyle{long}%
  \renewenvironment{theglossary}{%
    \begin{longtable}[l]{@{}p{\dimexpr 3.0cm-\tabcolsep}p{0.78\hsize}}
  }% <-- change the value here
  {\end{longtable}}%
}

% Só um pequeno récuo em relação ao primeiro
\newglossarystyle{UFSClong2}{% modificado de a/166209/151962
  \setglossarystyle{long}%
  \renewenvironment{theglossary}{%
    \begin{longtable}[l]{@{}p{\dimexpr 2.0cm-\tabcolsep}p{0.86\hsize}}
  }% <-- change the value here
  {\end{longtable}}%
}

% Só dá entrada na lista. Ainda não funciona com o limarka
\newcommand{\UFSCaddSigla}[2]{\newacronym{#1}{#1}{#2}}

% q/printnoidxglossaries-vs-printglossaries
\newglossary{UFSCsimbolos}{UFSCsimbolos}{sbl}{UFSCsimbolos}

% Só dá entrada na lista. Ainda não funciona com o limarka
% q/printnoidxglossaries-vs-printglossaries
\newcommand{\UFSCaddSymbol}[3]{%
  \newglossaryentry{#1}{%
    type=UFSCsimbolos,
    name=#2,
    description=#3
  }%
}

% imprime glossário
% q/printnoidxglossaries-vs-printglossaries
\newcommand{\imprimirglossario}{
  \cleardoublepage
  \pdfbookmark[0]{\glossaryname}{glo}
  \printnoidxglossary[%
    type=main,
    sort=use,
    title={\glossaryname}
  ]
}
% ufscthesis end, https://github.com/UFSC/ufscthesisx/issues/19

% Package csquotes Warning: Load 'inputenc' before 'csquotes'
% Package biblatex Warning: 'babel/polyglossia' detected but 'csquotes' missing
% q/package-biblatex-warning-babel-polyglossia-detected-but-csquotes-missing
\usepackage{csquotes}

% Indent the first section paragraphs
% q/no-indent-in-the-first-paragraph-in-a-section
\usepackage{indentfirst}

% Why the environment ttfamily is hyphenated,
% but macro ttfamily is not hyphenating?
% q/why-the-environment-ttfamily-is-hyphenated-but-macro-ttfamily-is-not-hyphenatin
\usepackage{letltxmacro}

% Theorem packages: which to use, which conflict?
% q/theorem-packages-which-to-use-which-conflict
\usepackage{amsthm}

% Why is the ifthen package obsolete? (It is used by the abntex2 class)
% q/why-is-the-ifthen-package-obsolete
\usepackage{ifthen}

% How to make section name uppercase in ToC?
% q/how-to-make-section-name-uppercase-in-toc
\usepackage{textcase}

% The class memoir already provides these functionalities:
% Caption package and Memoir
% https://groups.google.com/forum/#!topic/comp.text.tex/RzpI2ATMev0
% q/memoir-class-with-subcaption-and-hyperref-packages
% \usepackage{subfig}
% \usepackage{etoolbox}
%
% How to create my own caption type with \DeclareCaptionType on memoir class?
% q/how-to-create-my-own-caption-type-with-declarecaptiontype-on-memoir-class
\usepackage{caption}

% The package `layouts` causes the
% Warning: layout scale set to 0.5 on input line
% q/warning-layout-scale-set-to-0-5-on-input-line
% \usepackage{layouts}

% Always use it as should improve full justification
% q/texttt-overfull-hbox-problem
% q/should-i-load-microtype-with-pdflatex
\usepackage[factor=1100,stretch=10,shrink=10]{microtype}

% q/how-to-add-babel-captions-to-newfloat-package-environments
\usepackage{newfloat}

% How to auto adjust my last table column width,
% and why is there Underfull \vbox badness on this table?
% q/how-to-auto-adjust-my-last-table-column-width-and-why-is-there-underfull-vbox/387251
%
% Why ltablex package breaks the changepage package?
% q/why-ltablex-package-breaks-the-changepage-package
\usepackage{ltablex}\keepXColumns

% Para incluir links com characteres especiais como # em URLs em `\footnote`
% q/getting-those-signs-in-the-footnote
% q/animate-gives-errors-when-i-also-use-bigfoot-or-cprotect
%
% Adding this will cause the warning``bigfoot.sty:61: Package hyperref Warning:
% Option `hyperfootnotes' has 1`hyperfootnotes' has already been used
% q/bigfoot-sty61-package-hyperref-warning-option-hyperfootnotes-has-already-be
\let\truehypersetup\hypersetup
\renewcommand\hypersetup[1]{}
\usepackage{bigfoot}
\let\hypersetup\truehypersetup

% While loading fancyvrb, siunitx and bigfoot,
% I got input stack size=5000, TeX STOPPED: fatal errors occurred
% q/while-loading-fancyvrb-siunitx-and-bigfoot-i-got-input-stack-size-5000-tex-st
\xpatchcmd{\FN@allmarks}{266}{256}{}{}

% README.md
% Copyright 2017 Evandro Coan
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is M. Y. Name.
%
% This work consists of the files:
% 1. `README.md`,
% 2. `basic.tex`,
% 3. `commands.tex`,
% 4. `commands_list.tex`
% 5. `programming.tex`
% 6. `badboxes.tex`

%
% Settings
%

% Basic settings for hyperref package
\hypersetup{%
  colorlinks,
  linkcolor=darkblue,
  citecolor=darkgreen
}

% q/how-to-fix-useshorthands-defineshorthand-usage-on-bookmark-entries
\def\HyPsd@LetUnexpandableSpace#1{%
  \if\noexpand~\noexpand#1%
  \else
  \expandafter\@firstofone
  \fi{\expandafter\futurelet\expandafter#1\expandafter\@gobble\space\relax}}

% How could the `\everypar` justification statement be used?
% q/how-could-the-everypar-justification-statement-be-used
\newbox\linebox \newbox\snapbox
\def\eatlines{%
  \setbox\linebox\lastbox % check the last line
  \ifvoid\linebox
  \else % if it’s not empty
    \unskip\unpenalty % take whatever is
    {\eatlines} % above it;
    \setbox\snapbox\hbox{\unhcopy\linebox}
    \ifdim\wd\snapbox<.98\wd\linebox
      \box\snapbox % take the one or the other,
    \else \box\linebox \fi
  \fi
}

% How could the `\everypar` justification statement be used?
% q/how-could-the-everypar-justification-statement-be-used
\everypar={%
  \setbox0=\lastbox \par%
  \vbox\bgroup \everypar={}\def\par{\endgraf\eatlines\egroup}%
}

% Creates a new environment which can be used as:
%
% \begin{foo}
%   Text...
%
%   Text ...
% \end{foo}
%
% q/push-long-words-in-a-new-line
\newenvironment{foo}{%
  \par%
  \hyphenpenalty=10000%
  \exhyphenpenalty=10000%
}{%
  \par%
}

% Some text \brkurl{http://www.example.com/this/directory/here}
%
% How to break long URLs using common hyphenation
% but adding a line feed indicator?
% q/how-to-break-long-urls-using-common-hyphenation-but
\def\addurlspace#1{%
  \ifx\relax#1%
  \else%
  \ifx/#1\space\fi%
  \ifx.#1\space\fi%
  #1%
  \ifx/#1\space\fi%
  \ifx.#1\space\fi%
  \expandafter\addurlspace%
  \fi%
}

\@namedef{OT1-zwidthchar}{255}
\@namedef{T1-zwidthchar}{"17}

\def\brkurl#1{%
  \edef\savedhchar{\the\hyphenchar\font}%
  \global\setbox1\hbox{}%
  \setbox0=\vbox
  {%
    \hsize=2pt\rightskip=0pt plus 1fill%
    \hfuzz\maxdimen%
    \tracinglostchars0%
    \overfullrule0pt%
    \hyphenchar\font=\csname \f@encoding-zwidthchar\endcsname%
    \noindent \hskip0pt \addurlspace #1\relax%
    \par%
    \loop%
    \setbox4 \lastbox%
    \ifvoid4 \else%
    \global\setbox1\hbox%
    {%
      \unhbox4\unskip\unskip\discretionary{%
        \hbox{\rlap{$\leftarrow$}}%
      }{}{}\unhbox1%
    }%
    \unskip%
    \unskip%
    \unpenalty%
    \unskip%
    \repeat%
  }%
  \unhbox1%
  \hyphenchar\font\savedhchar%
  \relax%
}

% Change background color for text block
% q/change-background-color-for-text-block
\usepackage{framed}
\usepackage[most]{tcolorbox}
\definecolor{shadecolor}{RGB}{219, 229, 241}
\newtcolorbox{bluebox}{%
  colback=shadecolor,
  grow to right by=8mm,
  grow to left by=8mm,
  boxrule=0pt,
  boxsep=0pt,
  unbreakable,
}

% Make first row of table all bold
%
% Usage:
% 1. Add `B` on the borders and `^` before each column definition.
% 2. `\rowstyle{\bfseries}` before the row you want to bold.
%
% Example:
% \begin{tabularx}{\linewidth}
% {|
%     *1{                 >{\RaggedRight\arraybackslash\hsize=1.1\hsize }BX       |} % Riscos
%     *3{@{\hspace{3.0pt}}>{\Centering\arraybackslash                   }^p{0.9cm}|} % Probabilidade, Impacto, Prioridade
%     *2{                 >{\RaggedRight\arraybackslash\hsize=0.95\hsize}^X       |} % Resposta, Prevenção
% }
%
% \hline
%
% \rowstyle{\bfseries}
% Riscos  & 1 & 2 & 3 & Estratégia de resposta & Ações de prevenção \\ \hline
%
%
% q/make-first-row-of-table-all-bold
\usepackage{array}
\newcolumntype{B}{>{\global\let\currentrowstyle\relax}}
\newcolumntype{^}{>{\currentrowstyle}}
\newcommand{\rowstyle}[1]{%
  \gdef\currentrowstyle{#1}#1\ignorespaces
}

% q/why-abntex2-class-is-inserting-a-new-line-after-the-chapter-title
% q/how-to-automatically-put-a-go-to-summary-go-back-on-each-section
% q/how-can-the-go-to-summary-be-fixed-so-the-sectionsomesome-more
% q/what-is-the-equivalent-to-sectionformat-on-memoir-class-for-chapterformat
% q/why-xapptocmd-is-reducing-the-vertical-space-between-partname-and-parttile
\definecolor{ultramarine}{RGB}{0,32,96}
\RequirePackage{xpatch}

% q/patching-arguments-inside-a-macro
\tracingpatches

\RequirePackage{amssymb}
\RequirePackage{hyperref}
\newcommand{\goToSummaryText}{{%
  \small\mdseries
  \hyperlink{summary}{\textcolor{ultramarine}{$\leftleftarrows$}}
  {$|$}
  \Acrobatmenu{GoBack}{\textcolor{ultramarine}{$\leftarrow$}}
}}

\newif\ifismemoirloaded\ismemoirloadedfalse
\newif\ifisabntexloaded\isabntexloadedfalse
\@ifclassloaded{memoir}{%
  \ismemoirloadedtrue%
}{}
\@ifclassloaded{setup/abntex2}{%
  \isabntexloadedtrue%
}{}

\newcommand{\addGoToSummary}{%
  \@ifundefined{printparttitle}{%
    \message{%
      printparttitle patch for addGoToSummary could NOT
      be applied because there is no printparttitle command available!^^J
    }%
  }{%
    \let\oldAddGoToprintparttitle\printparttitle
    \xapptocmd{\printparttitle}{~\protect\goToSummaryText}{}{}
  }
  \@ifundefined{Sectionformat}{%
    \message{%
      Sectionformat patch for addGoToSummary could NOT
      be applied because there is no Sectionformat command available!^^J
    }%
  }{%
    \let\oldAddGoToSectionformat\Sectionformat
    \xapptocmd{\Sectionformat}{~\protect\goToSummaryText}{}{}
  }

  \ifismemoirloaded
    \ifisabntexloaded
      \let\oldAddGoToABNTEXchapterupperifneeded\ABNTEXchapterupperifneeded
      \xapptocmd{\ABNTEXchapterupperifneeded}{~\protect\goToSummaryText}{}{}
    \else
      \let\oldAddGoToprintchaptertitle\printchaptertitle
      \xapptocmd{\printchaptertitle}{~\protect\goToSummaryText}{}{}
    \fi
  \else
    \@ifundefined{Chapterformat}{%
      \message{%
        Chapterformat patch for addGoToSummary could NOT
        be applied because there is no Chapterformat command available!^^J
      }%
    }{%
      \let\oldAddGoToChapterformat\Chapterformat
      \xapptocmd{\Chapterformat}{~\protect\goToSummaryText}{}{}
    }
  \fi
}

\newcommand{\UFSCremoveGoToSummary}{%
  \@ifundefined{oldAddGoToprintparttitle}{}{%
    \let\printparttitle\oldAddGoToprintparttitle
  }
  \@ifundefined{oldAddGoToSectionformat}{}{%
    \let\Sectionformat\oldAddGoToSectionformat
  }

  \ifismemoirloaded
    \ifisabntexloaded
      \@ifundefined{oldAddGoToABNTEXchapterupperifneeded}{}{%
        \let\ABNTEXchapterupperifneeded\oldAddGoToABNTEXchapterupperifneeded
      }
    \else
      \@ifundefined{oldAddGoToprintchaptertitle}{}{%
        \let\printchaptertitle\oldAddGoToprintchaptertitle
      }
    \fi
  \else
    \@ifundefined{oldAddGoToChapterformat}{}{%
      \let\Chapterformat\oldAddGoToChapterformat
    }
  \fi
}

\let\oldAddGoTotableofcontents\tableofcontents
% Insert internal document link
\renewcommand{\tableofcontents}{%
  \hypertarget{summary}%
  \oldAddGoTotableofcontents%
}

%
% New commands
%

% Allow to push long words on new lines
% when they do not fit entirely on the current line.
% q/push-long-words-in-a-new-line
\newcommand\lword[1]{%
  \leavevmode\nobreak\hskip0pt %
  plus\linewidth\penalty50\hskip0pt plus-\linewidth\nobreak{#1}%
}
\newcommand\lurl[1]{%
  \leavevmode\nobreak\hskip0pt %
  plus\linewidth\penalty50\hskip0pt plus-\linewidth\nobreak{\url{#1}}%
}

% q/space-after-latex-commands
\usepackage{xspace}

% q/how-to-create-my-own-list-of-things
\newcommand{\UFSCtextPreliminaryListName}{Short Table of Contents}
\newlistof{textpreliminarycontents}{tpc}{\UFSCtextPreliminaryListName}

% Resetting counter
% q/resetting-counter
%
% q/custom-list-throw-latex-error-command-mycustomfiction-already-defined
\newlistentry{textpreliminarycounter}{tpc}{0}

% Continuing Page Numbering (Roman to Arabic)
% q/continuing-page-numbering-roman-to-arabic
\renewcommand{\thetextpreliminarycounter}{\arabic{textpreliminarycounter}}

% Reset section numbering between unnumbered chapters
% q/reset-section-numbering-between-unnumbered-chapters
\newcommand{\UFSCaddToTextPreliminaryContent}[1]{%
  \refstepcounter{textpreliminarycounter}%
  \addcontentsline{tpc}%
                  {textpreliminarycounter}%
                  {\protect\numberline{\thetextpreliminarycounter}#1}\par%
}

% Unable to link to inserted pages with pdfpages
% q/unable-to-link-to-inserted-pages-with-pdfpages
\newcounter{includepdfpage}
\newcounter{currentpagecounter}

\newcommand{\addlabelstoallincludedpages}[1]{%
  \refstepcounter{includepdfpage}%
  \stepcounter{currentpagecounter}%
  \label{#1.\thecurrentpagecounter}%
}
\newcommand{\modifiedincludepdf}[4]{%
  \setcounter{currentpagecounter}{0}%
  \includepdf[pages=#1,pagecommand=\addlabelstoallincludedpages{#2},scale=#4]
             {#3}%
}

% \MakeUppercase in \section and \chapter with hyperref cause trouble
% q/makeuppercase-in-section-and-chapter-with-hyperref-cause-trouble
\newcommand{\HyperrefUppercase}[1]{%
  \texorpdfstring{\MakeTextUppercase{#1}}{#1}
}

% Example about hyphenation with ttfamily font
% q/example-about-hyphenation-with-ttfamily-font
%
% Why the environment ttfamily is hyphenated,
% but macro ttfamily is not hyphenating?
% q/why-the-environment-ttfamily-is-hyphenated-but-macro-ttfamily-is-not-hyphenatin
\LetLtxMacro\origttfamily\ttfamily
\DeclareRobustCommand*{\ttfamily}{%
  \origttfamily
  \hyphenchar\font=`\-\relax
  \fontdimen3\font=.25em\relax
  \fontdimen4\font=.13em\relax
  \fontdimen7\font=.167em\relax
}

\DeclareRobustCommand\vttfamily{%
  \not@math@alphabet\vttfamily\relax
  \fontfamily{cmvtt}% cmvtt (Computer Modern) or lmvtt (Latin Modern)
  \selectfont
}
\DeclareTextFontCommand{\textvtt}{\vttfamily}

% Logical String Length
% q/logical-string-length
\newcommand{\includeonlyfilelist}[0]{}
\newcommand{\addtoincludeonly}[1]{%
  \StrLen{\includeonlyfilelist}[\includeonlyfilelistlen]

  % How to concatenate strings into a single command?
  % q/how-to-concatenate-strings-into-a
  \ifnum\includeonlyfilelistlen>0
    \g@addto@macro\includeonlyfilelist{,#1}
  \else
    \g@addto@macro\includeonlyfilelist{#1}
  \fi
}

% README.md
% Copyright 2017 Evandro Coan
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is M. Y. Name.
%
% This work consists of the files:
% 1. `README.md`,
% 2. `basic.tex`,
% 3. `commands.tex`,
% 4. `commands_list.tex`
% 5. `programming.tex`
% 6. `badboxes.tex`

% Bad Boxes settings

% Underfull \hbox in bibliography
% q/underfull-hbox-in-bibliography
\apptocmd{\thebibliography}{\raggedright}{}{}

% Underfull \hbox (badness 10000) has occurred while \output is active
% q/underfull-hbox-badness-10000-has-occurred-while-output-is-active
%
% how to suppress “Underfull \vbox (badness 10000) … while \output is active”?
% q/how-to-suppress-underfull-vbox-badness-10000-while-output-is-active
\def\@textbottom{\vskip \z@ \@plus 7pt}
\let\@texttop\relax

% Why Latex is hyphenating some words automatically,
% but others dont? hyphenmins{22} %left=2, right=2
% q/why-latex-is-hyphenating-some-words-automatically-but-others-dont
\@ifpackagewith{babel}{brazil}{  \def\brazilhyphenmins{11} }{}
\@ifpackagewith{babel}{english}{ \def\englishhyphenmins{11} }{}
\@ifpackagewith{babel}{french}{  \def\frenchhyphenmins{11} }{}

\@ifpackageloaded{url}{
  % Bad formatting using URLs in bibtex
  % q/bad-formatting-using-urls-in-bibtex
  \usepackage{etoolbox}

  % How to avoid overfull error with url package?
  % See also the `\usepackage{url}` declarationon the file `basic.tex`.
  % Set this to 2mu or 3mu if URL start troubling again.
  % q/how-to-avoid-overfull-error-with-url-package
  \Urlmuskip=0mu plus 1mu

  % How to fix URL overfull & underfull on emumeration?
  % q/how-to-fix-url-overfull-underfull-on-emumeration
  %
  % Forcing linebreaks in \url
  % q/forcing-linebreaks-in-url/10401
  \g@addto@macro{\UrlBreaks}{\UrlOrds}

  % How to fix this url bad box for stackoverflow link?
  % q/how-to-fix-this-url-bad-box-for-stackoverflow-link
  \g@addto@macro{\UrlBreaks}{%
    \do\a\do\b\do\c\do\d\do\e\do\f\do\g%
    \do\h\do\i\do\j\do\k\do\l\do\m\do\n%
    \do\o\do\p\do\q\do\r\do\s\do\t\do\u%
    \do\v\do\w\do\x\do\y\do\z%
    \do\A\do\B\do\C\do\D\do\E\do\F\do\G%
    \do\H\do\I\do\J\do\K\do\L\do\M\do\N%
    \do\O\do\P\do\Q\do\R\do\S\do\T\do\U%
    \do\V\do\W\do\X\do\Y\do\Z%
    \do\/\do\_\do\-%
  }
}{}

% README.md
% Copyright 2017 Evandro Coan
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is M. Y. Name.
%
% This work consists of the files:
% 1. `README.md`,
% 2. `basic.tex`,
% 3. `commands.tex`,
% 4. `commands_list.tex`
% 5. `programming.tex`
% 6. `badboxes.tex`

% Writing code in latex document. Usage: \begin & \end {lstlisting}
% http://stackoverflow.com/questions/3175105/writing-code-in-latex-document
\usepackage{listings}

% How to insert code with accents with listings?
% q/how-to-insert-code-with-accents-with-listings
\usepackage{listingsutf8}

% set the font family for lstlisting
% q/set-the-font-family-for-lstlisting
\usepackage{courier}

% Latex: Listings with monospace fonts
% q/latex-listings-with-monospace-fonts
% q/how-to-have-straight-single-quotes-in-lstlistings
% q/double-quote-charater-with-listings-create-problem
\lstset{
  frame=,
  language=Python,% default language
  upquote=true,
  aboveskip=3mm,
  belowskip=3mm,
  showstringspaces=false,
  basicstyle={%
    \small%
    \fontfamily{zi4}%
    \selectfont%
  },
  numbers=left,
  numberstyle=\color{gray},
  keywordstyle=\color{blue},
  commentstyle=\color{darkgreen},
  stringstyle=\color{mauve},
  breaklines=true,
  breakatwhitespace=true,
  tabsize=4,
  morestring=[b]',
  morestring=[b]",
  literate = {---}{{\ProcessThreeDashes}}3
       {>}{{\textcolor{red}\textgreater}}1
       {|}{{\textcolor{red}\textbar}}1
       {\ -\ }{{\mdseries\ -\ }}3,
  inputencoding=utf8, % q/listings-in-latex-with-utf-8-or-at-least-german-umlauts
  extendedchars=true, % q/having-problems-with-listings-and-utf-8-can-it-be-fixed
  literate=%
    {£}{{\pounds}}1
    {ß}{{\ss}}1
    {à}{{\`a}}1   {À}{{\`A}}1   {à}{{\`{a}}}1 {á}{{\'a}}1   {Á}{{\'A}}1
    {á}{{\'{a}}}1 {Á}{{\'{A}}}1 {â}{{\^a}}1   {Â}{{\^A}}1   {â}{{\^{a}}}1
    {Â}{{\^{A}}}1 {ã}{{\~a}}1   {Ã}{{\~A}}1   {ã}{{\~{a}}}1 {Ã}{{\~{A}}}1
    {ä}{{\"a}}1   {Ä}{{\"A}}1   {å}{{\r a}}1  {Å}{{\r A}}1
    {æ}{{\ae}}1   {Æ}{{\AE}}1
    {ç}{{\c c}}1  {Ç}{{\c C}}1  {ç}{{\c{c}}}1 {Ç}{{\c{C}}}1
    {È}{{\'E}}1   {è}{{\`e}}1   {è}{{\`{e}}}1 {é}{{\'e}}1   {É}{{\'E}}1
    {é}{{\'{e}}}1 {É}{{\'{E}}}1 {ê}{{\^e}}1   {Ê}{{\^E}}1   {ê}{{\^{e}}}1
    {Ê}{{\^{E}}}1 {ë}{{\"e}}1   {Ë}{{\"E}}1   {ë}{{\¨{e}}}1
    {ì}{{\`i}}1   {Ì}{{\`I}}1   {í}{{\'i}}1   {Í}{{\'I}}1   {í}{{\'{i}}}1
    {Í}{{\~{Í}}}1 {î}{{\^i}}1   {Î}{{\^I}}1   {î}{{\^{i}}}1 {Î}{{\^{I}}}1
    {ï}{{\"i}}1   {Ï}{{\"I}}1
    {ò}{{\`o}}1   {Ò}{{\`O}}1   {ó}{{\'o}}1   {Ó}{{\'O}}1   {ó}{{\'{o}}}1
    {Ó}{{\'{O}}}1 {ô}{{\^o}}1   {Ô}{{\^O}}1   {ô}{{\^{o}}}1 {Ô}{{\^{O}}}1
    {õ}{{\~o}}1   {Õ}{{\~O}}1   {õ}{{\~{o}}}1 {Õ}{{\~{O}}}1
    {ö}{{\"o}}1   {Ö}{{\"O}}1
    {ø}{{\o}}1
    {ù}{{\`u}}1   {Ù}{{\`U}}1   {ù}{{\`{u}}}1 {ú}{{\'u}}1 {Ú}{{\'U}}1
    {ú}{{\'{u}}}1 {û}{{\^u}}1   {Û}{{\^U}}1   {û}{{\^{u}}}1
    {ü}{{\"u}}1   {Ü}{{\"U}}1
    {ő}{{\H{o}}}1 {Ő}{{\H{O}}}1
    {œ}{{\oe}}1   {Œ}{{\OE}}1
    {ű}{{\H{u}}}1 {Ű}{{\H{U}}}1
    {€}{{\EUR}}1
}

% q/how-to-highlight-python-syntax-in-latex-listings-lstinputlistings-command
\definecolor{gray}{gray}{0.5}
\colorlet{commentcolour}{green!50!black}

\colorlet{stringcolour}{red!60!black}
\colorlet{keywordcolour}{magenta!90!black}
\colorlet{exceptioncolour}{yellow!50!red}
\colorlet{commandcolour}{blue!60!black}
\colorlet{numpycolour}{blue!60!green}
\colorlet{literatecolour}{magenta!90!black}
\colorlet{promptcolour}{green!50!black}
\colorlet{specmethodcolour}{violet}

\newcommand*{\literatecolour}{\textcolor{literatecolour}}

\newcommand*{\pythonprompt}{\textcolor{promptcolour}{{>}{>}{>}}}

% Ao contrario da norma abnt-6027-2012,
% que as figuras estejam listadas na Lista de Ilustrações,
% a UFSC pede que as figuras estejam na Lista de Figuras.
%
% Remove the colon appended to variables by 'abntex2'
% because they show up on places they shouldn't
%
% q/why-latex-does-not-tell-me-which-command-is-undefined
% q/how-to-add-babel-captions-to-newfloat-package-environments
% q/how-to-override-command-on-my-preamble-after-its-redefinition-by-my-class-with
\@ifpackageloaded{babel}{\@ifpackagewith{babel}{brazil}{%
  \addto\captionsbrazil{%
    \renewcommand{\ABNTEXorientadorname}{Orientador}
    \renewcommand{\ABNTEXcoorientadorname}{Coorientador}
    \renewcommand{\quadrosname}{Quadro}
    \renewcommand{\ABNTEXfolhadeaprovacaoname}{Folha de Aprovação}
    \renewcommand{\ABNTEXfolhaderostoname}{Folha de Rosto}
    \renewcommand{\listfigurename}{Lista de Ilustrações}
    \renewcommand{\listtablename}{Lista de Tabelas}
    \renewcommand{\listofquadrosname}{Lista de Quadros}
    \renewcommand{\listfigurename}{Lista de Figuras}
    \renewcommand{\ABNTEXlistadesiglasname}{Lista de Abreviaturas e Siglas}
    \renewcommand{\ABNTEXlistadesimbolosname}{Lista de Símbolos}
    \renewcommand{\tableautorefname}{Tabela}
    \renewcommand{\figureautorefname}{Figura}
    \renewcommand{\chapterautorefname}{Capítulo}
    \renewcommand{\pageautorefname}{Página}
    \renewcommand{\sectionautorefname}{Seção}
    \renewcommand{\subsectionautorefname}{Subseção}
    \renewcommand{\subsubsectionautorefname}{Subsubseção}
    \renewcommand{\paragraphautorefname}{Parágrafo}
  }
}{}}{}

\@ifpackageloaded{babel}{\@ifpackagewith{babel}{english}{%
  \addto\captionsenglish{%
    \renewcommand{\UFSCcovername}{Cover}
    \renewcommand{\ABNTEXorientadorname}{Supervisor}
    \renewcommand{\ABNTEXcoorientadorname}{Co\hyp{}supervisor}
    \renewcommand{\ABNTEXfolhadeaprovacaoname}{Approval}
    \renewcommand{\ABNTEXfolhaderostoname}{Title Page}
    \renewcommand{\ABNTEXerrataname}{Errata Sheet}
    \renewcommand{\listfigurename}{List of Illustrations}
    \renewcommand{\listtablename}{List of Tables}
    \renewcommand{\listfigurename}{List of Figures}
    \renewcommand{\ABNTEXlistadesiglasname}{List of Abbreviations and Acronyms}
    \renewcommand{\ABNTEXlistadesimbolosname}{List of Symbols}
    \renewcommand{\tableautorefname}{Table}
    \renewcommand{\figureautorefname}{Figure}
    \renewcommand{\chapterautorefname}{Chapter}
    \renewcommand{\pageautorefname}{Page}
    \renewcommand{\sectionautorefname}{Section}
    \renewcommand{\subsectionautorefname}{Subsection}
    \renewcommand{\subsubsectionautorefname}{Subsubsection}
    \renewcommand{\paragraphautorefname}{Paragraph}
  }
}{}}{}

% Muda equação para 'Equação (n)'
% q/autoref-does-not-expand-abbreviation-automatically-at-beginning-of-line
% q/combining-autoref-and-eqref
% q/rename-sections-with-ngerman
% q/custom-equations-names
% q/add-equation-name-besides-equation-number-so-that-eqref-inserts-only-the-numbe
% q/add-equation-name-underneath-equation-number
\@ifpackageloaded{babel}{%
  \@ifpackagewith{babel}{english}{%
    \addto\captionsenglish{%
      \def\equationautorefname~#1\null{%
        Equation~(#1)\null
      }
    }
  }{}
}{}

\@ifpackageloaded{babel}{%
  \@ifpackagewith{babel}{brazil}{%
    \addto\captionsbrazil{%
      \def\equationautorefname~#1\null{%
        Equação~(#1)\null
     }
    }
  }{}
}{}

\makeatother
