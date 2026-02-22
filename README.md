# Dotfiles

This repository is managed with `nix-darwin` + Home Manager.

## Setup

```bash
git clone git@github.com:lgo/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

Build or switch with your `sprout` host:

```bash
darwin-rebuild build --flake ~/.dotfiles/nixos#sprout
sudo darwin-rebuild switch --flake ~/.dotfiles/nixos#sprout
```

Or use the helper script:

```bash
nixr build
nixr test
nixr switch
nixr install
```

Task runner shortcuts are also available:

```bash
task build-sprout
task flake-check
task smoke
task check
task benchmark-shell
```

CI runs in GitHub Actions (`.github/workflows/ci.yml`) and executes:
- `nix flake check ./nixos`
- `pre-commit run --all-files` (with darwin-only hook skipped)
- `./bin/smoke-test ci`

## Layout

At a high level, this repo is split into three layers:

1. Declarative system/user state in `nixos/` (nix-darwin + Home Manager).
2. Shared tool/app config assets under `tools/`, `zsh/`, and `templates/`.
3. Operator workflows and docs in `bin/`, `Taskfile.yml`, and `docs/`.

| Path | Includes | Purpose |
| --- | --- | --- |
| `nixos/` | Flake entrypoint, host wiring, nix-darwin + Home Manager modules | Source of truth for machine/user configuration |
| `nixos/hosts/` | Host profiles (currently `sprout`) | Per-host composition layer for shared modules |
| `nixos/modules/` | System modules (defaults, Homebrew, fonts, users, macOS settings) | OS-level policy and package ownership boundaries |
| `nixos/home/` | Home Manager packages, shell programs, editor/tool modules, session env/path | User-level CLI/editor/runtime setup |
| `nixos/files/` | Extra sourced shell/config snippets | Structured extensions for shell/runtime behavior |
| `tools/` | App configs (git, editors, tmux, k9s, hammerspoon, etc.) | Version-controlled tool settings, often symlinked out-of-store |
| `zsh/` | Base zsh environment/login files | Shell bootstrap inputs consumed by Home Manager |
| `bin/` | Utility scripts (`nixr`, setup helpers, validation scripts) | Operational commands for day-2 management |
| `Taskfile.yml` | Task targets (`build-sprout`, `check`, `benchmark-shell`, etc.) | Standardized local workflows |
| `templates/` | Reusable templates (for example direnv policy files) | Consistent project bootstrap patterns |
| `docs/` | Architecture, onboarding, and runbook docs | Human-facing references and procedures |

## Notes

- Many files are intentionally symlinked from `~/.dotfiles` so changes outside Nix still land in git-tracked files.
- Homebrew is managed through `nixos/modules/homebrew.nix`.

## Package Ownership

| Owner | Examples | Rationale |
| --- | --- | --- |
| Nix/Home Manager | `go-task`, `ruby`, `git`, `go`, `jq`, `atuin`, `zoxide`, `fd` | Reproducible versions, declarative upgrades, predictable shell behavior across rebuilds |
| Homebrew (intentionally retained) | `docker`, `postgresql`, `redis`, `openjdk`, `wireshark`, `yarn` | Better macOS integration, service lifecycle management, or native app ecosystem fit |
| Homebrew (remaining migration candidates) | `python@3.13`, `node`, `bfg`, `woof` | Pending migration/compatibility decisions or no clean nixpkgs replacement |

## Migration Policy

- Do not add references to legacy/moved paths in scripts, docs, or nix modules.
- Store user-managed application configuration under `tools/`.
- Keep `macos/` only for exported macOS app state/assets that are synced via Home Manager.

## Runbook

### Day-2 Commands

```bash
# Evaluate/build only (no activation)
nixr build

# Build + activation checks (no full switch)
nixr test

# Build + activate as current system generation
nixr switch

# First-time bootstrap on a fresh machine
nixr install
```

### Rollback

```bash
# Show available generations
darwin-rebuild --list-generations --flake ~/.dotfiles/nixos#sprout

# Roll back to previous generation
sudo darwin-rebuild switch --rollback --flake ~/.dotfiles/nixos#sprout

# Or switch to a specific generation number
sudo darwin-rebuild switch --switch-generation <GENERATION> --flake ~/.dotfiles/nixos#sprout
```

### Common Failure Modes

- Homebrew formulas removed/renamed:
  - symptom: `No available formula with the name ...`
  - action: remove or replace the formula in `nixos/modules/homebrew.nix`, then rerun `nixr build`.
- Homebrew module says brew is missing:
  - symptom: `Using the homebrew module requires homebrew installed`
  - action: verify `brew` exists at `/opt/homebrew/bin/brew` and `brewPrefix` in `nixos/modules/homebrew.nix` matches.
- Rosetta/arch mismatch while installing brew packages:
  - symptom: `Cannot install under Rosetta 2 in ARM default prefix (/opt/homebrew)!`
  - action: run brew under ARM (`arch -arm64`) and verify shell session architecture before rebuilding.
- Legacy deprecated `postgresql@14` warning from `brew doctor`:
  - symptom: `Some installed formulae are deprecated or disabled: postgresql@14`
  - action: if you no longer need v14 data, remove the old keg (`brew uninstall postgresql@14`), then keep `postgresql` managed via `nixos/modules/homebrew.nix`.
- `sudo` prompts during `switch`/`test`:
  - expected for activation steps; `build` is the no-sudo dry path for quick validation.
