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
	git add example_build/
	git commit -m "new example"
	git push

.PHONY: update
update:
	./build.sh pdf
	./build.sh public
	./build.sh example
	git add .
	git commit -m "update"
	cd src/
	git add .
	git commit -m "update"
	cd ../build
	git add .
	git commit -m "update"

