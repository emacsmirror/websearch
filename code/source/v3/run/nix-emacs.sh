#!/bin/sh

# Copyright (c) 2024, Maciej Barć <xgqt@xgqt.org>

trap "exit 128" INT
set -e
set -u

script_path="${0}"
script_root="$(dirname "${script_path}")"

source_root="$(realpath "${script_root}/..")"
cd "${source_root}"

exec nix-shell --command \
     "cd '${source_root}/websearch-lib'; '${source_root}/3rd-party/bin/eldev' emacs"
