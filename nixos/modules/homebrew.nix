{...}: let
  # Formulae that currently need Homebrew either for cask/app integration,
  # service ergonomics, or because we intentionally keep them outside nixpkgs.
  mustStayBrewBrews = [
    "openjdk"
    "awscli"
    "bash"
    {
      name = "bash-completion@2";
      link = false;
    }
    {
      name = "docker";
      link = false;
    }
    {
      name = "postgresql";
      restart_service = true;
    }
    {
      name = "redis";
      restart_service = true;
    }
    {
      name = "wireshark";
      link = false;
    }
    {
      name = "yarn";
      link = false;
    }
    "zsh"
  ];

  # Formulae to migrate to nixpkgs over time. Kept here intentionally until
  # each workflow is validated under Nix.
  migrateToNixBrews = [
    "python@3.13"
    "node"
    "bfg"
    "woof"
  ];
in {
  homebrew = {
    enable = true;
    user = "joey";
    brewPrefix = "/opt/homebrew/bin";

    global = {
      brewfile = true;
      autoUpdate = false;
      lockfiles = false;
    };

    onActivation = {
      autoUpdate = false;
      upgrade = false;
      # Intentionally aggressive: remove any unmanaged formulae/casks so the machine
      # stays consistent with this repo's declared `brews`/`casks`.
      cleanup = "zap";
    };

    taps = [];

    brews = mustStayBrewBrews ++ migrateToNixBrews;

    casks = [
      "aerial"
      "blockblock"
      "font-source-code-pro"
      "hammerspoon"
      "macfuse"
      "ngrok"
      "spatial"
      "transmission"
      "virtualbox"
      "vlc"
      "wireshark"
      "codex"
    ];
  };
}
