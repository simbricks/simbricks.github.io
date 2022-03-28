PAGES= index publications community

ALL_PAGES= $(addsuffix .html,$(PAGES))

TEMPLATE= _templates/site.html
TEMPLATE_BUILT= build/site_withcss.html
SASS= sassc -t compressed

all: $(ALL_PAGES)

clean:
	rm -rf build $(ALL_PAGES)

build/main.css: _templates/main.scss
	@mkdir -p $(dir $@)
	$(SASS) $< >$@

$(TEMPLATE_BUILT): $(TEMPLATE) build/main.css
	@mkdir -p $(dir $@)
	sed -e '/CSS_PLACEHOLDER/ {' -e 'r build/main.css' -e 'd' -e '}' <$< >$@

%.html: _pages/%.html $(TEMPLATE_BUILT)
	@mkdir -p $(dir $@)
	sed -e 's/<<<$(notdir $(basename $<))-\([^>]*\)>>>/\1/g' \
	    $(TEMPLATE_BUILT) | \
	  sed -e 's/<<<[a-zA-Z0-9_]*-\([^>]*\)>>>//g' | \
	  sed \
	    -e '/CONTENT_PLACEHOLDER/ {' -e 'r $<' -e 'd' -e '}' \
	    >$@
