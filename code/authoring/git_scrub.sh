#!/bin/sh

# Copyright (c) 2024, Maciej Barć <xgqt@xgqt.org>

set -e
trap "exit 128" INT

script_path="${0}"
script_root="$(dirname "${script_path}")"

repo_root="$(realpath "${script_root}/..")"
cd "${repo_root}"

set -x

git gc --aggressive
git fsck --full
