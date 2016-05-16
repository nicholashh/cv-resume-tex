
all: resume cv

resume:
	pdflatex -file-line-error --jobname=nicholashh.resume nicholashh.tex
	open nicholashh.resume.pdf

cv:
	pdflatex -file-line-error --jobname=nicholashh.cv "\def\iscv{1} \input{nicholashh.tex}"
	open nicholashh.cv.pdf

clean:
	rm nicholashh.resume.*
	rm nicholashh.cv.*
