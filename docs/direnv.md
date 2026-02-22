# Direnv

Direnv loads environment variables automatically when you `cd` into a directory.
This repo enables `direnv` with `nix-direnv` (fast `use flake` support) via Home Manager.

## Recommended `.envrc` For Flakes

Create a `.envrc` in your project root:

```bash
use flake
```

Then allow it once:

```bash
direnv allow
```

Notes:
- If the flake is slow, consider using a smaller `devShell` and keep heavy tooling out of `shellHook`.

## Secret Policy Template

Use these templates when bootstrapping a project:

- `templates/direnv/.envrc`
- `templates/direnv/.envrc.local.example`

Recommended pattern:

1. Check in `.envrc` with non-secret defaults and `source_env .envrc.local`.
2. Keep real secrets in `.envrc.local`.
3. Add `.envrc.local` to each project's `.gitignore`.
