{self, ...}: {
  system = {
    stateVersion = 5;
    primaryUser = "joey";
    configurationRevision = self.rev or self.dirtyRev or null;
  };

  system.startup.chime = false;

  system.defaults.CustomSystemPreferences = {
    "com.apple.windowserver" = {
      DisplayResolutionEnabled = true;
    };
  };
}
