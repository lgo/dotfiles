{config, ...}: let
  dotfilesDir = "${config.home.homeDirectory}/.dotfiles";
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
in {
  home.file.".gitconfig".source = mkOutOfStoreSymlink "${dotfilesDir}/tools/git/gitconfig";
  home.file.".gitignore_global".source = mkOutOfStoreSymlink "${dotfilesDir}/tools/git/gitignore_global";
}
