.PHONY: all
all: pdf

.PHONY: html
html:
	./build.sh html

.PHONY: debug
debug:
	./build.sh debug

.PHONY: pdf
pdf:
	./build.sh pdf

.PHONY: example
example:
	./build.sh example

clean:
	rm build/* -f
