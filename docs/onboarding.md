# Onboarding (First 5 Minutes)

From a fresh machine:

```bash
cd ~/.dotfiles
./bin/first-5-minutes
```

What it does:

1. Runs `darwin-rebuild build --flake ./nixos#sprout`.
2. Verifies key binaries (`zsh`, `git`, `ruby`, `task`, `direnv`).
3. Confirms Home Manager shell symlink wiring.
4. Installs git hooks via `./bin/setup-pre-commit` when available.
5. Prints next-step activation commands.
