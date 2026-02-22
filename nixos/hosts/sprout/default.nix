{
  agenix,
  home-manager,
  nix-homebrew,
  username,
  useremail,
  ...
}: {
  imports = [
    ../../modules/nix-core.nix
    ../../modules/system.nix
    ../../modules/apps.nix
    ../../modules/fonts.nix
    nix-homebrew.darwinModules.nix-homebrew
    ../../modules/nix-homebrew.nix
    ../../modules/homebrew.nix
    ../../modules/users.nix
    agenix.nixosModules.default
    home-manager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "nixbak";
      home-manager.extraSpecialArgs = {inherit agenix username useremail;};
      home-manager.users.joey = import ../../home.nix;
    }
  ];
}
