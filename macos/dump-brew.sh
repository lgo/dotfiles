#!/usr/bin/env bash

# If brew is not found, install it.
if ! type brew &>/dev/null; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

rm $(dirname $0)/Brewfile
brew bundle dump --file=$(dirname $0)/Brewfile