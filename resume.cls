%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Created by Trey Hunner
% Modified by www.LaTeXTemplates.com
% Modified by Nicholas Hanson-Holtry
%
% Copyright (C) 2010 by Trey Hunner
%
% Copying and distribution of this file, with or without modification,
% are permitted in any medium without royalty provided the copyright
% notice and this notice are preserved. This file is offered as-is,
% without any warranty.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ProvidesClass{resume}[2015/06/22 v0.9.1 CV/Resume Class]

\LoadClass[12pt,letterpaper]{article} % Font size and paper type

\usepackage[parfill]{parskip} % Remove paragraph indentation
\usepackage{array} % Required for boldface (\bf and \bfseries) tabular columns
\usepackage{ifthen} % Required for ifthenelse statements

\usepackage{etoolbox} % easier than ifthenelses
\newtoggle{cv} % create a toggle variable "cv"
\ifdefined \iscv % check if "iscv" was passed from the command line
\toggletrue{cv} % if so, compile the doc to a cv (more information)
\else \togglefalse{cv} \fi % if not, compile to a resume (less information)

\iftoggle{cv}{\setlength{\footskip}{4\baselineskip}} % CVs need extra space for page numbers
{\pagestyle{empty}} % Resumes don't have page numbers (only one page)

\usepackage[super]{nth} % Required for ifthenelse statements

\usepackage{tabto}
\NumTabs{11}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	CUSTOM COMMANDS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def \name#1{\def\@name{#1}} % Defines the \name command to set name
\def \@name {} % Sets \@name to empty by default

\def \addressSep {$\diamond$} % Set default address separator to a diamond

% One, two or three address lines can be specified 
\let \@addressone \relax
\let \@addresstwo \relax
\let \@addressthree \relax

