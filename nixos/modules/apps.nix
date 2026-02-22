{
  config,
  lib,
  pkgs,
  ...
}: let
  primaryUser = config.system.primaryUser or "joey";
  userHome = config.users.users.${primaryUser}.home;
in {
  environment.systemPackages = [
    pkgs.coreutils
    pkgs.curl
    pkgs.wget
    pkgs.k9s
    pkgs.kubectl
    pkgs.htop
    pkgs.git
    pkgs.nodejs
    pkgs.jq
    pkgs.yq
    pkgs.ripgrep
    pkgs.starship
    pkgs.antidote
    pkgs.m-cli
    pkgs.vim
    pkgs.terraform
    pkgs.uv
    pkgs.python314
    pkgs.qpdf
    # pkgs.wezterm
  ];

  environment.pathsToLink = ["/Applications"];

  system.activationScripts.applications.text = lib.mkForce ''
    # Set up applications.
    echo "setting up /Applications/Nix Apps..." >&2

    ourLink () {
      local link
      link=$(readlink "$1")
      [ -L "$1" ] && [ "''${link#*-}" = 'system-applications/Applications' ]
    }

    # Clean up for links created at the old location in HOME.
    if ourLink "${userHome}/Applications"; then
      rm "${userHome}/Applications"
    elif ourLink "${userHome}/Applications/Nix Apps"; then
      rm "${userHome}/Applications/Nix Apps"
    fi

    app_dir="/Applications/Nix Apps"
    run_dir="/run/current-system/sw/Applications"
    user_app_dir="${userHome}/Applications/Nix Apps"
    rm -rf "$app_dir"
    mkdir -p "$app_dir"
    for src_dir in "$run_dir" "$user_app_dir"; do
      if [ -d "$src_dir" ]; then
        for app in "$src_dir"/*.app; do
          [ -e "$app" ] || continue
          ln -s "$app" "$app_dir/$(basename "$app")"
        done
      fi
    done
  '';
}
