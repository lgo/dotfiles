#!/bin/bash

set -e

if [[ ! -d "$DOTFILES/.antidote" ]]; then
  git clone --depth=1 https://github.com/mattmc3/antidote.git "$DOTFILES/.antidote"
fi