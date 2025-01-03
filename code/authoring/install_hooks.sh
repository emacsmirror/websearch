#!/bin/sh

# Copyright (c) 2024, Maciej Barć <xgqt@xgqt.org>

set -e
trap "exit 128" INT

set -x

pre-commit install --install-hooks
pre-commit install --hook-type commit-msg
