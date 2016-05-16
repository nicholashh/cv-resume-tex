
name = "nicholas-hanson-holtry"

all: resume cv

resume:
	pdflatex -file-line-error \
		--jobname=$(name).resume "source.tex"

cv:
	pdflatex -file-line-error \
		--jobname=$(name).cv "\def\iscv{1} \input{source.tex}"

resume-open: resume
	open $(name).resume.pdf

cv-open: cv
	open $(name).cv.pdf

r: resume
ro: resume-open
cvo: cv-open

clean:
	rm $(name).resume.*
	rm $(name).cv.*
