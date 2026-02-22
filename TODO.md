# Dotfiles Migration TODO (Legacy -> Nix)

## 1. General Improvements

- Add macOS CI coverage for `darwin-rebuild build --flake ./nixos#sprout`.

## 3. Cleanup

- Keep reducing Homebrew footprint by moving suitable CLI tooling to nixpkgs.

## 6. Research-Backed Enhancements

- Atuin durability: evaluate encrypted history sync setup and backup/recovery procedure (`atuin key` handling) for multi-machine workflow.
- WezTerm workflow: adopt shell integration + CLI/workspace workflows (pane/tab/session controls) and codify your preferred key table in dotfiles.
- Pre-commit CI: evaluate adding `pre-commit.ci` so hook autofixes and hook version autoupdates run automatically on PRs.
- Drift prevention: add a small CI check that fails on references to removed legacy paths (regex scan), so migrations don’t regress.
