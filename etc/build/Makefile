build = ../../build
src = ../../src
webapp = $(src)/main/webapp
styles = $(webapp)/styles
sidebar = $(webapp)/js/diagramly/sidebar
grapheditor = $(webapp)/js/mxgraph
version = ../../VERSION

GRAPHEDITOR_FILES = $(filter-out \
	$(grapheditor)/Init.js,$(wildcard $(grapheditor)/*.js))

VIEWER_FILES_MXGRAPH = $(addprefix $(grapheditor)/,\
	Editor.js \
	Actions.js  \
	EditorUi.js \
	Graph.js \
	Shapes.js \
)

VIEWER_FILES_DIAGRAMLY = $(addprefix $(webapp)/js/diagramly/,\
	DrawioFile.js \
	Editor.js \
	EditorUi.js \
	GraphViewer.js  \
	LocalFile.js \
	Minimal.js \
	Pages.js \
	Trees.js \
)

EXTENSIONS_FILES = $(addprefix $(webapp)/js/diagramly/,\
	Extensions.js \
	graphml/mxGraphMlCodec.js \
	vsdx/VsdxExport.js \
	vsdx/bmpDecoder.js \
	vsdx/importer.js \
	vsdx/mxVsdxCanvas2D.js \
)

APP_FILES_DIAGRAMLY = $(addprefix $(webapp)/js/diagramly/,\
	App.js \
	Dialogs.js \
	DistanceGuides.js  \
	Editor.js \
	EditorUi.js \
	Menus.js \
	Minimal.js \
	Pages.js \
	Trees.js \
	\
	DrawioFile.js \
	DiffSync.js \
	DrawioFileSync.js  \
	LocalFile.js \
	LocalLibrary.js \
	Settings.js \
	StorageFile.js \
	StorageLibrary.js \
	UrlLibrary.js \
	\
	DrawioClient.js \
	DrawioUser.js \
	DriveClient.js \
	DriveFile.js \
	DriveLibrary.js \
	DropboxClient.js \
	DropboxFile.js \
	DropboxLibrary.js \
	GitHubClient.js \
	GitHubFile.js \
	GitHubLibrary.js \
	OneDriveClient.js \
	OneDriveFile.js \
	OneDriveLibrary.js \
	TrelloClient.js  \
	TrelloFile.js \
	TrelloLibrary.js \
	\
	util/mxAsyncCanvas.js \
	util/mxJsCanvas.js \
)

jscompile = java \
	-jar compiler.jar \
	--charset UTF-8 \
	--compilation_level SIMPLE \
	--rewrite_polyfills false

# drop the version file from the prerequisites
prerequisites = $(filter-out $(version),$^)

jscompile_prerequisites = $(jscompile) \
	--js_output_file $@ \
	$(sort $(filter %.js,$(prerequisites)))

concat_prerequisites = cat $(sort $(prerequisites)) > $@

insert_version = sed -i s/@DRAWIO-VERSION@/$(shell cat $(version))/g $@


.PHONY: all
all: app
all:

.PHONY: app
app: merge
app: $(webapp)/js/app.min.js
app: $(webapp)/js/extensions.min.js
app: $(webapp)/js/viewer.min.js
app:

$(build)/%.min.js: %.js
	mkdir -p $(build)
	$(jscompile_prerequisites)

$(build)/app.in.min.js: $(APP_FILES_DIAGRAMLY)
$(build)/app.in.min.js: $(build)/Graph-Stylesheet.js
	$(jscompile_prerequisites)

$(webapp)/js/app.min.js: $(build)/app.in.min.js
$(webapp)/js/app.min.js: $(build)/client.min.js
$(webapp)/js/app.min.js: $(build)/grapheditor.min.js
$(webapp)/js/app.min.js: $(build)/sidebar.min.js
$(webapp)/js/app.min.js: $(webapp)/js/cryptojs/aes.min.js
$(webapp)/js/app.min.js: $(webapp)/js/deflate/pako.min.js
$(webapp)/js/app.min.js: $(webapp)/js/sanitizer/sanitizer.min.js
$(webapp)/js/app.min.js: $(webapp)/js/spin/spin.min.js
	$(concat_prerequisites)
	$(insert_version)

$(build)/base-viewer.min.js: $(VIEWER_FILES_MXGRAPH)
$(build)/base-viewer.min.js: $(VIEWER_FILES_DIAGRAMLY)
$(build)/base-viewer.min.js: $(build)/Graph-Resources.js
$(build)/base-viewer.min.js: $(build)/Graph-Stylesheet.js
	$(jscompile_prerequisites)

$(webapp)/js/viewer.min.js: $(build)/base-viewer.min.js
$(webapp)/js/viewer.min.js: $(build)/client.min.js
$(webapp)/js/viewer.min.js: $(build)/constants.min.js
$(webapp)/js/viewer.min.js: $(build)/init-viewer.min.js
$(webapp)/js/viewer.min.js: $(webapp)/js/spin/spin.min.js
$(webapp)/js/viewer.min.js: $(webapp)/js/sanitizer/sanitizer.min.js
$(webapp)/js/viewer.min.js: $(webapp)/js/deflate/pako.min.js
	$(concat_prerequisites)

$(build)/client.min.js: ../mxgraph/mxClient.js
$(build)/client.min.js: $(grapheditor)/Init.js
$(build)/client.min.js: $(webapp)/js/deflate/base64.js
$(build)/client.min.js: $(webapp)/js/diagramly/Init.js
$(build)/client.min.js: $(webapp)/js/jscolor/jscolor.js
	$(jscompile_prerequisites)

$(build)/extensions.in.min.js: $(EXTENSIONS_FILES)
	$(jscompile_prerequisites)

$(webapp)/js/extensions.min.js: $(build)/extensions.in.min.js
$(webapp)/js/extensions.min.js: $(webapp)/js/jszip/jszip.min.js
	$(concat_prerequisites)

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
