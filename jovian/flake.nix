{

    inputs = {

        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        #deploy-rs.url = "github:serokell:deploy-rs";

        home-manager = {
            url = "github:nix-community/home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        jovian = {
            url = "github:Jovian-Experiments/Jovian-NixOS";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        disko = {
            url = github:nix-community/disko;
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    description = "Deployment of NixOS configuration for gaming PC";

    outputs = { 
        self, 
        nixpkgs, 
        home-manager,
        jovian, 
        disko,
        ... 
    } @ inputs: let
        inherit (self) outputs;
        systems = [
            "x86_64-linux"
        ];

        forAllSystems = nixpkgs.lib.genAttrs systems;

    in {
        nixosConfigurations = {
            pc = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";

                specialArgs = {
                    inputs = inputs;
                    outputs = outputs;
                };

                modules = [
                    inputs.jovian.nixosModules.default
                    inputs.disko.nixosModules.default
                    ./jovian-pc/configuration.nix
                    ./jovian-pc/boot.nix
                    ./jovian-pc/disko.nix
                ];
            };
        };
    };
}