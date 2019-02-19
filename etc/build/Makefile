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
