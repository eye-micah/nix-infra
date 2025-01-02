{
  description = "Home Server Nix Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    compose2nix = {
      url = "github:aksiksi/compose2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, agenix, disko, ... } @ inputs: let
    inherit (self) outputs;
    systems = [
      "x86_64-linux"
    ];
    overlays = [ agenix.overlay disko.overlay ];

    pkgs = import nixpkgs {
      inherit overlays;
      config = { allowUnfree = true; };
    };

    envVars = import ./env-vars.nix; # Non-secret environment variables.
  in {
    nixosConfigurations = {
      ryzen = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs outputs envVars agenix; };
        modules = [
          ./configuration.nix
          nixos-facter-modules.nixosModules.facter
+         { config.facter.reportPath = ./facter.json }
          agenix.nixosModules.age
          disko.nixosModules.disko
        ];
      };
    };
  };
}
