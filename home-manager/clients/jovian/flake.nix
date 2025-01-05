{

    inputs = {

        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        deploy-rs.url = "github:serokell;deploy-rs";

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

    outputs = { self, nixpkgs, deploy-rs }: {
        nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [ ./configuration.nix ];
        };

        deploy.nodes.pc = {
            hostname = "pc";
            profiles.system = {
                user = "steamuser";
                path = deploy-rs.lib.x86_64-linux.activate.nixos self
            };
        };

            checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };

    outputs = 
        { ... }@inputs:
        let
            helpers = import ./flakeHelpers.nix inputs;
            inherit (helpers) mkMerge mkNixos mkLinux mkDarwin;
        in 
        mkMerge [
            (mkNixos "pc" inputs.nixpkgs [
                # ./modules/whatever
                inputs.jovian.nixosModules.default
                # inputs.home-manager.nixosModules.home-manager
            ])
        ];
}