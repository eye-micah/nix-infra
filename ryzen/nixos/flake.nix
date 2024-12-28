{
    description = "Home Server Nix Config";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        compose2nix = {
            url = "github:aksiksi/compose2nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, ... } @ inputs: let
        inherit (self) outputs;
        systems = [
            "x86_64-linux"
        ];
    in {
        nixosConfigurations = {
            ryzen = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs outputs; };
                modules = [
                    ./configuration.nix
                ];
            };
        };
    };
}

