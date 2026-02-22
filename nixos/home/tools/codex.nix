{config, ...}: let
  dotfilesDir = "${config.home.homeDirectory}/.dotfiles";
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
in {
  home.file.".codex/config.toml".source =
    mkOutOfStoreSymlink "${dotfilesDir}/tools/codex/config.toml";
}
