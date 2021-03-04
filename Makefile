.PHONY: all
all:
	./run pdf pdfprint pdfbw public

.PHONY: html
html:
	./run html

.PHONY: debug
debug:
	./run debug

.PHONY: pdf
pdf:
	./run pdf pdfbw pdfprint

.PHONY: public
public:
	./run public

.PHONY: example
example:
	@OUTPUT=example_output SOURCE=example ./run pdfbw pdf public jpg
	./mkdocs
