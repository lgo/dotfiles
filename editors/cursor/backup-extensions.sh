#!/usr/bin/env bash
#
# Backs up installed Cursor extensions into the list.

# Attempt to load 'cursor' or raise an error if Cursor is not installed.
source $(dirname $0)/_lib.sh

cursor --list-extensions > $(dirname $0)/extensions.bak

echo "successfully created cursor extensions backup list"
