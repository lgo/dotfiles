# Out-of-Store Symlinks

This repo intentionally uses `mkOutOfStoreSymlink` for many user config files.

Why:
- Changes made by apps outside Nix still land in git-tracked files.
- You keep declarative wiring in Nix while preserving direct editability of configs.

Rules:
- App configs should live under `tools/` unless they are exported macOS app assets (then `macos/`).
- Nix modules should reference only current paths (no legacy path aliases).
- If files are moved, update all module references in the same change.
