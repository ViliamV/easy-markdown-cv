.PHONY: all
all: pdf bwpdf public

.PHONY: html
html:
	./build.sh html

.PHONY: debug
debug:
	./build.sh debug

.PHONY: pdf
pdf:
	./build.sh pdf

.PHONY: bwpdf
bwpdf:
	./build.sh bwpdf

.PHONY: public
public:
	./build.sh public

.PHONY: example
example:
	./build.sh examplebwpdf
	./build.sh example
	git add example_build/
	git commit -m "new example"
	git push
