{
  config,
  lib,
  ...
}: let
  dotfilesDir = "${config.home.homeDirectory}/.dotfiles";
  zshInitSnippetPaths = [
    "${dotfilesDir}/tools/zsh/config.zsh"
    "${dotfilesDir}/tools/zsh/fpath.zsh"
    "${dotfilesDir}/tools/zsh/completion.zsh"
    "${dotfilesDir}/tools/zsh/history.zsh"
    "${dotfilesDir}/tools/zsh/window.zsh"
    "${dotfilesDir}/tools/zsh/grc.zsh"
    "${dotfilesDir}/tools/zsh/fzf.zsh"
    "${dotfilesDir}/tools/git/zsh/prompt.zsh"
    "${dotfilesDir}/tools/zsh/aliases.zsh"
    "${dotfilesDir}/tools/git/zsh/aliases.zsh"
    "${dotfilesDir}/tools/java/zsh/aliases.zsh"
    "${dotfilesDir}/tools/tailscale/zsh/aliases.zsh"
    "${dotfilesDir}/tools/editors/cursor/zsh/aliases.zsh"
  ];
  zshInitExtra = lib.concatStringsSep "\n" (map (path: ''source "${path}"'') zshInitSnippetPaths);
in {
  programs.zsh = {
    enable = true;
    enableCompletion = false;
    autosuggestion.enable = true;
    # From zsh/.zprofile.
    profileExtra = lib.fileContents ../../../files/zsh/profile-extra.zsh;
    # From zsh/.zshenv.
    envExtra = lib.fileContents ../../../../zsh/.zshenv;
    # From zsh/.zlogin.
    loginExtra = lib.fileContents ../../../../zsh/.zlogin;
    # From zsh/.zlogout.
    logoutExtra = lib.fileContents ../../../../zsh/.zlogout;

    initContent = lib.mkMerge [
      (lib.mkBefore (lib.fileContents ../../../files/zsh/init-extra-first.zsh))
      (lib.mkAfter ''
        # From zsh/.zshrc (main init section).
        ${lib.fileContents ../../../files/zsh/init-extra.zsh}
        ${zshInitExtra}
        # From zsh/.zshrc (post-init section).
        ${lib.fileContents ../../../files/zsh/init-extra-post.zsh}
      '')
    ];
  };
}
