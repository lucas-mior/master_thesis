%% This class is called `setup/abntex2.cls` and not `abntex2.cls`.
%% It was developed specially for:
%%   1. https://github.com/evandrocoan/ufscthesisx
%%   2. https://github.com/evandrocoan/ufscthesisx-setup
%%
%% Always get the latest version from:
%%   1. https://github.com/evandroforks/abntex2/blob/master/tex/latex/abntex2/abntex2.cls
%%   2. wget https://raw.githubusercontent.com/evandroforks/abntex2/master/tex/latex/abntex2/abntex2.cls
%%
%% setup/abntex2.cls, v<VERSION> laurocesar
%% Copyright 2012-<COPYRIGHT_YEAR> by abnTeX2 group at https://www.abntex.net.br/
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%%
%% The Current Maintainer of this work is the abnTeX2 team, led
%% by Lauro César Araujo. Further information are available on
%% https://www.abntex.net.br/
%%
%% This work consists of the file abntex2.cls.

% ------------------------------------------------------------------------
% Declaracao da classe abntex2 como uma extensao da classe memoir
% ------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{setup/abntex2}[2016/11/15 v1.9.7 setup/abntex2]

\makeatletter
\RequirePackage{ifthen}
%
% Captura as options article e twocolumn
%
\providecommand{\ABNTEXisarticle}{false}
\DeclareOption{article}{
  \renewcommand{\ABNTEXisarticle}{true}
  \PassOptionsToClass{article}{memoir}%}
}
\providecommand{\ABNTEXistwocolumn}{false}
\DeclareOption{twocolumn}{
  \renewcommand{\ABNTEXistwocolumn}{true}
  \PassOptionsToClass{twocolumn}{memoir}%}
}
%
% Opcoes chapter=TITLE, section=TITLE, subsection=TITLE e
% subsubsection=TITLE: titulos em letras maiusculas
%
\newboolean{ABNTEXupperchapter}     %true=titles of chapter/appendix in uppercase
\newboolean{ABNTEXuppersection}     %true=titles of sections in uppercase
\newboolean{ABNTEXuppersubsection}  %true=titles of subsections in uppercase
\newboolean{ABNTEXuppersubsubsection}  %true=titles of subsubsections in uppercase
\newboolean{ABNTEXuppersubsubsubsection}  %true=titles of subsubsubsections in uppercase
\setboolean{ABNTEXupperchapter}{false}
\setboolean{ABNTEXuppersection}{false}
\setboolean{ABNTEXuppersubsection}{false}
\setboolean{ABNTEXuppersubsubsection}{false}
\setboolean{ABNTEXuppersubsubsubsection}{false}
\DeclareOption{chapter=TITLE}{\setboolean{ABNTEXupperchapter}{true}}
\DeclareOption{section=TITLE}{\setboolean{ABNTEXuppersection}{true}}
\DeclareOption{subsection=TITLE}{\setboolean{ABNTEXuppersubsection}{true}}
\DeclareOption{subsubsection=TITLE}{\setboolean{ABNTEXuppersubsubsection}{true}}
\DeclareOption{subsubsubsection=TITLE}{\setboolean{ABNTEXuppersubsubsubsection}{true}}
%
% Opções de diagramação de sumários
% sumario=tradicional    : Sumário tradicional do LaTeX/Memoir
% sumario=abnt-6027-2012 : Sumário conforme recomendação da ABNT NBR 6027:2012
\newboolean{ABNTEXsumario-tradicional}     %true=titles of chapter/appendix in uppercase
\newboolean{ABNTEXsumario-abnt-6027-2012}
\setboolean{ABNTEXsumario-tradicional}{false}
\setboolean{ABNTEXsumario-abnt-6027-2012}{true}
\DeclareOption{sumario=tradicional}{%
  \setboolean{ABNTEXsumario-tradicional}{true}%
  \setboolean{ABNTEXsumario-abnt-6027-2012}{false}}
\DeclareOption{sumario=abnt-6027-2012}{%
  \setboolean{ABNTEXsumario-abnt-6027-2012}{true}
  \setboolean{ABNTEXsumario-tradicional}{false}}
%
% Repassa demais opcoes a memoir
%
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{memoir}%
}
\ProcessOptions\relax
\LoadClass{memoir}

% sumario=abnt-6027-2012 : Sumário conforme recomendação da ABNT NBR 6027:2012, que
%    soh pode ser usado com memoir v3.6k ou superior
%    \settocpreprocessor \changes{v3.6k}{2012/09/18}{Added}
\ifdefined\settocpreprocessor
\else
  \setboolean{ABNTEXsumario-tradicional}{true}
  \setboolean{ABNTEXsumario-abnt-6027-2012}{false}
\fi

% ------------------------------------------------------------------------
% Comandos para tratamento de opcoes proprias
% ------------------------------------------------------------------------

% Comandos para controlar as opcoes de titulos com letras maiusculas

% pacote que prove \MakeTextUppercase
\RequirePackage{textcase}

