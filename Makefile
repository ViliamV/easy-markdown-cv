.PHONY: all
all: pdf public

.PHONY: html
html:
	./build.sh html

.PHONY: debug
debug:
	./build.sh debug

.PHONY: pdf
pdf:
	./build.sh pdf

.PHONY: public
public:
	./build.sh public

.PHONY: example
example:
	./build.sh example

clean:
	rm build/* -f
