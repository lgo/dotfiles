{config, ...}: let
  dotfilesDir = "${config.home.homeDirectory}/.dotfiles";
in {
  home.sessionPath = [
    "${config.home.homeDirectory}/.bin"
    "${config.home.homeDirectory}/.local/bin"
    "${dotfilesDir}/bin"
  ];
}