\newcommand{\ABNTEXchapterupperifneeded}[1]{\ifthenelse{\boolean{ABNTEXupperchapter}}{\MakeTextUppercase{#1}}{#1}}
\newcommand{\ABNTEXsectionupperifneeded}{\ifthenelse{\boolean{ABNTEXuppersection}}{\MakeTextUppercase}{}}
\newcommand{\ABNTEXsubsectionupperifneeded}{\ifthenelse{\boolean{ABNTEXuppersubsection}}{\MakeTextUppercase}{}}
\newcommand{\ABNTEXsubsubsectionupperifneeded}{\ifthenelse{\boolean{ABNTEXuppersubsubsection}}{\MakeTextUppercase}{}}
\newcommand{\ABNTEXsubsubsubsectionupperifneeded}{\ifthenelse{\boolean{ABNTEXuppersubsubsubsection}}{\MakeTextUppercase}{}}

% ------------------------------------------------------------------------
% Pacotes adicionais e customizacoes gerais do memoir
% ------------------------------------------------------------------------

% Do pacote de if/them/else
\newcommand{\abntex@UFSCifNotEmpty}[2]{\ifthenelse{\not\equal{#1}{}}{#2}{}}

% Define o comando \ABNTEXfonte que respeita as configurações de caption do memoir ou do caption
\newcommand{\ABNTEXfonte}[2][\ABNTEXfontename]{%
  \M@gettitle{#2}%
  \memlegendinfo{#2}%
  \par
  \begingroup
     \@parboxrestore
     \if@minipage
       \@setminipage
     \fi
     % q/how-can-i-reduce-padding-after-figure
     % \setlength{\parskip}{10pt}
     % \setlength{\abovecaptionskip}{10pt}
     \setlength{\belowcaptionskip}{4pt}
     \ABNTEXfontereduzida
     % \captiondelim{\ABNTEXcaptionfontedelim}
     % q/misplaced-noalign-captionsetup-noalign-when-using-captionsetup-inside-mem
     \ifdefined\caption@setlabelseparator
       \caption@setlabelseparator{colon}%
     \else%
       \caption@set{labelseparator}{colon}%
     \fi%
     \@makecaption{\ABNTEXfontereduzida #1}{\ignorespaces\ABNTEXfontereduzida #2}\par
  \endgroup}

 %
% Define o comando \notas que respeita as configurações de caption do memoir ou do caption
\newcommand{\ABNTEXnota}[2][\ABNTEXnotaname]{\ABNTEXfonte[#1]{#2}}

% Customiza listas
\RequirePackage[shortlabels]{enumitem}

% q/how-to-recognize-the-enumerate-shortlabels-in-my-custom-environment
% q/how-to-define-commands-before-loading-the-hyperref-package-which-is-loaded-by
% q/how-can-i-stop-this-useless-empty-line-popping-up-in-the-middle-of-my-lists
\RequirePackage{etoolbox}

% q/illegal-parameter-number-in-definition-of-enitc-after-using-setlistenumerat
\let\@itemenumerateoptional\@item
\patchcmd\@itemenumerateoptional{\if@noitemarg}{\iftrue}{}{\FAILEDCREATEENUMERAOPTIONAL}
\newcommand\enumerateoptionallabelformat[1]{#1~\@itemlabel}

% q/enumitem-revert-nolistsep
% q/how-to-change-list-settings-globally
% q/why-does-setlistnosep-doesnt-work-in-a-tabular-environment
\newlist{enumerateoptional}{enumerate}{1}
\setlist[enumerateoptional]{%
    before=\let\@item\@itemenumerateoptional,
    format=\enumerateoptionallabelformat,
    label=\arabic*,
    align=left,
    leftmargin=*,
}

% Controla as referencias internas do PDF
\RequirePackage{hyperref}
\pdfstringdefDisableCommands{\def\\{, }\def\and{; }}

% Controla os bookmarks do PDF
\RequirePackage{bookmark}

% Hifenizacao e caracteres especiais portugues-brasil por padrao
\RequirePackage[brazil]{babel}
%
% Nomes constantes do abnTeX2 em portugues (definicoes padroes)
\newcommand{\ABNTEXfolhaderostoname}{Folha de rosto}
\newcommand{\ABNTEXepigraphname}{Ep\'igrafe}
\newcommand{\ABNTEXdedicatorianame}{Dedicat\'oria}
\newcommand{\ABNTEXerrataname}{Errata}
\newcommand{\ABNTEXagradecimentosname}{Agradecimentos}
\newcommand{\ABNTEXanexoname}{ANEXO}
\newcommand{\ABNTEXanexosname}{Anexos}
\newcommand{\ABNTEXapendicename}{AP\^ENDICE}
\newcommand{\ABNTEXapendicesname}{Ap\^endices}
\newcommand{\ABNTEXorientadorname}{Orientador:}
\newcommand{\ABNTEXcoorientadorname}{Coorientador:}
\newcommand{\ABNTEXfolhadeaprovacaoname}{Folha de aprova\c{c}\~ao}
\newcommand{\ABNTEXresumoname}{Resumo}
\newcommand{\ABNTEXlistadesiglasname}{Lista de abreviaturas e siglas}
\newcommand{\ABNTEXlistadesimbolosname}{Lista de s\'imbolos}
\newcommand{\ABNTEXfontename}{Fonte}
\newcommand{\ABNTEXnotaname}{Nota}
%
\addto\captionsbrazil{% portugues-brasil
  %% ajusta nomes padroes do babel
  \renewcommand{\bibname}{Refer\^encias}
  \renewcommand{\indexname}{\'Indice}
  \renewcommand{\listfigurename}{Lista de ilustra\c{c}\~{o}es}
  \renewcommand{\listtablename}{Lista de tabelas}
  %% ajusta nomes usados com a macro \autoref
  \renewcommand{\pageautorefname}{p\'agina}
  \renewcommand{\sectionautorefname}{se{\c c}\~ao}
  \renewcommand{\subsectionautorefname}{subse{\c c}\~ao}
  \renewcommand{\subsubsectionautorefname}{subse{\c c}\~ao}
  \renewcommand{\paragraphautorefname}{subse{\c c}\~ao}
}
\addto\captionsenglish{% ingles
  %% adjusts names from abnTeX2
  \renewcommand{\ABNTEXfolhaderostoname}{Title page}
  \renewcommand{\ABNTEXepigraphname}{Epigraph}
  \renewcommand{\ABNTEXdedicatorianame}{Dedication}
  \renewcommand{\ABNTEXerrataname}{Errata sheet}
  \renewcommand{\ABNTEXagradecimentosname}{Acknowledgements}
  \renewcommand{\ABNTEXanexoname}{ANNEX}
  \renewcommand{\ABNTEXanexosname}{Annex}
  \renewcommand{\ABNTEXapendicename}{APPENDIX}
  \renewcommand{\ABNTEXapendicesname}{Appendix}
  \renewcommand{\ABNTEXorientadorname}{Supervisor:}
  \renewcommand{\ABNTEXcoorientadorname}{Co-supervisor:}
  \renewcommand{\ABNTEXfolhadeaprovacaoname}{Approval}
  \renewcommand{\ABNTEXresumoname}{Abstract}
  \renewcommand{\ABNTEXlistadesiglasname}{List of abbreviations and acronyms}
  \renewcommand{\ABNTEXlistadesimbolosname}{List of symbols}
  \renewcommand{\ABNTEXfontename}{Source}
  \renewcommand{\ABNTEXnotaname}{Note}
   %% adjusts names used by \autoref
  \renewcommand{\pageautorefname}{page}
  \renewcommand{\sectionautorefname}{section}
  \renewcommand{\subsectionautorefname}{subsection}
  \renewcommand{\subsubsectionautorefname}{subsubsection}
  \renewcommand{\paragraphautorefname}{subsubsubsection}
}

% Pacote que permite realizar operacoes matematicas no codigo TeX
\RequirePackage{calc}

% Margens - NBR 14724/2011 - 5.1 Formato
\setlrmarginsandblock{3cm}{2cm}{*}
\setulmarginsandblock{3cm}{2cm}{*}
\checkandfixthelayout

% Espacamento entre linhas - NBR 14724/2011 - 5.2 Espacamento
\OnehalfSpacing

% ------------------------------------------------------------------------
% Comandos publicos
% ------------------------------------------------------------------------

% ``Tamanho menor e uniforme'' ditada pela NBR 14724/2011 - 5.1
\newcommand{\ABNTEXfontereduzida}{\footnotesize}

% abnTeX2 name
\newcommand{\abnTeX}{abn\TeX2}

% Fontes padroes de part, chapter, section, subsection e subsubsection
\newcommand{\ABNTEXchapterfont}{\sffamily}
\newcommand{\ABNTEXchapterfontsize}{\Huge}

\newcommand{\ABNTEXpartfont}{\ABNTEXchapterfont}
\newcommand{\ABNTEXpartfontsize}{\ABNTEXchapterfontsize}

\newcommand{\ABNTEXsectionfont}{\ABNTEXchapterfont}
\newcommand{\ABNTEXsectionfontsize}{\Large}

\newcommand{\ABNTEXsubsectionfont}{\ABNTEXsectionfont}
\newcommand{\ABNTEXsubsectionfontsize}{\large}

\newcommand{\ABNTEXsubsubsectionfont}{\ABNTEXsubsectionfont}
\newcommand{\ABNTEXsubsubsectionfontsize}{\normalsize}

\newcommand{\ABNTEXsubsubsubsectionfont}{\ABNTEXsubsectionfont}
\newcommand{\ABNTEXsubsubsubsectionfontsize}{\normalsize}

% ------------------------------------------------------------------------
% Comandos e variaveis privados
% ------------------------------------------------------------------------

% Comando para registro do bookmark interno
\newcounter{abntex@bookmarkcounter}
\setcounter{abntex@bookmarkcounter}{0}
\newcommand{\ABNTEXPRIVATEbookmarkthis}[1]{%
  \addtocounter{abntex@bookmarkcounter}{1}%
  \phantomsection\pdfbookmark[0]{#1}{chapterb\arabic{abntex@bookmarkcounter}}
}

% Comando que cria capítulos não numerados já com bookmark anotado
\newcommand{\ABNTEXpretextualchapter}[1]{%
  \addtocounter{abntex@bookmarkcounter}{1}%
  \ABNTEXPRIVATEbookmarkthis{#1}%
  \chapter*[#1]{#1}%
  }
\provideboolean{abntex@apendiceousecao}
\setboolean{abntex@apendiceousecao}{false}

% cleardoublepage se este documento não for article
\newcommand{\ABNTEXPRIVATEclearpageifneeded}{%
  \ifthenelse{\equal{\ABNTEXisarticle}{true}}{%
    %
  }{ % else
    \cleardoublepage%
  }
}

% ------------------------------------------------------------------------
% Configuracoes de layout
% ------------------------------------------------------------------------

% Notas de rodape - footnotes - NBR 14724/2011 - 5.2.1
\setlength{\footmarkwidth}{1.2em} % largura do footnotemark
\setlength{\footmarksep}{0em}
\footmarkstyle{\footnotesize{\textsuperscript{#1}}\hfill}

% tamanho da fonte do footnote
\renewcommand{\foottextfont}{\ABNTEXfontereduzida}

% Numeracao continua das figuras
\ifthenelse{\equal{\ABNTEXisarticle}{true}}{%
  \counterwithout{section}{chapter}
  \counterwithout{figure}{section}
  \counterwithout{table}{section}
}{%else
  \counterwithout{figure}{chapter}
  \counterwithout{table}{chapter}
}

% Estilos de caption
\hangcaption
\newcommand{\ABNTEXcaptiondelim}{~\textendash~}
\newcommand{\ABNTEXcaptionfontedelim}{:~}
%\captionnamefont{\ABNTEXfontereduzida}
%\captiontitlefont{\ABNTEXfontereduzida}

% Para uso com pacotes subfig e caption dentro do memoir se estes forem carregados ou não.
% É necessário para que os comandos \ABNTEXIBGEtab e \ABNTEXfonte funcionem
% independente do carregamento de pacotes externos ao memoir que tratam captions.
\newcommand{\ABNTEXIBGEtabfontsize}{\ABNTEXfontereduzida}
\AtBeginDocument{%
  % comandos auxiliares para manipular os captions dentro do comando \ABNTEXIBGEtab.
  \newcommand{\ABNTEXconfigurecaptions}{\captionstyle[\raggedright]{}}
  \newcommand{\ABNTEXconfigureseparator}{\captiondelim{\ABNTEXcaptiondelim}}
  % Define o comando \ABNTEXIBGEtab{}{}{} com caption e legenda da largura do conteúdo tabular, tabular*, etc
  % Parece funcionar com qualque pacote
  \newsavebox{\myptabbox}
  \newlength{\myptabboxwidth}
  \newcommand{\ABNTEXIBGEtab}[3]{%
    \savebox{\myptabbox}{{\ABNTEXIBGEtabfontsize #2}}%
    \settowidth{\myptabboxwidth}{\usebox{\myptabbox}}%
    \centering%
    \parbox{\myptabboxwidth}{%
    \ABNTEXconfigurecaptions
    #1%
    \par%
    {\ABNTEXIBGEtabfontsize%
    #2%
    }%
    \par%
    #3}%
  }
  \let\ABNTEXibgetab\ABNTEXIBGEtab
}

% Altera os comandos \ABNTEXconfigurecaptions e \ABNTEXconfigureseparator para trabalhar com
% o pacote caption e amigos.
\AtEndPackage{caption}{
  \AtBeginDocument{%
    \DeclareCaptionLabelSeparator{barr}{\ABNTEXcaptiondelim}
    \DeclareCaptionFont{ABNTEXfontereduzida}{\ABNTEXfontereduzida}
      \captionsetup{format=hang,
                    labelseparator=barr,
                    %labelfont=ABNTEXfontereduzida,
                    %font=ABNTEXfontereduzida
                    }
      \renewcommand{\ABNTEXconfigurecaptions}{%
                  \captionsetup{justification=justified,%
                                singlelinecheck=false}}
      \renewcommand{\ABNTEXconfigureseparator}{\captionsetup{labelsep=colon}}
  }
}

\AtBeginDocument{
 \captiondelim{\ABNTEXcaptiondelim}
}

% -----
% Configuracoes do TOC
% -----
% nivel de profundidade (implementa o quinto nivel - subsubsubsection)
\setsecnumdepth{paragraph}
\settocdepth{paragraph}
\setcounter{tocdepth}{5}
\setcounter{secnumdepth}{5}
\maxsecnumdepth{paragraph}

% redefine os comandos *paragraph* para *subsubsubsection* ****
\newcommand{\ABNTEXsubsubsubsection}{\paragraph}
\newcommand{\ABNTEXcftbeforesubsubsubsectionskip}{\cftbeforeparagraphskip}
\newcommand{\ABNTEXcftsubsubsubsectionfont}{\cftparagraphfont}
\newcommand{\ABNTEXsetsubsubsubsecheadstyle}{\setparaheadstyle}

\setafterparaskip{1.0\onelineskip plus 0.5\onelineskip minus 0.2\onelineskip}
\setparaheadstyle{\normalfont\sffamily\raggedright}%

% lista de ilustracoes
\renewcommand{\cftfigurename}{\figurename\space}
\renewcommand*{\cftfigureaftersnum}{\hfill\textendash\hfill}

% lista de tabelas
\renewcommand{\cfttablename}{\tablename\space}
\renewcommand*{\cfttableaftersnum}{\hfill\textendash\hfill}

% fonte das partes e do capitulo do TOC
\renewcommand{\tocheadstart}{\ABNTEXchapterfont}

% leaders para os capítulos
\renewcommand*{\cftchapterdotsep}{\cftdotsep}

% suprime espaço entre os itens de listings de diferentes capítulos
\setlength{\cftbeforechapterskip}{0pt plus 0pt}
\renewcommand*{\insertchapterspace}{}

% macros para configurar o Sumário conforme 6027-2012 ou tradicional cft
\cftinsertcode{A}{}

\newlength{\cftlastnumwidth}
\setlength{\cftlastnumwidth}{\cftsubsubsectionnumwidth}
\addtolength{\cftlastnumwidth}{1em}

\newcommand{\ABNTEXtocprintchapter}{}
\newcommand{\ABNTEXtocinnonumchapter}{}
\newcommand{\ABNTEXtocprintchapternonum}{}
\newcommand{\ABNTEXtocpartapendices}{}
\newcommand{\ABNTEXtocpartanexos}{}

% insere o hifen no anexo/apendice do toc
\cftinsertcode{A}{\renewcommand{\cftchapteraftersnum}{\hfill\textendash\hfill}}

% No caso de Sumario (TOC) tradicional
\ifthenelse{\boolean{ABNTEXsumario-tradicional}}{}{} % essa linha não faz nada,
                                                     % mas se houver necessidade de alterar o comportamento
                                                     % do sumário tradicional altere aqui.

% No caso de Sumario (TOC) especifico da ABNT-6027-2012

\ifthenelse{\boolean{ABNTEXsumario-abnt-6027-2012}}{
  \settocpreprocessor{chapter}{%
  \let\tempf@rtoc\f@rtoc%
  \def\f@rtoc{%
  \texorpdfstring{\MakeTextUppercase{\tempf@rtoc}}{\tempf@rtoc}}%
  }
  \settocpreprocessor{part}{%
  \let\tempf@rtoc\f@rtoc%
  \def\f@rtoc{%
  \texorpdfstring{\MakeTextUppercase{\tempf@rtoc}}{\tempf@rtoc}}%
  }
}{}
%
\ifthenelse{\boolean{ABNTEXsumario-abnt-6027-2012}}{%

  \cftsetindents{part}{0em}{\cftlastnumwidth}
  \cftsetindents{chapter}{0em}{\cftlastnumwidth}
  \cftsetindents{section}{0em}{\cftlastnumwidth}
  \cftsetindents{subsection}{0em}{\cftlastnumwidth}
  \cftsetindents{subsubsection}{0em}{\cftlastnumwidth}
  \cftsetindents{paragraph}{0em}{\cftlastnumwidth}
  \cftsetindents{subparagraph}{0em}{\cftlastnumwidth}
  %
  \renewcommand{\ABNTEXtocprintchapter}{%
    \addtocontents{toc}{\cftsetindents{chapter}{0em}{\cftlastnumwidth}}}
  %
  \renewcommand{\ABNTEXtocinnonumchapter}{%
    \addtocontents{toc}{\cftsetindents{chapter}{\cftlastnumwidth}{2em}}%
    \cftinserthook{toc}{A}}
  %
  \renewcommand{\ABNTEXtocprintchapternonum}{%
    \addtocontents{toc}{\cftsetindents{chapter}{\cftlastnumwidth}{2em}}}
  %
  \renewcommand{\ABNTEXtocpartapendices}{%
    \addtocontents{toc}{\cftsetindents{part}{\cftlastnumwidth}{2em}}
    \cftinserthook{toc}{A}}
  %
  \renewcommand{\ABNTEXtocpartanexos}{%
    \addtocontents{toc}{\cftsetindents{part}{\cftlastnumwidth}{2em}}
    \cftinserthook{toc}{A}}
  %
  \setlength{\cftbeforechapterskip}{1em}
  %
  % Fontes das entradas do sumario
  %
  \renewcommand{\cftpartfont}{\bfseries\large}
  %
  \renewcommand{\cftchapterfont}{\bfseries}
  \renewcommand{\cftchapterpagefont}{\normalsize\cftchapterfont}
  %
  \renewcommand{\cftsectionfont}{\bfseries}
  \renewcommand{\cftsectionpagefont}{\cftsectionfont}
  %
  \renewcommand{\cftsubsectionfont}{\normalsize}
  \renewcommand{\cftsubsectionpagefont}{\cftsubsectionfont}
  %
  \renewcommand{\cftsubsubsectionfont}{\small}
  \renewcommand{\cftsubsubsectionpagefont}{\cftsubsubsectionfont}
  %
  \renewcommand{\cftparagraphfont}{\footnotesize}
  \renewcommand{\cftparagraphpagefont}{\cftparagraphfont}
  %
  % Ajusta entrada Referencias
  %
  \renewcommand{\bibsection}{%
    \chapter*{\bibname}
    \bibmark
    \ifnobibintoc\else
    \phantomsection
    \addcontentsline{toc}{chapter}{\texorpdfstring{\MakeTextUppercase{\bibname}}{\bibname}}
    \fi
    \prebibhook
}

}{}

% Comando que simula a finalizacao de uma parte no bookmark e
% adiciona espaco de \part no sumario
\newcommand{\ABNTEXphantompart}{%
  \bookmarksetup{startatroot}%
  \phantomsection%
  \ifthenelse{\boolean{ABNTEXsumario-abnt-6027-2012}}{%
    \addtocontents{toc}{\vspace{\cftbeforechapterskip}}}{%
    \addtocontents{toc}{\vspace{\cftbeforepartskip}}}%
}
% -----

% Configuracao dos titulos dos capítulos
% Novo estido do memoir
% ABNT NBR 14724-2011 - 5.2.2-5.2.4; ABNT NBR 6024-2003 - 3.1-3.8
\provideboolean{abntex@innonumchapter}
\setboolean{abntex@innonumchapter}{true}
\makechapterstyle{abnt}{%
  \renewcommand{\chapterheadstart}{}

  \ifx \chapternamenumlength \undefined
    \newlength{\chapternamenumlength}
  \fi

  % tamanhos de fontes de chapter e part
   \ifthenelse{\equal{\ABNTEXisarticle}{true}}{%
     \setlength\beforechapskip{\baselineskip}%
     \renewcommand{\chaptitlefont}{\ABNTEXsectionfont\ABNTEXsectionfontsize}%
   }{%else
     \setlength{\beforechapskip}{0pt}%
     \renewcommand{\chaptitlefont}{\ABNTEXchapterfont\ABNTEXchapterfontsize}%
   }

  \renewcommand{\chapnumfont}{\chaptitlefont}
  \renewcommand{\parttitlefont}{\ABNTEXpartfont\ABNTEXpartfontsize}
  \renewcommand{\partnumfont}{\ABNTEXpartfont\ABNTEXpartfontsize}
  \renewcommand{\partnamefont}{\ABNTEXpartfont\ABNTEXpartfontsize}

  % tamanhos de fontes de section, subsection, subsubsection e subsubsubsection
  \setsecheadstyle{\ABNTEXsectionfont\ABNTEXsectionfontsize\ABNTEXsectionupperifneeded}
  \setsubsecheadstyle{\ABNTEXsubsectionfont\ABNTEXsubsectionfontsize\ABNTEXsubsectionupperifneeded}
  \setsubsubsecheadstyle{\ABNTEXsubsubsectionfont\ABNTEXsubsubsectionfontsize\ABNTEXsubsubsectionupperifneeded}
  \ABNTEXsetsubsubsubsecheadstyle{\ABNTEXsubsubsubsectionfont\ABNTEXsubsubsubsectionfontsize\ABNTEXsubsubsubsectionupperifneeded}

  % impressao do numero do capitulo
  \renewcommand{\chapternamenum}{}

  % impressao do nome do capitulo
  \renewcommand{\printchaptername}{%
   \chaptitlefont%
   \ifthenelse{\boolean{abntex@apendiceousecao}}{\appendixname}{}%
  }

  % impressao do titulo do capitulo
  \def\printchaptertitle##1{%
    \chaptitlefont%
    \ifthenelse{\boolean{abntex@innonumchapter}}{\centering\ABNTEXchapterupperifneeded{##1}}{%
    \ifthenelse{\boolean{abntex@apendiceousecao}}{%
        \centering%
        \settowidth{\chapternamenumlength}{\printchaptername\printchapternum\afterchapternum}%
        \ABNTEXchapterupperifneeded{##1}%
      }{%
        \settowidth{\chapternamenumlength}{\printchaptername\printchapternum\afterchapternum}%
        \parbox[t]{\columnwidth-\chapternamenumlength}{\ABNTEXchapterupperifneeded{##1}}}%
     }%
  }

  % impressao do numero do capitulo
  \renewcommand{\printchapternum}{%
     \ABNTEXtocprintchapter%
     \setboolean{abntex@innonumchapter}{false}%
     \chapnumfont%
     \space\thechapter%
     \ifthenelse{\boolean{abntex@apendiceousecao}}{%
       \ABNTEXtocinnonumchapter%
       \ABNTEXcaptiondelim%
     }{}%
     \space%
  }
  \renewcommand{\afterchapternum}{}

  % impressao do capitulo não numerado
  \renewcommand\printchapternonum{%
     \ABNTEXtocprintchapternonum%
     \setboolean{abntex@innonumchapter}{true}%
    }
}
\chapterstyle{abnt}

% -----
% Declaracoes de cabecalhos
% -----
% Cabecalho padrao
\makepagestyle{abntheadings}
\makeevenhead{abntheadings}{\ABNTEXfontereduzida\thepage}{}{\ABNTEXfontereduzida\textit\leftmark}
\makeoddhead{abntheadings}{\ABNTEXfontereduzida\textit\rightmark}{}{\ABNTEXfontereduzida\thepage}
\makeheadrule{abntheadings}{\textwidth}{\normalrulethickness}

% Cabecalho do inicio do capitulo
\makepagestyle{abntchapfirst}
\makeoddhead{abntchapfirst}{}{}{\ABNTEXfontereduzida\thepage}

% Configura layout para elementos pre-textuais
\newcommand{\ABNTEXpretextual}{%
  \aliaspagestyle{chapter}{empty}% customizing chapter pagestyle
  \pagestyle{empty}
  \aliaspagestyle{cleared}{empty}
  \aliaspagestyle{part}{empty}
}
\renewcommand{\frontmatter}{\ABNTEXpretextual}

% por default, inicializa o documento com elementos \pretextuais
\AtBeginDocument{\ABNTEXpretextual}

% Configura layout para elementos textuais
\newcommand{\ABNTEXtextual}{%
  \ifthenelse{\equal{\ABNTEXisarticle}{true}}{%
    \pagestyle{plain}%
  }{%else
    \pagestyle{abntheadings}%
    \aliaspagestyle{chapter}{abntchapfirst}% customizing chapter pagestyle
  }
  \nouppercaseheads%
  \bookmarksetup{startatroot}%
}
\renewcommand{\mainmatter}{\ABNTEXtextual}

% Configura layout para elementos pos-textuais
\newcommand{\ABNTEXpostextual}{\ABNTEXphantompart}
\renewcommand{\backmatter}{\ABNTEXpostextual}
% -----

% ------------------------------------------------------------------------
% Comandos de dados para CAPA e FOLHA DE ROSTO
% ------------------------------------------------------------------------

\newcommand{\ABNTEXtituloestrangeiro}[1]{\providecommand{\abntextheforeigntitle}{#1}}
\newcommand{\ABNTEXimprimirtituloestrangeiro}{\abntextheforeigntitle}

\let\olddate\date
\renewcommand{\date}[1]{\AtBeginDocument{\olddate{#1}}}
\newcommand{\ABNTEXdata}[1]{\date{#1}}
\newcommand{\ABNTEXimprimirdata}{\thedate}

\providecommand{\abnteximprimirinstituicao}{}
\newcommand{\ABNTEXinstituicao}[1]{\renewcommand{\abnteximprimirinstituicao}{#1}}

\providecommand{\abnteximprimirlocal}{}
\newcommand{\ABNTEXlocal}[1]{\renewcommand{\abnteximprimirlocal}{#1}}

\providecommand{\abnteximprimirpreambulo}{}
\newcommand{\ABNTEXpreambulo}[1]{\renewcommand{\abnteximprimirpreambulo}{#1}}

\providecommand{\abnteximprimirorientadorRotulo}{}
\providecommand{\abnteximprimirorientador}{}
\newcommand{\ABNTEXorientador}[2][\ABNTEXorientadorname]%
  {\renewcommand{\abnteximprimirorientadorRotulo}{#1}%
   \renewcommand{\abnteximprimirorientador}{#2}}

\providecommand{\abnteximprimircoorientadorRotulo}{}
\providecommand{\abnteximprimircoorientador}{}
\newcommand{\ABNTEXcoorientador}[2][\ABNTEXcoorientadorname]%
  {\renewcommand{\abnteximprimircoorientadorRotulo}{#1}%
   \renewcommand{\abnteximprimircoorientador}{#2}}

\providecommand{\abnteximprimirtipotrabalho}{}
\newcommand{\ABNTEXtipotrabalho}[1]{\renewcommand{\abnteximprimirtipotrabalho}{#1}}

% ------------------------------------------------------------------------
% Comandos e ambientes de editoracao PRE-TEXTUAIS
% ------------------------------------------------------------------------

% Ambiente para definicao da Capa
\newenvironment{capa}{\begin{titlingpage}}{\end{titlingpage}\cleardoublepage}

% Titulos em lingua estrangeira para artigos: ABNT NBR 6022:2018
\ifthenelse{\equal{\ABNTEXisarticle}{true}}{%
\renewcommand{\maketitlehookb}{\LARGE\center\textit{\abntextheforeigntitle}}
}{}

% Ficha catalografica (Dados internacionais de
% catalogação-na-publicacao)
\newenvironment{fichacatalografica}{%
    \thispagestyle{empty}
    \begin{SingleSpacing}
      \ABNTEXfontereduzida
}{%
    \end{SingleSpacing}%
}%

% Errata
\newenvironment{errata}[1][\ABNTEXerrataname]{%
   \ABNTEXpretextualchapter{#1}
  }{\ABNTEXPRIVATEclearpageifneeded}

% Folha de aprovacao - NBR 14724/2011 - 4.2.1.3
\newenvironment{folhadeaprovacao}[1][\ABNTEXfolhadeaprovacaoname]{%
   \clearpage%
   \ABNTEXPRIVATEbookmarkthis{#1}%
   \begin{Spacing}{1.0}
}{\end{Spacing}\ABNTEXPRIVATEclearpageifneeded}

% Dedicatoria
\newenvironment{dedicatoria}[1][]{%
   \ifthenelse{\equal{#1}{}}{%
    \ABNTEXPRIVATEbookmarkthis{\ABNTEXdedicatorianame}
    }{\ABNTEXpretextualchapter{#1}}
  }{\ABNTEXPRIVATEclearpageifneeded}

% Agradecimentos
\newenvironment{agradecimentos}[1][\ABNTEXagradecimentosname]{%
   \ABNTEXpretextualchapter{#1}
  }{\ABNTEXPRIVATEclearpageifneeded}

% Epigrafe
\newenvironment{epigrafe}[1][]{%
   \ifthenelse{\equal{#1}{}}{%
    \ABNTEXPRIVATEbookmarkthis{\ABNTEXepigraphname}
    }{\ABNTEXpretextualchapter{#1}}
  }{\ABNTEXPRIVATEclearpageifneeded}

% Resumo e abstracts em diferentes idiomas - NBR 14724/2011

% altera as margens padrões do memoir para abstract caso não seja article
\ifthenelse{\equal{\ABNTEXisarticle}{true}}{%
    % em artigos, margens e fontes são as mesmas de memoir
  }{ % else
    % Ajusta as margens para serem a mesma do documento
    \setlength\absleftindent{0cm}
    \setlength\absrightindent{0cm}
    % Garante que a fonte do texto do abstract será a mesma do documento, pois
    % na classe memoir está \small
    \renewcommand{\abstracttextfont}{\normalfont\normalsize}
  }

% A norma não diz nada sobre identação e separação entre parágrafos no abstract,
% porém o uso mostra que muitos abstracts são montados sem identação.
\AtBeginDocument{%
   \setlength{\absparindent}{0pt}
}

\newenvironment{resumo}[1][\ABNTEXresumoname]{%
   \ABNTEXPRIVATEbookmarkthis{#1}
   \renewcommand{\abstractnamefont}{\chaptitlefont}
   \renewcommand{\abstractname}{\ABNTEXchapterupperifneeded{#1}}
   \begin{abstract}
  }{\end{abstract}\ABNTEXPRIVATEclearpageifneeded}

\newenvironment{resumoumacoluna}[1][\ABNTEXresumoname]{%
   \ABNTEXPRIVATEbookmarkthis{#1}
   \renewcommand{\abstractnamefont}{\chaptitlefont}
   \renewcommand{\abstractname}{\ABNTEXchapterupperifneeded{#1}}
   \begin{onecolabstract}
}{\end{onecolabstract}\ABNTEXPRIVATEclearpageifneeded}

% Lista de abreviaturas e siglas
\newenvironment{siglas}{%
  \ABNTEXpretextualchapter{\ABNTEXlistadesiglasname}
  \begin{symbols}
}{%
  \end{symbols}
  \cleardoublepage
}

% Lista de simbolos
\newenvironment{simbolos}{%
  \ABNTEXpretextualchapter{\ABNTEXlistadesimbolosname}
  \begin{symbols}
}{%
  \end{symbols}
  \cleardoublepage
}

% ------------------------------------------------------------------------
% Comandos e ambientes de editoracao APENDICES e ANEXOS
% ------------------------------------------------------------------------

% Definicoes compartilhadas entre Apendices e Anexos
\newcommand\@switch[1]{ \@writefile{toc}{\renewcommand*{\cftappendixname}{#1 \space}} }
\newcommand{\ABNTEXswitchchapname}[1]{ \protected@write \@auxout {}{\string\@switch{#1} }}

\newcommand{\ABNTEXPRIVATEapendiceconfig}[2]{%
 \setboolean{abntex@apendiceousecao}{true}%
 \renewcommand{\appendixname}{#1}
 \ifthenelse{\boolean{ABNTEXsumario-abnt-6027-2012}}{
   \renewcommand{\appendixtocname}{\uppercase{#2}}
  }{%
  \renewcommand{\appendixtocname}{#2}}
 \renewcommand{\appendixpagename}{#2}
 \ABNTEXswitchchapname{#1}% Corrected from \switchapname -> \ABNTEXswitchchapname
 \renewcommand*{\cftappendixname}{#1 \space}
}

% Apendices - comando
\newcommand{\ABNTEXapendices}{%
 \ABNTEXPRIVATEapendiceconfig{\ABNTEXapendicename}{\ABNTEXapendicesname}
 \appendix
}
% Apendices - ambiente
\newenvironment{apendicesenv}{%
 \ABNTEXPRIVATEapendiceconfig{\ABNTEXapendicename}{\ABNTEXapendicesname}
 \begin{appendix}
}{
 \end{appendix}
 \setboolean{abntex@apendiceousecao}{false}
 \bookmarksetup{startatroot}
}

% Anexos - comando
\newcommand{\ABNTEXanexos}{%
 \cftinserthook{toc}{AAA}

 \ABNTEXPRIVATEapendiceconfig{\ABNTEXanexoname}{\ABNTEXanexosname}
 \appendix
 \renewcommand\theHchapter{anexochapback.\arabic{chapter}}
}
% Anexos - ambiente
\newenvironment{anexosenv}{%
 \cftinserthook{toc}{AAA}

 \ABNTEXPRIVATEapendiceconfig{\ABNTEXanexoname}{\ABNTEXanexosname}
 \begin{appendix}
 \renewcommand\theHchapter{anexochapback.\arabic{chapter}}
}{
 \end{appendix}
 \setboolean{abntex@apendiceousecao}{false}
 \bookmarksetup{startatroot}
}

% Imprime uma pagina de divisao no estilo parte
\newcommand{\ABNTEXpartpage}{%
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{part}{\appendixtocname}%
  \appendixpage*
}

% atalhos para \ABNTEXpartpage ou \appendixpage*
\newcommand{\ABNTEXpartapendices}{%
\ABNTEXtocpartapendices%
\@ifstar{\appendixpage*}{\ABNTEXpartpage}}

\newcommand{\ABNTEXpartanexos}{%
\ABNTEXtocpartanexos%
\@ifstar{\appendixpage*}{\ABNTEXpartpage}}

% ------------------------------------------------------------------------
% Comandos e ambientes de editoracao CITACAO, ALINEA, INCISO, ASSINATURA
% ------------------------------------------------------------------------

% Citacao direta com mais de 3 linhas - ABNT NBR 10520/2002 - 5.3
\newlength{\ABNTEXcitacaorecuo}% recuo de 4 cm da margem esquerda
\ifthenelse{\equal{\ABNTEXistwocolumn}{true}}{%
  \setlength{\ABNTEXcitacaorecuo}{1.8cm}
}{% else
  \setlength{\ABNTEXcitacaorecuo}{4cm}
}

% Patch the `abntex2` citacao environment removing the extra space from its top
% q/topsep-itemsep-partopsep-and-parsep-what-does-each-of-them-mean-and-wha
% q/redefine-environment-to-be-a-synonym-for-another
\newenvironment*{citacao}[1][default]{%
   % q/topsep-itemsep-partopsep-and-parsep-what-does-each-of-them-mean-and-wha
   \list{}{\topsep=4pt}%
   \addtolength{\leftskip}{\ABNTEXcitacaorecuo}%
   \item[]%
   \begin{SingleSpace}%
   \ifthenelse{\not\equal{#1}{default}}{\itshape\selectlanguage{#1}}{}%
   \ABNTEXfontereduzida%
 }{%
   \end{SingleSpace}%
   \endlist}%

% Ambiente para alineas e e subalineas (incisos)
% ABNT NBR 6024/2012 - 4.2 e 4.3
\newlist{alineas}{enumerate}{2}
\setlist[alineas,1]{label={\alph*)},topsep=0pt,itemsep=0pt,leftmargin=\parindent+\labelwidth-\labelsep}%
\setlist[alineas,2]{label={--},topsep=0pt,itemsep=0pt,leftmargin=*}
\newlist{subalineas}{enumerate}{1}
\setlist[subalineas,1]{label={--},topsep=0pt,itemsep=0pt,leftmargin=*}%
\newlist{incisos}{enumerate}{1}
\setlist[incisos,1]{label={--},topsep=0pt,itemsep=0pt,leftmargin=*}%

% Comando \ABNTEXassinatura for signature
   % width of the line and text under the line
\newlength{\ABNTEXsignwidth}
\setlength{\ABNTEXsignwidth}{8cm}
   % thickness of the line
\newlength{\ABNTEXsignthickness}
\setlength{\ABNTEXsignthickness}{1pt}
   % ammount of space left between previous text and th signature line
\newlength{\ABNTEXsignskip}
\setlength{\ABNTEXsignskip}{0.7cm}
   % \ABNTEXassinatura{name} -> types a line with name under the line, centralized
   % \ABNTEXassinatura*{name} -> Creates the box with the line and name under
   %     it, but the box has no position assigned. However the line and the
   %     name are centralized with respect to each other.
\newcommand{\ABNTEXassinatura}{\@ifstar{\ABNTEXsign}{\ABNTEXcsign}}
   % assinatura com estrela
\newcommand{\ABNTEXsign}[1]{%
  \parbox[t]{\ABNTEXsignwidth}{\SingleSpacing\vspace*{\ABNTEXsignskip}\centering%
  \rule{\ABNTEXsignwidth}{\ABNTEXsignthickness}\\%
  \nopagebreak #1\par}%
}
   % assinatura sem estrela
\newcommand{\ABNTEXcsign}[1]%
  {\begingroup\par\centering\ABNTEXsign{#1}\par\endgroup}

% ------------------------------------------------------------------------
% IMPRESSOES PADROES DE CAPA E FOLHA DE ROSTO
% ------------------------------------------------------------------------

% Impressão da Capa
\newcommand{\ABNTEXimprimircapa}{%
  \begin{capa}%
    \center
    \ABNTEXchapterfont\large\theauthor

    \vfill
    \begin{center}
    \ABNTEXchapterfont\bfseries\LARGE\thetitle
    \end{center}
    \vfill

    \large\abnteximprimirlocal

    \large\ABNTEXimprimirdata

    \vspace*{1cm}
  \end{capa}
}

% Folha de rosto
%   usar \ABNTEXimprimirFolhaDeRosto* casodeseje imprimir algo no verso da
%   página no caso de estar no modo twoside. Util para imprimir a Ficha
%   Bibliografica. Porem, se estiver no modo oneside, a versao sem estrela
%   é identica.
\newenvironment{folhaderosto}[1][\ABNTEXfolhaderostoname]{\clearpage\ABNTEXPRIVATEbookmarkthis{#1}}{\cleardoublepage}
\newenvironment{folhaderosto*}[1][\ABNTEXfolhaderostoname]{\clearpage\ABNTEXPRIVATEbookmarkthis{#1}}{\newpage}%

% Conteudo padrao da Folha de Rosto
\newcommand{\ABNTEXfolhaderostocontent}{
  \begin{center}

    %\vspace*{1cm}
    {\ABNTEXchapterfont\large\theauthor}

    \vspace*{\fill}\vspace*{\fill}
    \begin{center}
      \ABNTEXchapterfont\bfseries\Large\thetitle
    \end{center}
    \vspace*{\fill}

    \abntex@UFSCifNotEmpty{\abnteximprimirpreambulo}{%
      \hspace{.45\textwidth}
      \begin{minipage}{.5\textwidth}
        \SingleSpacing
         \abnteximprimirpreambulo
       \end{minipage}%
       \vspace*{\fill}
    }%

    {\abntex@UFSCifNotEmpty{\abnteximprimirinstituicao}{\abnteximprimirinstituicao\vspace*{\fill}}}

    {\large\abnteximprimirorientadorRotulo~\abnteximprimirorientador\par}
    \abntex@UFSCifNotEmpty{\abnteximprimircoorientador}{%
       {\large\abnteximprimircoorientadorRotulo~\abnteximprimircoorientador}%
    }%
    \vspace*{\fill}

    {\large\abnteximprimirlocal}
    \par
    {\large\ABNTEXimprimirdata}
    \vspace*{1cm}

  \end{center}
}

\newcommand{\ABNTEXimprimirFolhaDeRostostar}[1]{%
  \begin{folhaderosto*}{#1}
     \ABNTEXfolhaderostocontent
  \end{folhaderosto*}}

\newcommand{\ABNTEXimprimirFolhaDeRostonostar}[1]{%
  \begin{folhaderosto}{#1}
     \ABNTEXfolhaderostocontent
  \end{folhaderosto}}

\newcommand{\ABNTEXimprimirFolhaDeRosto}[1][\ABNTEXfolhaderostoname]{%
   \@ifstar
     \ABNTEXimprimirFolhaDeRostostar
     \ABNTEXimprimirFolhaDeRostonostar
}

\makeatother
