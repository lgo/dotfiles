#!/bin/bash

cd ~/.config/
nix build --extra-experimental-features 'nix-command flakes'