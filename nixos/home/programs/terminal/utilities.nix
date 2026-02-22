{...}: {
  # eza (modern ls replacement)
  programs.eza.enable = true;
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "rg --files --hidden --follow --glob '!.git/*'";
    fileWidgetCommand = "rg --files --hidden --follow --glob '!.git/*'";
    defaultOptions = [
      "--height=40%"
      "--layout=reverse"
      "--border"
    ];
  };
  programs.bat = {
    enable = true;
    # Beginner-friendly defaults: close to `cat`, but still syntax-aware.
    config = {
      paging = "never";
      style = "plain";
      theme = "ansi";
    };
  };

  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # Fast directory jumping.
  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;
  programs.zoxide.options = ["--cmd cd"];

  # Better shell history UX.
  programs.atuin.enable = true;
  programs.atuin.enableZshIntegration = true;
  programs.atuin.settings = {
    auto_sync = false;
    update_check = false;
    filter_mode = "global";
    style = "compact";
  };

  # Fast `find` replacement with useful defaults.
  programs.fd.enable = true;
  programs.fd.hidden = true;
  programs.fd.ignores = [
    ".git/"
    ".direnv/"
    "node_modules/"
  ];

  # Htop
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;
}
