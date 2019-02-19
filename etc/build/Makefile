build = ../../build
src = ../../src
webapp = $(src)/main/webapp


.PHONY: all
all:
	ant all

.PHONY: app
app:
	ant app

.PHONY: merge
merge: $(webapp)/cache.manifest
merge: $(webapp)/js/shapes.min.js
merge: $(webapp)/js/stencils.min.js
merge:
	ant merge

$(webapp)/cache.manifest: cache.txt
$(webapp)/cache.manifest:
	echo "\
	CACHE MANIFEST\n\
	\n\
	# THIS FILE WAS GENERATED. DO NOT MODIFY!\n\
	# $(shell date +'%Y/%m/%d/ %I:%M %p')\n\
	" > $@
	cat $^ >> $@

$(webapp)/js/shapes.min.js: $(shell find $(webapp)/shapes)
	java -jar compiler.jar \
		--compilation_level SIMPLE \
		--rewrite_polyfills false \
		--js_output_file $@ \
		$(sort $(shell find $(webapp)/shapes/ -type f -name "*.js"))

$(webapp)/js/stencils.min.js: Xml2Js.class
$(webapp)/js/stencils.min.js: $(shell find $(webapp)/stencils)
	java Xml2Js $(webapp)/stencils/ $@

.PHONY: javac
javac:
	ant javac

.PHONY: clean
clean:
	ant clean

.PHONY: war
war:
	ant war

$(build):
	mkdir -p $(build)

%.class: %.java
	javac $<
