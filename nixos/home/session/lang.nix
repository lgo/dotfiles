{config, ...}: {
  home.sessionVariables = {
    GOPATH = "${config.home.homeDirectory}/go";
    JAVA_HOME = "/usr/local/opt/openjdk@17";
  };
}
