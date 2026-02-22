{
  lib,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      resurrect
      continuum
    ];
    extraConfig = lib.fileContents ../../../../tools/tmux/tmux.conf;
  };
}
