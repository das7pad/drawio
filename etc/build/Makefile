build = ../../build
src = ../../src
webapp = $(src)/main/webapp

jscompile = java \
	-jar compiler.jar \
	--compilation_level SIMPLE \
	--rewrite_polyfills false


.PHONY: all
all: app
all:
	ant all

.PHONY: app
app: merge
app: $(build)/constants.min.js
app:
	ant app

$(build)/constants.min.js: constants.js
	$(jscompile) \
		--js_output_file $@ \
		$<

.PHONY: merge
merge: $(webapp)/cache.manifest
merge: $(webapp)/js/shapes.min.js
merge: $(webapp)/js/stencils.min.js
merge:
	ant merge

$(webapp)/cache.manifest: cache.manifest.in
$(webapp)/cache.manifest:
	sed "s#%%DATE%%#$(shell date +'%m/%d/%Y %I:%M %p')#" $< > $@

$(webapp)/js/shapes.min.js: $(shell find $(webapp)/shapes)
	$(jscompile) \
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
war: app
war: javac
war:
	ant war

$(build):
	mkdir -p $(build)

%.class: %.java
	javac $<
