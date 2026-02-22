{
  pkgs,
  self,
  ...
}: {
  users.users.joey = {
    home = "/Users/joey";
  };
}
