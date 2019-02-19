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

$(build)/shapes.js: $(build)
$(build)/shapes.js: $(shell find $(webapp)/shapes)
	cat $(sort $(shell find $(webapp)/shapes/ -type f -name "*.js")) > $@

$(webapp)/js/shapes.min.js: $(build)/shapes.js
	java -jar compiler.jar \
		--compilation_level SIMPLE \
		--rewrite_polyfills false \
		--js_output_file $@ \
		$(build)/shapes.js

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
