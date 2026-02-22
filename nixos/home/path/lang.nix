{config, ...}: {
  home.sessionPath = [
    "${config.home.homeDirectory}/go/bin"
    "/usr/local/opt/openjdk@17/bin"
  ];
}
