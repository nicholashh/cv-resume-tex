
all: resume cv

resume:
	pdflatex -file-line-error --jobname=nbhh_resume nicholashh.tex
	open nbhh_resume.pdf

cv:
	pdflatex -file-line-error --jobname=nbhh_cv "\def\iscv{1} \input{nicholashh.tex}"
	open nbhh_cv.pdf

clean:
	rm nbhh_resume.*
	rm nbhh_cv.*
