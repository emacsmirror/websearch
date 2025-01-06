# Copyright (c) 2022-2025, Maciej Barć <xgqt@xgqt.org>

PWD             := $(shell pwd)

SOURCE          := $(PWD)/..
3RD-PARTY       := $(SOURCE)/3rd-party
3RD-PARTY-BIN    = $(3RD-PARTY)/bin

CACHE           := $(PWD)/.cache
PACKAGE-OUT     := $(CACHE)/package

include         ../make/tools.mklib

ELDEV-LOCAL      = $(shell $(REALPATH) $(3RD-PARTY)/eldev)
ELDEV-CMD        = ELDEV_LOCAL="$(ELDEV-LOCAL)" $(ELDEV) --verbose
ELDEV-OPTS      := --force-all --load-before-compiling
VERSION          = $(shell $(CAT) "$(PWD)/../VERSION")

.PHONY: all
all:
	$(MAKE) clean
	$(MAKE) build

.PHONY: clean
clean:
	$(ELDEV-CMD) clean
	$(RM) $(PWD)/.eldev

.PHONY: build
build:
	$(ELDEV-CMD) compile $(ELDEV-CMD-OPTS)
	$(ELDEV-CMD) build   $(ELDEV-CMD-OPTS)
	$(ELDEV-CMD) package $(ELDEV-CMD-OPTS) --entry-file --output-dir="$(PACKAGE-OUT)"

.PHONY: _doctor
_doctor:
	$(ELDEV-CMD) doctor --all-tests

.PHONY: _test-coverage
_test-coverage:
	$(ELDEV-CMD) test \
		--runner="standard" --undercover="always,text,dontsend" \
		--undercover-report "$(CACHE)/coverage/undercover-report.text"
	$(CAT) "$(CACHE)/coverage/undercover-report.text"

.PHONY: test
install: build
test:
	-$(MAKE) _doctor
	$(MAKE) _test-coverage

.PHONY: install
install: build
install:
	$(EMACS) \
		--batch -q --no-site-file \
		--eval "(progn (require 'package) (package-refresh-contents))" \
		--eval "(package-install-file \"$(PACKAGE-OUT)/el-fetch-$(VERSION).tar\")"

.PHONY: uninstall
uninstall:
	$(FIND) ~/.config/emacs/elpa -type d -name "el-fetch-*" -exec $(RM) {} +

.PHONY: reinstall
reinstall:
	$(MAKE) uninstall
	$(MAKE) install
