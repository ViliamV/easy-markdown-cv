dir = src

.PHONY: all
all: html pdf

.PHONY: html
html:
	pandoc -s --to=html5 \
		-o build/cv.html \
		src/*.md \
		--css=../css/all.min.css \
		--css=../css/normalize.css \
		--css=../css/style.css \
		--template=./template/template.html

.PHONY: debug
debug:
	pandoc -s --to=html5 \
		-o build/cv.html \
		src/*.md \
		--css=../css/debug.css \
		--css=../css/all.min.css \
		--css=../css/normalize.css \
		--css=../css/style.css \
		--template=./template/template.html


.PHONY: pdf
pdf:
	wkhtmltopdf --print-media-type --orientation Portrait --page-size A4 --margin-top 0 --margin-left 15 --margin-right 15 --margin-bottom 15 build/cv.html build/cv.pdf
	wkhtmltopdf \
		--print-media-type \
		--orientation Portrait \
		--page-size A4 \
		--margin-top 0 \
		--margin-left 15 \
		--margin-right 15 \
		--margin-bottom 15 \
		build/cv.html \
		build/cv.pdf

.PHONY: example
example:
	pandoc -s --to=html5 \
		-o cv.html \
		example/*.md \
		--css=./css/all.min.css \
		--css=./css/normalize.css \
		--css=./css/style.css \
		--template=./template/template.html
	wkhtmltopdf \
		--print-media-type \
		--orientation Portrait \
		--page-size A4 \
		--margin-top 0 \
		--margin-left 15 \
		--margin-right 15 \
		--margin-bottom 15 \
		cv.html \
		cv.pdf

clean:
	rm build/* -f
