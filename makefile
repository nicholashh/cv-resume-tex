
name = "nicholas-hanson-holtry"

all: cv resume

cv:
	xelatex -file-line-error \
	--jobname=$(name).cv \
	"\def\iscv{1} \input{source.tex}"

resume:
	xelatex -file-line-error \
	--jobname=$(name).resume \
	"\input{source.tex}"

resume-programming:
	xelatex -file-line-error \
	--jobname=$(name).resume.programming-focus \
	"\def\programming{1} \input{source.tex}"

r: resume
rp: resume-programming

cv-open: cv
	open $(name).cv.pdf
resume-open: resume
	open $(name).resume.pdf
resume-programming-open: resume-programming
	open $(name).resume.programming-focus.pdf

cvo: cv-open
ro: resume-open
rpo: resume-programming-open

clean:
	rm $(name).cv.*
	rm $(name).resume.*
	rm $(name).resume.programming-focus.*
