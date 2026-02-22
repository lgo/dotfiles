{
  agenix,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    wezterm
    agenix.packages.${pkgs.system}.agenix
    ruby
    go-task
    arp-scan
    bazel
    clang-tools
    coreutils
    findutils
    gcc
    gradle
    gnugrep
    gnused
    gnupg
    jq
    maven
    colordiff
    curl
    gdb
    git
    go
    grc
    grpcurl
    htop
    kubectl
    llvm
    moreutils
    mosh
    nmap
    nodenv
    protobuf
    qemu
    rsync
    rustup
    scala
    tflint
    terminal-notifier
    watchman
    wget
    pre-commit
    alejandra
    shellcheck
    shfmt
    # Dev stuff
    # (agda.withPackages (p: [ p.standard-library ]))
    # google-cloud-sdk
    # haskellPackages.cabal-install
    # haskellPackages.hoogle
    # haskellPackages.hpack
    # haskellPackages.implicit-hie
    # haskellPackages.stack
    # idris2
    # jq
    # nodePackages.typescript
    # nodejs
    # purescript

    # Useful nix related tools
    # cachix # adding/managing alternative binary caches hosted by Cachix
    # comma # run software from without installing it
    # niv # easy dependency management for nix projects
    # nodePackages.node2nix
  ];
}
