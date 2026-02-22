{config, ...}: let
  userHome = config.users.users.joey.home;
in {
  system.defaults.CustomUserPreferences = {
    "net.retina.UTCMenuClock" = {
      ShowDate = false;
      ShowSeconds = false;
    };

    "com.googlecode.iterm2" = {
      PromptOnQuit = false;
      PrefsCustomFolder = "${userHome}/.dotfiles/tools/iterm/preferences";
      LoadPrefsFromCustomFolder = true;
    };

    "com.apple.systempreferences" = {
      DSKDesktopPrefPane = {
        UserFolderPaths = [
          "${userHome}/.dotfiles/tools/macos/desktop_backgrounds"
        ];
      };
    };

    "com.google.Chrome" = {
      AppleEnableSwipeNavigateWithScrolls = false;
    };

    "com.apple.PowerChime" = {
      ChimeOnNoHardware = true;
    };
  };
}
