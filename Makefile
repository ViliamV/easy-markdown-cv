.PHONY: all
all: pdf pdfcolor pdfbw public

.PHONY: html
html:
	@export CV_OUTPUT output/html
	./run html

.PHONY: debug
debug:
	@export CV_OUTPUT output/debug
	run debug

.PHONY: pdf
pdf:
	@export CV_OUTPUT output/pdf
	run pdf

.PHONY: pdfbw
pdfbw:
	@export CV_OUTPUT output/pdf
	run pdfbw

.PHONY: pdfcolor
pdfcolor:
	@export CV_OUTPUT output/pdf
	run pdfcolor

.PHONY: public
public:
	@export CV_OUTPUT output/public
	run public

# .PHONY: example
# example:
# 	./build.sh examplebwpdf
# 	./build.sh example
# 	git add example_build/
# 	git commit -m "new example"
# 	git push
