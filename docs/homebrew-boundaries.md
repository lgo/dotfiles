# Homebrew Boundaries

Homebrew is managed through `nixos/modules/homebrew.nix`.

## Ownership Table

| Owner | Package set | Rationale |
| --- | --- | --- |
| Nix/Home Manager | Core CLI and shell tooling (`ruby`, `go-task`, `git`, `go`, `jq`, `atuin`, `zoxide`, `fd`, etc.) | Reproducibility, deterministic rebuilds, and less PATH drift |
| Homebrew (`mustStayBrewBrews`) | `openjdk`, `awscli`, `bash`, `docker`, `postgresql`, `redis`, `wireshark`, `yarn`, `zsh` | macOS integration, service management, or practical ecosystem fit |
| Homebrew (`migrateToNixBrews`) | `python@3.13`, `node`, `bfg`, `woof` | Remaining migration candidates or formulas without a clear Nix replacement/workflow |

Prefix and architecture:
- Brew prefix is configured as `/opt/homebrew/bin`.
- Run brew commands under native ARM when using `/opt/homebrew`.

Operational guidance:
- Keep formula/cask changes in `nixos/modules/homebrew.nix`.
- If a formula is removed upstream, replace or remove it in the module before rebuilding.
