PWD         ?= $(shell pwd)

EMACS       := emacs
FIND        := find

EMACFLAGS   := --batch -q --no-site-file -L $(PWD)
EMACSCMD     = $(EMACS) $(EMACFLAGS)


.PHONY: all
all: clean compile


.PHONY: clean
clean:
	$(FIND) $(PWD) -iname "*.elc" -delete


%.elc:
	$(EMACSCMD) --eval "(byte-compile-file \"$(*).el\" 0)"

.PHONY: compile
compile: websearch.elc websearch-custom.elc websearch-mode.elc


.PHONY: install
install: compile
	$(EMACSCMD) \
		--eval "(require 'package)" \
		--eval "(package-install-file \"$(PWD)\")"
