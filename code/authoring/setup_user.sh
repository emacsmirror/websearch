#!/bin/sh

# Copyright (c) 2024, Maciej Barć <xgqt@xgqt.org>

set -e
trap "exit 128" INT

if [ -z "${2}" ] ; then
    echo " Please provide a e-mail address and a user's real name (quoted)."

    exit 1
fi

set -x

user_email="${1}"
user_name="${2}"

git config --local user.email "${user_email}"
git config --local user.signingkey "${user_email}"
git config --local user.name "${user_name}"
