#!/usr/bin/env bash
#
# Backs up installed VSCode extensions into the list.

# Attempt to load 'code' or raise an error if VS Code is not installed.
source $(dirname $0)/_lib.sh

code --list-extensions > $(dirname $0)/extensions.bak

echo "successfully created vscode extensions backup list"
