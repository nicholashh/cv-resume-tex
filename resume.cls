%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (C) 2010 by Trey Hunner
%
% Copying and distribution of this file, with or without modification,
% are permitted in any medium without royalty provided the copyright
% notice and this notice are preserved. This file is offered as-is,
% without any warranty.
%
% Created by Trey Hunner
% Modified by www.LaTeXTemplates.com
% Modified by Nicholas Hanson-Holtry
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ProvidesClass{resume}[2015/06/22 v0.9.1 CV/Resume Class]

\LoadClass[12pt,letterpaper]{article} % Font size and paper type

\usepackage[parfill]{parskip} % Remove paragraph indentation
\usepackage{array} % Required for boldface (\bf and \bfseries) tabular columns
\usepackage{ifthen} % Required for ifthenelse statements
\usepackage[left=0.75in,top=0.75in,right=0.75in,bottom=0.75in]{geometry}

\usepackage{etoolbox} % easier than ifthenelses
\newtoggle{cv} % create a toggle variable "cv"
\ifdefined \iscv % check if "iscv" was passed from the command line
\toggletrue{cv} % if so, compile the doc to a cv (more information)
\else \togglefalse{cv} \fi % if not, compile to a resume (less information)

\iftoggle{cv}{}{\pagestyle{empty}} % Suppress page numbers

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

% \printname is used to print the name as a page header
\def \printname {
  \iftoggle{cv}{
    \hfil\emph{\large Curriculum Vitae}\newline\newline\nameskip
    \hfil{\namesize\bf \@name}\newline
  }{
    \hfil{\namesize\bf \@name}\nameskip\newline
  }
}

% The below commands define the whitespace after certain things in the document
\def\namesize{\LARGE} % Size of the name at the top of the document
\def\addressskip{\smallskip} % The space between the two address (or phone/email) lines
\def\sectionlineskip{\medskip} % The space above the horizontal line for each section 
\def\nameskip{\bigskip} % The space after your name at the top
\def\sectionskip{\medskip} % The space after the heading section

% Print the header
\let\ori@document=\document
\renewcommand{\document}{
  \ori@document  % Begin document
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
  {\bf #1} % Section title
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
%	SUBSECTION FORMATTING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% bold on the left, normal on the right
\newcommand{\TwoTitle}[2]{{\bf#1}\hfill{\em#2}}

% bold on top left, normal on top right, emph on bottom
\newcommand{\FourTitle}[4] {
  \TwoTitle{#1}{#2} % same first line as above
  \ifthenelse{ % check before printing the third argument
  \equal{#3}{}}{}{\\{#3}\hfill{\em#4}}}

\newenvironment{rSubSection}[4]{ % 4 input arguments
  \FourTitle{#1}{#2}{#3}{#4}\smallskip
  \begin{list}{$\cdot$}{\leftmargin=0em} % \cdot used for bullets, no indentation
  \itemsep -0.5em \vspace{-0.75em} % Compress items in list together for aesthetics
}{
  \end{list}
  \vspace{0.5em} % Some space after the list of bullet points
}

% normal on the left, emph on the right
\newcommand{\Event}[2]{{#1}\hfill{\em#2}}
