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
in
{

  imports = [
    ./modules/disk-config.nix
    ./modules/zfs.nix
    # ./provision.nix 
    # (import ./provision.nix { inherit envVars pkgs inputs; })
  ];

#  age.secrets = {
#    "secret-vars.age" = {
#      file = ./secret-vars.age;
#      recipients = [
#        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHFQy6Jw3QC3ADSbNdRZZSTZMOwB7o/+SQatG4Er2gtC micah@haruka.tail8d76a.ts.net"
#      ];
#    };
#  };

#  environment.systemPackages = with pkgs; [ agenix zfs ];

  disko.devices.disk.main.device = "/dev/sda";

  nixpkgs.config.allowUnfree = true;

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
    groups.${envVars.adminUser} = {};
    users.${envVars.adminUser} = {
      isSystemUser = true;
      shell = pkgs.zsh;
      extraGroups = [ "wheel" ];
      #hashedPassword = "${secretVars.adminPassword}";	
      hashedPassword = "$6$ytTUaT6RAM9I75hu$nzRy./0A7Xz8EiUG1Bn/PBQvSS5Ng7Ui5STlm0Yt1keVFh2d2tjYZjuYGmoY36irrAZdDoEDjDoQRdPT0vNb9/";
      uid = 1000;
      group = "${envVars.adminUser}";
    };

    users.${envVars.rootlessDockerUser} = {
      isNormalUser = true;
      shell = pkgs.bash;
      extraGroups = [ "video" "render" ];
      uid = 1001;
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

}
