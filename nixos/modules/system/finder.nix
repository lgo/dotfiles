{config, ...}: let
  userHome = config.users.users.joey.home;
in {
  system.defaults.CustomUserPreferences = {
    "com.apple.finder" = {
      FXPreferredViewStyle = "Nlsv";
      FXInfoPanesExpanded = {
        General = true;
        OpenWith = true;
        Privileges = true;
      };
      NewWindowTarget = "PfLo";
      NewWindowTargetPath = "file://${userHome}/";
      ShowExternalHardDrivesOnDesktop = false;
      ShowHardDrivesOnDesktop = false;
      ShowMountedServersOnDesktop = false;
      ShowRemovableMediaOnDesktop = false;
      ShowStatusBar = true;
      ShowPathbar = true;
      _FXShowPosixPathInTitle = true;
      _FXSortFoldersFirst = true;
      FXDefaultSearchScope = "SCcf";
      FXEnableExtensionChangeWarning = false;
      FXEnableRemoveFromICloudDriveWarning = false;
      DisableAllAnimations = true;
      AppleShowAllFiles = true;
      WarnOnEmptyTrash = false;
      CreateDesktop = false;
      QuitMenuItem = true;
    };
  };
}