% \address command can be used to set the first, second, and third address (last 2 optional)
\def \address #1{
  \@ifundefined{@addresstwo}{
    \def \@addresstwo {#1}
  }{
  \@ifundefined{@addressthree}{
  \def \@addressthree {#1}
  }{
     \def \@addressone {#1}
  }}
}

% \printaddress is used to style an address line (given as input)
\def \printaddress #1{
  \begingroup
    \def \\ {\addressSep\ }
    \centerline{#1}
  \endgroup
  \par
  \addressskip
}

\def\CV{Curriculum Vitae}

% \printname is used to print the name as a page header
\def \printname {
  \iftoggle{cv}{
    \hfil\emph{\large \CV}\newline\newline\nameskip
    \hfil{\namesize\bf \@name}\newline
  }{
    % \hfil{\namesize\bf \@name}\nameskip\newline
    \hfil{\namesize\@name}\nameskip\newline
  }
}

% The below commands define the whitespace after certain things in the document
\def\namesize{\LARGE} % Size of the name at the top of the document
\def\addressskip{\smallskip} % The space between the two address (or phone/email) lines
\def\sectionlineskip{\medskip} % The space above the horizontal line for each section 
\def\nameskip{\bigskip} % The space after your name at the top
\def\sectionskip{\medskip} % The space after the heading section

% change the margins of the paper
\usepackage{geometry}
\geometry{
    tmargin    = 1.00 in,
    lmargin    = 0.75 in,
    rmargin    = 0.75 in,
    bmargin    = 0.75 in,
    headsep    = 0.25 in
}

\usepackage{fancyhdr} % define a header across the top of the page
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}

\fancyhead[R]{\emph{\@name, \CV, Page \thepage}}
% \fancyhead[R]{\underline{\emph{\@name, \CV, Page \thepage}}}
% \fancyhead[R]{\underline{\@name, \emph{\CV}, Page \thepage}}

% Print the header
\let\ori@document=\document
\renewcommand{\document}{
  \ori@document  % Begin document
  \thispagestyle{empty} % Suppress the header on this (the first) page
  \vspace*{-.75in} % Move the content up to where the header usually is
  \printname % Print the name specified with \name
  \@ifundefined{@addressone}{}{ % Print the first address if specified
    \printaddress{\@addressone}}
  \@ifundefined{@addresstwo}{}{ % Print the second address if specified
    \printaddress{\@addresstwo}}
     \@ifundefined{@addressthree}{}{ % Print the third address if specified
    \printaddress{\@addressthree}}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	SECTION FORMATTING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Defines the rSection environment for the large sections within the CV
\newenvironment{rSection}[1]{ % 1 input argument - section name
  \sectionskip
  % {\bf #1} % Section title
  {\emph{#1}} % Section title
  \sectionlineskip
  \hrule % Horizontal line
  \sectionskip
  \begin{list}{}{ % List for each individual item in the section
    \setlength{\leftmargin}{1.5em} % Margin within the section
  }
  \par\nobreak
  \item[]
}{
  \end{list}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	SUB-SECTION FORMATTING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% bold on the left, emph on the right
% \newcommand{\BoldEmph}[2]{{\bf#1}\hfill{\em#2}}
% normal on the left, emph on the right
% \newcommand{\NormalEmph}[2]{{#1}\hfill{\em#2}}
% NEW: removed emph from right sides
\newcommand{\BoldEmph}[2]{{\bf#1}\hfill{#2}}
\newcommand{\NormalEmph}[2]{{#1}\hfill{#2}}

% bold on top left, normal on bottom right, emph on right
\newcommand{\FourTitle}[4]{%
  \ifthenelse{\equal{#1}{}}{}{\BoldEmph{#1}{#2}% maybe print first two
  \ifthenelse{\equal{#3}{}}{}{\\}}% put in the line break if printing all four
  \ifthenelse{\equal{#3}{}}{}{\NormalEmph{#3}{#4}}}% maybe print second two

\newcommand{\EventWithSubtitle}[4]{\FourTitle{#1}{#2}{#3}{#4}}

\newenvironment{rSubSection}[4]{ % 4 input arguments
  \FourTitle{#1}{#2}{#3}{#4}\smallskip
  \begin{list}{$\cdot$}{\leftmargin=0em} % \cdot used for bullets, no indentation
  \itemsep -0.5em
  \vspace{-.75em} % Compress items in list together for aesthetics
  % USED TO BE: both ON, -.75
  % TODO: which is better???
  % ANSWER: the way it was (lol)
}{
  \end{list}
  % \vspace{0.5em} % Some space after the list of bullet points
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ( SUB * k )-SECTION FORMATTING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\changemargin#1#2{\list{}{\rightmargin#2\leftmargin#1}\item[]}
\let\endchangemargin=\endlist

\newcommand{\Event}[2]{\NormalEmph{#1}{#2}}
\newcommand{\Thing}[1]{\NormalEmph{#1}{  }}
\newcommand{\bfEvent}[2]{\BoldEmph{#1}{#2}}
\newcommand{\bfThing}[1]{\BoldEmph{#1}{  }}

\newcommand{\UniversityTitle}[2]{%
%\BoldEmph{#1}{#2}}
\NormalEmph{#1}{#2}}

\newcommand{\DepartmentTitle}[1]{%
\begin{changemargin}{1.5em}{0em}%
%\BoldEmph{#1}{}%
\NormalEmph{#1}{}%
\end{changemargin}}

\newcommand{\BeginUnivEvents}{%
\begin{changemargin}{1.5em}{0em}}
\newcommand{\EndUnivEvents}{%
\end{changemargin}}

\newcommand{\BeginDeptEvents}{%
\begin{changemargin}{3.0em}{0em}}
\newcommand{\EndDeptEvents}{%
\end{changemargin}}

\newenvironment{UnivDeptItem}[4]{
  \begin{changemargin}{3.0em}{0em}
  \begin{rSubSection}{#1}{#2}{#3}{#4}
}{
  \end{rSubSection}
  \end{changemargin}
}
