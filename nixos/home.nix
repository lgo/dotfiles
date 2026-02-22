{...}: {
  # https://github.com/malob/nixpkgs/blob/master/home/default.nix

  imports = [
    ./home/core.nix
    ./home/session.nix
    ./home/path.nix
    ./home/programs/shell/zsh.nix
    ./home/tools/default.nix
    ./home/files.nix
    ./home/programs/editor/editors.nix
    ./home/programs/version-control/git.nix
    ./home/programs/terminal/tmux.nix
    ./home/programs/terminal/utilities.nix
    ./home/packages.nix
  ];
}
