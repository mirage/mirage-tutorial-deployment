#!/usr/bin/env bash
#
# Copyright (c) 2015 Richard Mortier <mort@cantab.net>. All Rights Reserved.
# Copyright (c) 2015 Thomas Gazagnaire <thomas@gazagnaire.org>.
#
# Permission to use, copy, modify, and distribute this software for any purpose
# with or without fee is hereby granted, provided that the above copyright
# notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
# REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
# AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
# INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
# LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.

set -eu

if [ "$#" -ge 3 ]; then
    echo "usage: $(basename "$0") SITENAME VMNAME [DISK]"
    exit 1
fi

NAME=$1
VM=$2

if [ "$#" -eq 2 ]; then DISK=""; else DISK=$3; fi

ROOT=$(git rev-parse --show-toplevel)
KERNEL=$ROOT/xen/$(cat "$ROOT/xen/latest")

cd "$ROOT"

sed -e "s,@NAME@,$NAME,g; s,@KERNEL@,$KERNEL/$VM.xen,g; s:@DISK@:$DISK:g" \
    < xl.conf.in \
    >| "$KERNEL/$VM.xl"
