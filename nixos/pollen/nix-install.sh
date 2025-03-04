#!/bin/bash

if ! command -v nix 2>&1 >/dev/null; then
  echo "Nix is already installed"
  exit 0
fi

curl -L https://nixos.org/nix/install | sh

mkdir -p ~/.config/nix

cat <<EOF > ~/.config/nix/nix.conf
experimental-features = nix-command flakes
EOF