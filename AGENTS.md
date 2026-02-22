# Working with these dotfiles

## High-level facts

- This repo is managed with `nix-darwin` + Home Manager.
- Active host is `sprout` (`aarch64-darwin`).
- Host composition lives in `nixos/hosts/sprout/default.nix`.
- Shared system modules are in `nixos/modules/`; user modules are in `nixos/home/`.
- Many app configs are out-of-store symlinks to files under `tools/`.

## Commands to use

- Build (required validation for Nix changes):
  - `darwin-rebuild build --flake ./nixos#sprout`
- Switch/apply:
  - `darwin-rebuild switch --flake ./nixos#sprout`
- Flake checks:
  - `nix flake check ./nixos`
- Task shortcuts:
  - `task build-sprout`
  - `task flake-check`
  - `task smoke`
  - `task check`
- Smoke test directly:
  - `./bin/smoke-test local`

## Change workflow rules

- When adding files, stage with `git add .`.
- If `git add .` would stage unrelated files you did not create, ask the user before proceeding.
- After Nix changes, always run `darwin-rebuild build --flake ./nixos#sprout`.
- If build fails only because new files are untracked, stage them and rerun.
- Ignore and do not mention the expected "uncommitted changes" warning from Nix commands.

## Useful repository specifics

- CI config is `.github/workflows/ci.yml`.
- Pre-commit config is `.pre-commit-config.yaml` (includes `gitleaks`).
- `darwin-rebuild` pre-commit hook is macOS-only; CI skips it.
- Homebrew ownership boundaries are documented in `docs/homebrew-boundaries.md`.
- Use `nix-os` MCP to confirm package names/options before adding Nix settings.
