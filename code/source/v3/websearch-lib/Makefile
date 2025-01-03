EMACS                   := emacs
FIND                    := find
RM                      := rm -f -r

PWD                     := $(shell pwd)

SRCDIR                  := $(PWD)/src/main/elisp
TESTSDIR                := $(PWD)/src/test/elisp

CACHEDIR                := $(PWD)/.cache
IDIR                    := $(CACHEDIR)/image
BINIDR                  := $(IDIR)/usr/bin
EMACSIDIR               := $(IDIR)/usr/share/emacs/site-lisp

EMACSFLAGS              := --batch -q --no-site-file
EMACSCMD                 = $(EMACS) $(EMACSFLAGS)
TESTFLAGS               := -L $(PWD) --traceback full

.PHONY: all
all:
	$(MAKE) clean
	$(MAKE) compile

clean-%:
	$(FIND) $(SRCDIR)/$(*) -iname "*.elc" -delete

.PHONY: clean
clean:
	$(MAKE) clean-websearch
	if [ -d $(CACHEDIR) ] ; then $(RM) $(CACHEDIR) ; fi

compile-%:
	$(EMACSCMD) --directory $(SRCDIR)/$(*) \
		--eval "(byte-recompile-directory \"$(SRCDIR)/$(*)\" 0)"

.PHONY: compile
compile:
	$(MAKE) compile-websearch

.PHONY: test
test:
	$(EMACSCMD) -L $(SRCDIR)/websearch -L $(TESTSDIR)/websearch \
		-l $(TESTSDIR)/websearch/websearch-macro-test.el \
		-f ert-run-tests-batch-and-exit

install-%: compile-%
	$(EMACSCMD) --eval "(require 'package)" \
		--eval "(package-install-file \"$(SRCDIR)/$(*)\")"

.PHONY: install
install:
	$(MAKE) install-websearch
