# Copyright (c) 2022-2025, Maciej Barć <xgqt@xgqt.org>

PWD              = $(shell pwd)

3RD-PARTY       := $(PWD)/3rd-party
3RD-PARTY-BIN   := $(3RD-PARTY)/bin

include         ./make/tools.mklib

.PHONY: all
all:
	$(MAKE) clean
	$(MAKE) build

.PHONY: clean
clean:
	$(MAKE) -C websearch-lib clean

.PHONY: build
build:
	$(MAKE) -C websearch-lib build

.PHONY: test
test:
	$(MAKE) -C websearch-lib test

.PHONY: install
install:
	$(MAKE) -C websearch-lib install

.PHONY: uninstall
uninstall:
	$(MAKE) -C websearch-lib uninstall

.PHONY: reinstall
reinstall:
	$(MAKE) uninstall
	$(MAKE) install

.PHONY: pre-commit
pre-commit:
	$(PRE-COMMIT) run --files \
		$$($(FIND) $(PWD) -type f -not -path "$(3RD-PARTY)/*")
