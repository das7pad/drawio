build = ../../build
src = ../../src
webapp = $(src)/main/webapp
styles = $(webapp)/styles
sidebar = $(webapp)/js/diagramly/sidebar

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
app: $(build)/init-viewer.min.js
app: $(build)/sidebar.min.js
app: $(build)/default.min.xml
app: $(build)/dark-default.min.xml
app: $(build)/dia.txt
app:
	ant app

$(build)/%.min.js: %.js
	mkdir -p $(build)
	$(jscompile) \
		--js_output_file $@ \
		$<

$(build)/sidebar.min.js: $(shell find $(sidebar))
	$(jscompile) \
		--js_output_file $@ \
		$(sort $(wildcard $(sidebar)/*.js))

$(build)/%.min.xml: $(styles)/%.xml
	tr --delete '\n' < $< | sed "s/'/\\\\'/g;s/\t//g;" > $@

$(build)/dia.txt: $(webapp)/resources/dia.txt
	tr '\n' '\v' < $< | sed "s/\v/\\\\n/g;s/'/\\\\'/g;" > $@

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

%.class: %.java
	javac $<
