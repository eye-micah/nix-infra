{

    inputs = {

        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        deploy-rs.url = "github:serokell:deploy-rs";

        home-manager = {
            url = "github:nix-community/home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        jovian = {
            url = "github:Jovian-Experiments/Jovian-NixOS";
            inputs.nixpkgs.follows = "nixpkgs";
        }

    };

    description = "Deployment of NixOS configuration for gaming PC";

    outputs = { 
        self, 
        nixpkgs, 
        home-manager, 
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

                specialArgs = {inherit inputs outputs;};

                modules = genericModules ++ [./jovian-pc];
            }
        }
    }
}