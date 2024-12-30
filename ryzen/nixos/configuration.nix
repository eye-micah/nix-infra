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
  secretVars = import ./secret-vars.nix;
in
{

  environment.etc."secret-vars.nix".source = "./secrets/secret-vars.age";

  imports = [
    ./hardware-configuration.nix
    ./modules/bootloader.nix
    # ./modules/agenix.nix
    ./modules/zfs.nix
    # ./provision.nix 
    # (import ./provision.nix { inherit envVars pkgs inputs; })
  ];

  age.secrets = {
    "secret-vars.age" = {
      file = ./secret-vars.age;
      recipients = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHFQy6Jw3QC3ADSbNdRZZSTZMOwB7o/+SQatG4Er2gtC micah@haruka.tail8d76a.ts.net"
      ];
    };
  };

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
