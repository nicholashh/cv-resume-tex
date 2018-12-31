
name = "nicholas-hanson-holtry"

all: resume cv card

resume:
	xelatex -file-line-error \
	--jobname=$(name).resume \
	"\input{cv.tex}"
r: resume

cv:
	xelatex -file-line-error \
	--jobname=$(name).cv \
	"\def\iscv{1} \input{cv.tex}"

card:
	xelatex -file-line-error \
	--jobname=$(name) \
	"\input{card.tex}"

resume-open: r
	open $(name).resume.pdf
cv-open: cv
	open $(name).cv.pdf
card-open: card
	open $(name).pdf

ro: resume-open
cvo: cv-open
co: card-open

clean:
	rm $(name).*
