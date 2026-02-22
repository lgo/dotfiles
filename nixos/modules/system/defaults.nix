{config, ...}: let
  userHome = config.users.users.joey.home;
in {
  system.defaults.CustomUserPreferences = {
    NSGlobalDomain = {
      ApplePressAndHoldEnabled = false;
      NSScrollViewRubberbanding = 0;
      NSAutomaticWindowAnimationsEnabled = false;
      QLPanelAnimationDuration = 0.0;
      NSWindowResizeTime = 0.001;
      NSDocumentSaveNewDocumentsToCloud = false;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSQuitAlwaysKeepsWindows = false;
      NSDisableAutomaticTermination = true;
      NSUseAnimatedFocusRing = false;
      "com.apple.swipescrolldirection" = false;
      "com.apple.springing.enabled" = true;
      "com.apple.springing.delay" = 0.0;
      AppleShowAllExtensions = true;
      AppleMetricUnits = true;
      AppleMeasurementUnits = "Centimeters";
      AppleICUForce24HourTime = true;
      WebKitDeveloperExtras = true;
      "com.apple.mouse.tapBehavior" = 1;
    };

    "com.apple.dashboard" = {
      "mcx-disabled" = true;
    };

    "com.apple.loginwindow" = {
      PowerButtonSleepsSystem = false;
    };

    "com.apple.helpviewer" = {
      DevMode = true;
    };

    "com.apple.CrashReporter" = {
      UseUNC = 1;
    };

    "com.apple.BluetoothAudioAgent" = {
      "Apple Bitpool Min (editable)" = 40;
    };

    "com.apple.screensaver" = {
      askForPassword = 1;
      askForPasswordDelay = 0;
    };

    "com.apple.screencapture" = {
      location = "${userHome}/Desktop";
      type = "png";
      "disable-shadow" = true;
    };

    "com.apple.desktopservices" = {
      DSDontWriteNetworkStores = true;
      DSDontWriteUSBStores = true;
    };

    "com.apple.appstore" = {
      WebKitDeveloperExtras = true;
      ShowDebugMenu = true;
    };

    "com.apple.SoftwareUpdate" = {
      AutomaticCheckEnabled = true;
      ScheduleFrequency = 1;
      AutomaticDownload = 1;
      CriticalUpdateInstall = 1;
      ConfigDataInstall = 1;
    };

    "com.apple.commerce" = {
      AutoUpdate = true;
    };

    "com.apple.ActivityMonitor" = {
      OpenMainWindow = true;
      IconType = 5;
      ShowCategory = 0;
      SortColumn = "CPUUsage";
      SortDirection = 0;
    };

    "com.apple.menuextra.clock" = {
      Date = "EEE MMM d  H:mm";
    };

    "com.apple.TimeMachine" = {
      DoNotOfferNewDisksForBackup = true;
    };
  };
}
