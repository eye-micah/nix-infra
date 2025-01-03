{
  description = "Darwin configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";
  };

  outputs = inputs@{ nixpkgs, home-manager, darwin, agenix, ... }: {
    homeConfigurations = {
      micah = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        users = {
          micah = import ./home.nix;
        };
      };
    };
    darwinConfigurations = {
      haruka = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          #./configuration.nix
          ./darwin.nix
          agenix.nixosModules.default
          {
            environment.systemPackages = [ agenix.packages.aarch64-darwin.default ];
          }
          home-manager.darwinModules.home-manager
          {
            users.users.micah.home = "/Users/micah";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.micah = import ./home.nix ;
            
            # Optionally, use home-manager.extraSpecialArgs to pass

            # arguments to home.nix
          }
        ];
      };
    };
  };
}
