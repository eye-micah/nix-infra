{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:

let
  envVars = import ./env-vars.nix; 
  secretVars = import ./secret-vars.age;
in
{

  environment.etc."secret-vars.nix".source = "./secret-vars.age";

  imports = [
    ./hardware-configuration.nix
    ./bootloader.nix
    ./zfs.nix
    # ./provision.nix 
    # (import ./provision.nix { inherit envVars pkgs inputs; })
  ];

  environment.systemPackages = with pkgs; [ agenix zfs ];

  networking = {
    hostId = "009f33be";
    useDHCP = true;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
  };

  system = {
    stateVersion = "25.05";
    autoUpgrade.enable = true;
  };

  users = {
    users.${envVars.adminUser} = {
      isSystemUser = true;
      shell = pkgs.zsh;
      extraGroups = [ "wheel" ];
      hashedPassword = "${secretVars.adminPassword}";	
      uid = 1000;
    };

    users.${envVars.rootlessDockerUser} = {
      isNormalUser = true;
      shell = pkgs.bash;
      extraGroups = [ "video" "render" ];
      uid = 1001;
    };
  };
}
