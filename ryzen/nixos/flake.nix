{
    description = "Home Server Nix Config";

    inputs = {
        nixpkgs.url = "github.nixos/nixpkgs/nixos-unstable";
        compose2nix = {
            url = "github:aksiksi/compose2nix";
            inputs.nixpkgs.follows = "nixpkgs";
        }
    }

    outputs = {
        self,
        nixpkgs,
        ...
    } @ inputs: let
      inherit (self) outputs;
      systems = [
        "x86_64-linux"
      ]

      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
        nixosModules = import ./modules/nixos;

        nixosConfigurations = {
            ryzen = nixpkgs.lib.nixosSystem {
                specialArgs = {inherit inputs outputs;};
                modules = [
                    ./nixos/configuration.nix
                ];
            };
        };

    }
}