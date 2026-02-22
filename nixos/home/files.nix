{config, ...}: let
  dotfilesDir = "${config.home.homeDirectory}/.dotfiles";
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
in {
  home.file.".zsh_plugins.txt".source = mkOutOfStoreSymlink "${dotfilesDir}/tools/zsh/antidote/zsh_plugins.txt";
  home.file.".ignore".source = mkOutOfStoreSymlink "${dotfilesDir}/tools/zsh/global_ignore";
  # Keep bash rc files present (some tools still drop bash snippets), but manage
  # them declaratively rather than symlinking repo files.
  home.file.".bashrc".text = ''
    # Managed by Home Manager (intentionally minimal).
  '';
  home.file.".bash_profile".text = ''
    # Managed by Home Manager (intentionally minimal).
  '';
  home.file.".config/starship.toml".source =
    mkOutOfStoreSymlink "${dotfilesDir}/tools/zsh/starship.toml";

  # Misc configuration files --------------------------------------------------------------------{{{

  # https://docs.haskellstack.org/en/stable/yaml_configuration/#non-project-specific-config
  # home.file.".stack/config.yaml".text = lib.generators.toYAML {} {
  #   templates = {
  #     scm-init = "git";
  #     params = {
  #       author-name = "Your Name"; # config.programs.git.userName;
  #       author-email = "youremail@example.com"; # config.programs.git.userEmail;
  #       github-username = "yourusername";
  #     };
  #   };
  # };
}
