{username, ...}: {
  nix-homebrew = {
    enable = true;
    # Keep using the native ARM Homebrew prefix.
    enableRosetta = false;
    user = username;
  };
}
