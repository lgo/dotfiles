{
  description = "pollen nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";

    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    home-manager,
    nixpkgs
  }:
  let
    username = "joey";
    useremail = "joey@pereira.io";
    specialArgs =
      inputs
      // {
        inherit username useremail;
      };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#pollen
    darwinConfigurations."pollen" = nix-darwin.lib.darwinSystem {
      inherit specialArgs;
      system = "x86_64-darwin";
      modules = [
        ./modules/nix-core.nix
        ./modules/system.nix
        ./modules/apps.nix
        ./modules/users.nix
        # ./configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.joey = import ./home.nix;
        }
      ];
    };
  };
}
