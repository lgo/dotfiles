{config, ...}: let
  dotfilesDir = "${config.home.homeDirectory}/.dotfiles";
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
in {
  home.file."Library/Application Support/Alfred/Alfred.alfredpreferences".source =
    mkOutOfStoreSymlink "${dotfilesDir}/tools/alfred/Alfred.alfredpreferences";
}
