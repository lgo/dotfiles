#!/usr/bin/env bash

# Attempt to load 'code' or raise an error if VS Code is not installed.
source $(dirname $0)/_lib.sh

if [[ ! -f "$(dirname $0)/extensions.bak" ]]; then
  echo "No 'extensions.bak' file found with extensions to install. Please use backup-extensions.sh to created one."
  exit 1
fi

cat $(dirname $0)/extensions.bak | xargs -n1 code --install-extension

echo "successfully installed vscode extensions"
