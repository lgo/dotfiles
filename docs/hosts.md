# Hosts

Host profile model:
- Shared modules live under `nixos/modules/` and `nixos/home/`.
- Per-host composition lives under `nixos/hosts/<host>/default.nix`.

Active host:
- `sprout` (`aarch64-darwin`) via `nixos/hosts/sprout/default.nix`.

Operational notes:
- Standard commands target `sprout` via `nixr` or explicit `--flake ~/.dotfiles/nixos#sprout`.
- Add new hosts by creating `nixos/hosts/<host>/default.nix` and a matching `darwinConfigurations.<host>` output in `nixos/flake.nix`.
