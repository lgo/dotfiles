{
  config,
  pkgs,
  lib,
  ...
}: {
  nix.enable = false;

  # Enable flakes globally.
  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.etc."nix/nix.custom.conf".text = ''
    # Managed by nix-darwin (Determinate Nix reads this via nix.conf).
    trusted-users = root @admin ${config.system.primaryUser or "joey"}
  '';

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  nix.package = pkgs.nix;
}
