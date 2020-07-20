.PHONY: all
all: pdf pdfcolor pdfbw public

.PHONY: html
html:
	@OUTPUT=output/html ./run html

.PHONY: debug
debug:
	@OUTPUT=output/debug ./run debug

.PHONY: pdf
pdf:
	@OUTPUT=output/pdf ./run pdf

.PHONY: pdfbw
pdfbw:
	@OUTPUT=output/pdf ./run pdfbw

.PHONY: pdfcolor
pdfcolor:
	@OUTPUT=output/pdf ./run pdfcolor

.PHONY: public
public:
	@OUTPUT=output/public ./run public

.PHONY: example
example:
	@OUTPUT=example_output SOURCE=example ./run pdfbw
	@OUTPUT=example_output SOURCE=example ./run pdf
	@OUTPUT=example_output SOURCE=example ./run public
