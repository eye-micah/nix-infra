{
  description = "Home Server Nix Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    compose2nix = {
      url = "github:aksiksi/compose2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Uncomment this if needed later
    # nixos-facter-modules = {
    #   url = "github:numtide/nixos-facter-modules";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, agenix, disko, ... }: let
    systems = [ "x86_64-linux" ];
    overlays = [
      agenix.overlay
      disko.overlay
    ];

    pkgs = import nixpkgs {
      inherit overlays;
      config.allowUnfree = true;
    };

    envVars = import ./env-vars.nix; # Ensure this file exists and returns a valid set
  in {
    nixosConfigurations = {
      ryzen = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit nixpkgs agenix disko envVars; # Remove 'inputs' from here
          inherit (self) inputs; # Explicitly include 'inputs' from the top-level scope
        };
        modules = [
          ./configuration.nix
          agenix.nixosModules.age
          disko.nixosModules.disko
          ./hardware-configuration.nix
        ];
      };
    };
  };
}


