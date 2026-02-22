{...}: {
  home.username = "joey";
  home.homeDirectory = "/Users/joey";

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
  targets.darwin.linkApps.enable = true;
  targets.darwin.linkApps.directory = "Applications/Nix Apps";
}
