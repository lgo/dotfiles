{config, ...}: let
  dotfilesDir = "${config.home.homeDirectory}/.dotfiles";
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
in {
  home.file.".config/k9s/config.yaml".source =
    mkOutOfStoreSymlink "${dotfilesDir}/tools/k9s/config.yaml";
  home.file.".config/k9s/skins/solarized-light.yaml".source =
    mkOutOfStoreSymlink "${dotfilesDir}/tools/k9s/skins/solarized-light.yaml";
}
