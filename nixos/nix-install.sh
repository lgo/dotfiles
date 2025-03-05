#!/bin/bash

if ! command -v nix 2>&1 >/dev/null; then
  echo "Nix is already installed"
  exit 0
fi

nix run nix-darwin/nix-darwin-24.11#darwin-rebuild --extra-experimental-features nix-command --extra-experimental-features flakes -- --flake ~/.dotfiles/nixos/# switch

darwin-rebuild --flake ~/.dotfiles/nixos/# switch