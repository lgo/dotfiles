{config, ...}: let
  dotfilesDir = "${config.home.homeDirectory}/.dotfiles";
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
in {
  home.file.".hammerspoon".source =
    mkOutOfStoreSymlink "${dotfilesDir}/tools/hammerspoon/hammerspoon";
}
