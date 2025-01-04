{
    # Unstable nixpkgs repo
    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Disko repo. nixos-anywhere handles it.
    inputs.disko.url = "github:nix-community/disko";
    inputs.disko.inputs.nixpkgs.follows = "nixpkgs";

    outputs = { nixpkgs, disko, ... }: {
        nixosConfigurations.noCloud = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                disko.nixosModules.disko
                ./configuration.nix
                ./hardware-configuration.nix
                ./containers.nix
            ];
        };
    };
}