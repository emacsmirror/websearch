PWD         ?= $(shell pwd)
TESTS        = $(PWD)/tests

ELS          = $(wildcard $(PWD)/*.el)
ELCS         = $(ELS:.el=.elc)

EMACS       := emacs
RM          := rm -f

EMACFLAGS   := --batch -q --no-site-file -L $(PWD)
EMACSCMD     = $(EMACS) $(EMACFLAGS)


.PHONY: all
all: clean compile

.PHONY: clean
clean:
	$(RM) $(ELCS)

%.elc:
	$(EMACSCMD) --eval "(byte-compile-file \"$(*).el\" 0)"

.PHONY: compile
compile: $(ELCS)

.PHONY: install
install: compile
install:
	$(EMACSCMD)										\
		--eval "(require 'package)"					\
		--eval "(package-install-file \"$(PWD)\")"

.PHONY: test
test:
	$(EMACSCMD)									\
		-L $(TESTS)								\
		-l $(TESTS)/websearch-macro-test.el		\
		-f ert-run-tests-batch-and-exit
