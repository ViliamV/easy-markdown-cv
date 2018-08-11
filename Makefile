.PHONY: all
all: html pdf

.PHONY: html
html:
	pandoc -s --to=html5 \
		-o build/cv.html \
		source/*.md \
		--css=../style/all.min.css \
		--css=../style/normalize.css \
		--css=../style/style.css \
		--template=./style/template.html

.PHONY: pdf
pdf:
	wkhtmltopdf --print-media-type --orientation Portrait --page-size A4 --margin-top 15 --margin-left 15 --margin-right 15 --margin-bottom 15 build/cv.html build/cv.pdf
	# pandoc -s \
	# 	-o build/cv.pdf \
	# 	build/cv.html \
	# 	--css=./style/all.min.css \
	# 	--pdf-engine=wkhtmltopdf

clean:
	rm build/* -f
		--css=./source/style.css \
