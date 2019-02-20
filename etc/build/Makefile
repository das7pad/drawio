build = ../../build
src = ../../src
webapp = $(src)/main/webapp
styles = $(webapp)/styles
sidebar = $(webapp)/js/diagramly/sidebar
grapheditor = $(webapp)/js/mxgraph

GRAPHEDITOR_FILES = $(filter-out \
	$(grapheditor)/Init.js,$(wildcard $(grapheditor)/*.js))

jscompile = java \
	-jar compiler.jar \
	--charset UTF-8 \
	--compilation_level SIMPLE \
	--rewrite_polyfills false

jscompile_prerequisites = $(jscompile) \
	--js_output_file $@ \
	$(sort $(filter %.js,$^))


.PHONY: all
all: app
all:
	ant all

.PHONY: app
app: merge
app: $(build)/client.min.js
app: $(build)/constants.min.js
app: $(build)/Graph-Resources.js
app: $(build)/Graph-Stylesheet.js
app: $(build)/grapheditor.min.js
app: $(build)/init-viewer.min.js
app: $(build)/sidebar.min.js
app: $(build)/default.min.xml
app: $(build)/dark-default.min.xml
app: $(build)/dia.txt
app:
	ant app

$(build)/%.min.js: %.js
	mkdir -p $(build)
	$(jscompile_prerequisites)

$(build)/client.min.js: ../mxgraph/mxClient.js
$(build)/client.min.js: $(grapheditor)/Init.js
$(build)/client.min.js: $(webapp)/js/deflate/base64.js
$(build)/client.min.js: $(webapp)/js/diagramly/Init.js
$(build)/client.min.js: $(webapp)/js/jscolor/jscolor.js
	$(jscompile_prerequisites)

$(build)/Graph-Resources.js: Graph-Resources.in.js
$(build)/Graph-Resources.js: $(build)/dia.txt
	sed "s^%dia%^`sed 's/\\\\/\\\\\\\\/g;s/\\&/\\\\&/g' $(build)/dia.txt`^" \
		Graph-Resources.in.js \
		> $@

$(build)/Graph-Stylesheet.js: Graph-Stylesheet.in.js
$(build)/Graph-Stylesheet.js: $(build)/default.min.xml
$(build)/Graph-Stylesheet.js: $(build)/dark-default.min.xml
	cp Graph-Stylesheet.in.js $@
	for file in default dark-default; do \
		sed -i "s^%$$file%^`cat $(build)/$$file.min.xml`^" $@; \
	done

$(build)/grapheditor.min.js: $(grapheditor)
$(build)/grapheditor.min.js: $(GRAPHEDITOR_FILES)
	$(jscompile_prerequisites)

$(build)/sidebar.min.js: $(shell find $(sidebar))
	$(jscompile_prerequisites)

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
	$(jscompile_prerequisites)

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
