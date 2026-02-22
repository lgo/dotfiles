# Architecture

This repo is managed with `nix-darwin` + Home Manager.

Core structure:
- `nixos/flake.nix`: top-level flake outputs.
- `nixos/hosts/`: per-host composition modules (`sprout`, future hosts).
- `nixos/modules/`: system-level modules (OS defaults, apps, users, Homebrew, fonts).
- `nixos/home/`: user-level Home Manager modules (shell, editors, git, tmux, paths, session).
- `tools/`: user-managed app configs symlinked into `$HOME`.
- `zsh/`: shell snippets sourced by Home Manager zsh configuration.
- `macos/`: exported macOS app state/assets (also symlinked).
- `bin/`: scripts available on PATH.

Design intent:
- Keep declarative machine setup in Nix modules.
- Keep mutable app/user config in git-tracked dotfiles via out-of-store symlinks.
