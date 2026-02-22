{config, ...}: let
  dotfilesDir = "${config.home.homeDirectory}/.dotfiles";
in {
  home.sessionVariables = {
    DOTFILES = dotfilesDir;
    EDITOR = "vim";
    LSCOLORS = "exfxcxdxbxegedabagacad";
    CLICOLOR = "true";
    K9S_CONFIG_DIR = "${config.home.homeDirectory}/.config/k9s";
  };
}
